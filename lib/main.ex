#
# This file is part of AtomBot.
#
# Copyright 2020 Davide Bettio
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

defmodule Main do
  @motor_a_pwm_gpio 14
  @motor_a_in1_gpio 26
  @motor_a_in2_gpio 27

  @motor_b_pwm_gpio 25
  @motor_b_in1_gpio 32
  @motor_b_in2_gpio 33

  def start() do
    :erlang.display("Hello")

    motor_a_pwm_timer = [
      duty_resolution: 8,
      freq_hz: 2000,
      speed_mode: 0,
      timer_num: 0
    ]

    :ok = :ledc.timer_config(motor_a_pwm_timer)

    channel_config = [
      channel: 0,
      duty: 250,
      gpio_num: @motor_a_pwm_gpio,
      speed_mode: 0,
      hpoint: 0,
      timer_sel: 0
    ]

    :ok = :ledc.channel_config(channel_config)

    channel_config = [
      channel: 0,
      duty: 250,
      gpio_num: @motor_b_pwm_gpio,
      speed_mode: 0,
      hpoint: 0,
      timer_sel: 0
    ]

    :ok = :ledc.channel_config(channel_config)

    gpio = GPIO.open()
    GPIO.set_direction(gpio, @motor_a_in1_gpio, :output)

    GPIO.set_direction(gpio, @motor_a_in2_gpio, :output)
    GPIO.set_level(gpio, @motor_a_in2_gpio, 0)

    GPIO.set_direction(gpio, @motor_b_in1_gpio, :output)

    GPIO.set_direction(gpio, @motor_b_in2_gpio, :output)
    GPIO.set_level(gpio, @motor_b_in2_gpio, 0)

    loop(gpio, 1)
  end

  def sleep(1), do: :timer.sleep(800)

  def sleep(0), do: :timer.sleep(10000)

  def loop(gpio, n) do
    GPIO.set_level(gpio, @motor_a_in1_gpio, n)
    GPIO.set_level(gpio, @motor_b_in1_gpio, n)
    sleep(n)
    loop(gpio, 1 - n)
  end
end
