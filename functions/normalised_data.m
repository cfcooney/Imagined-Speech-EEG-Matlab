function norm_value = normalised_data(x)
% Function to normalise EEG data between -1 and +1
%     
%     INPUTS
%     x = feature-set derived from EEG data
%
%     OUTPUTS
%     norm_value = normalised values for all features.
%
%     Name: Ciaran Cooney
%     Date: 02/03/2018

if abs(min(x)) > max(x)
      max_range_value = abs(min(x));
      min_range_value = min(x);
  else
      max_range_value = max(x);
      min_range_value = -max(x);
end
norm_value = 2 .* x ./ (max_range_value - min_range_value);
