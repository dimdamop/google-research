# Copyright 2024 The Google Research Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash
for split_no in $(seq 0 4)
do
  for pair_no in $(seq 0 51)
  do
    for bag_size in 64 128 256 512
    do
      python3 mean_map_comp/fixed_size_feature_bags_ds/pismatrix.py --which_split=$split_no --which_pair=$pair_no --which_size=$bag_size
    done
  done
done

list_num_segs=(40 20 10 5)

for split_no in $(seq 0 4)
do
  for pair_no in $(seq 0 51)
  do
    for size in $(seq 0 3)
    do
      num_segs=${list_num_segs[$size]}
      for seg_no in $(seq 0 $num_segs)
      do
        python3 mean_map_comp/fixed_size_feature_bags_ds/partial_sums.py --which_split=$split_no --which_pair=$pair_no --which_seg=$seg_no --which_size=$size
      done
    done
  done
done

for split_no in $(seq 0 4)
do
  for pair_no in $(seq 0 51)
  do
    for bag_size in 64 128 256 512
    do
      python3 mean_map_comp/fixed_size_feature_bags_ds/full_vecs.py --which_split=$split_no --which_pair=$pair_no --which_size=$bag_size
    done
  done
done