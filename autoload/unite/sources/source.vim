"=============================================================================
" FILE: source.vim
" AUTHOR:  Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 25 Nov 2010
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

function! unite#sources#source#define()"{{{
  return s:source
endfunction"}}}

let s:source = {
      \ 'name' : 'source',
      \ 'description' : 'candidates from sources list',
      \ 'action_table' : {},
      \ 'default_action' : { 'common' : 'start' },
      \}

function! s:source.gather_candidates(args, context)"{{{
  return map(sort(values(unite#available_sources()), 's:compare_sources'), '{
        \ "word" : v:val.name,
        \ "abbr" : unite#util#truncate(v:val.name, 25) . (v:val.description != "" ? " -- " . v:val.description : ""),
        \ "source" : "source",
        \ "action__source_name" : v:val.name,
        \}')
endfunction"}}}

" Actions"{{{
let s:action_table = {}

let s:action_table.start = {
      \ 'description' : 'start source',
      \ 'is_selectable' : 1,
      \ }
function! s:action_table.start.func(candidates)"{{{
  call unite#start(map(copy(a:candidates), 'v:val.action__source_name'), unite#get_context())
endfunction"}}}

let s:source.action_table['*'] = s:action_table
"}}}

function! s:compare_sources(source_a, source_b) "{{{
  return a:source_a.name - a:source_b.name
endfunction"}}}

" vim: foldmethod=marker
