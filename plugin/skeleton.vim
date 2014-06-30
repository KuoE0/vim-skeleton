" Skeleton:    Initialize new Vim buffers with file-type-specific templates
" Maintainer:  Noah Frederick (http://noahfrederick.com)

if (exists('g:loaded_skeleton') && g:loaded_skeleton) || &cp
  finish
endif
let g:loaded_skeleton = 1

""
" @section Introduction, intro
" @stylized Skeleton
" @plugin(stylized) initializes new Vim buffers with file-type-specific
" templates.
"
" Add something like the following to ~/.vim/templates/skel.xml:
" >
"   <?xml version="1.0" encoding="UTF-8" ?>
"   <@BASENAME@>
"       @CURSOR@
"   </@BASENAME@>
" <
" And when you create a new buffer, e.g., books.xml, it will be initialized
" with your template:
" >
"   <?xml version="1.0" encoding="UTF-8" ?>
"   <books>
"       [cursor is here]
"   </books>
" <
" It differs from a snippet plug-in in that it is concerned with initializing
" new buffers with boilerplate text without any manual intervention such as
" triggering a snippet.
"
" @plugin(stylized) stays out of your way: it will never load a template
" unless the buffer is empty and is not associated with an existing file on
" disk. And if you don't happen to want to use the template for a particular
" file, issuing |undo| (u) will restore your empty buffer.
"
" This plug-in is only available if 'compatible' is not set.

if !exists('g:skeleton_template_dir')
  ""
  " The directory that contains skeleton template files. Example:
  " >
  "   let g:skeleton_template_dir = "~/.vim/templates"
  " <
  " Default: "~/.vim/templates"
  let g:skeleton_template_dir = '~/.vim/templates'
endif

if ! exists("g:skeleton_replacements")
  ""
  " Dictionary of custom global replacement functions. Each function should be
  " named after the corresponding template placeholder, and should return the
  " value with which the placeholder will be substituted. For example:
  " >
  "   function! g:skeleton_replacements.TITLE()
  "     return "The Title"
  "   endfunction
  " <
  " Registering the above function would replace the @TITLE@ placeholder with
  " the return value, "The Title".
  "
  " Default: {}
  let g:skeleton_replacements = {}
endif

augroup Skeleton
  autocmd!
  autocmd BufNewFile * call skeleton#LoadByFilename(expand('<amatch>'))
  autocmd FileType   * call skeleton#LoadByFiletype(expand('<amatch>'), expand('<afile>'))
augroup END

""
" Edits the active template file.
command! -bang -bar SkelEdit execute skeleton#EditCurrentTemplate('edit<bang>')
