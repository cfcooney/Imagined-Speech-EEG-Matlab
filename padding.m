%function for zero-padding windows into 500 sample bins
function window = padding(window,len)
if nargin<2, len = 500; end

n = len - length(window);
x = window';
w_pad = padarray(x,n,'post');
window = w_pad';