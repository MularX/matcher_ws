-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- /* Author: Darby Lim */

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",                -- Frame for the global map
  tracking_frame = "base_link",     -- Frame of the robot’s base (sensor origin)
  published_frame = "base_link",    -- Frame to publish (typically base_link or odom)
  odom_frame = "odom",              -- Frame for odometry (changed to use odometry)
  provide_odom_frame = true,       -- Set to false since odom is provided externally
  publish_frame_projected_to_2d = true, -- Project poses to 2D for 2D SLAM
  use_odometry = false,              -- Enable odometry (changed to true)
  use_nav_sat = false,              -- No GPS data
  use_landmarks = false,            -- No landmark data
  num_laser_scans = 1,              -- Single laser scanner
  num_multi_echo_laser_scans = 0,   -- No multi-echo scans
  num_subdivisions_per_laser_scan = 1, -- No subdivisions needed
  num_point_clouds = 0,             -- No 3D point clouds
  lookup_transform_timeout_sec = 0.2, -- Timeout for transform lookup (slightly increased)
  submap_publish_period_sec = 0.3,   -- Frequency of submap publishing
  pose_publish_period_sec = 5e-3,   -- Frequency of pose publishing (200 Hz)
  trajectory_publish_period_sec = 30e-3, -- Frequency of trajectory publishing
  rangefinder_sampling_ratio = 1.0, -- Use all laser scans
  odometry_sampling_ratio = 1.0,    -- Use all odometry data
  fixed_frame_pose_sampling_ratio = 1.0, -- Use all fixed frame poses
  imu_sampling_ratio = 1.0,         -- Use all IMU data (if used)
  landmarks_sampling_ratio = 1.0,   -- Use all landmarks (if used)
}

-- Map builder configuration
MAP_BUILDER.use_trajectory_builder_2d = true

-- Trajectory builder (2D) configuration
TRAJECTORY_BUILDER_2D.min_range = 0.12            -- Minimum laser range (meters)
TRAJECTORY_BUILDER_2D.max_range = 3.5             -- Maximum laser range (meters)
TRAJECTORY_BUILDER_2D.missing_data_ray_length = 3.0 -- Ray length for missing data
TRAJECTORY_BUILDER_2D.use_imu_data = false        -- No IMU data
TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true -- Use scan matching
TRAJECTORY_BUILDER_2D.motion_filter.max_angle_radians = math.rad(0.1) -- Motion filter threshold

-- Pose graph configuration
POSE_GRAPH.constraint_builder.min_score = 0.65     -- Minimum score for constraints
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.7 -- Min score for global localization
POSE_GRAPH.optimize_every_n_nodes = 90            -- Optimize pose graph every 90 nodes (default value)

return options
