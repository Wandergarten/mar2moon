form GetFile
	text filename D:\nlp_project_d\podcast_data\extracted_clips\Altcoin_Daily_20210401_ETH_to_CRUSH_Bitcoin_(Top_Expert_Prediction)_Bitcoin_Proponent_EXPLAINS_on_Lex_Fridman_Podcast_00.00.19.760_00.00.27.920.wav
endform

Read from file... 'filename$'

# F0 Values

To Pitch: 0.0, 75, 600
pitch_min = Get minimum: 0.0, 0.0, "Hertz", "parabolic"
pitch_max = Get maximum: 0.0, 0.0, "Hertz", "parabolic"
pitch_05_quantile = Get quantile: 0.0, 0.0, 0.05, "Hertz"
pitch_95_quantile = Get quantile: 0.0, 0.0, 0.95, "Hertz"
pitch_05_95_range = pitch_95_quantile - pitch_05_quantile
pitch_stdev = Get standard deviation: 0.0, 0.0, "Semitones"
pitch_mean = Get mean: 0.0, 0.0, "Hertz"
pitch_50_quantile = Get quantile: 0.0, 0.0, 0.5, "Hertz"

# Jitter and Shimmer

plusObject: 1
To PointProcess (cc)

jitter = Get jitter (local): 0.0, 0.0, 0.0001, 0.02, 1.3

plusObject: 1
shimmer = Get shimmer (local): 0.0, 0.0, 0.0001, 0.02, 1.3, 1.6

# Hammarberg index

selectObject: 1
To Ltas: 100

low_band = Get maximum: 0, 2000, "Parabolic"
high_band = Get maximum: 2000, 5000, "Parabolic"
hammarberg = low_band - high_band


result_string$ = string$ (pitch_min)
result_string$ += "," + string$ (pitch_max)
result_string$ += "," + string$ (pitch_05_quantile)
result_string$ += "," + string$ (pitch_95_quantile)
result_string$ += "," + string$ (pitch_05_95_range)
result_string$ += "," + string$ (pitch_stdev)
result_string$ += "," + string$ (pitch_mean)
result_string$ += "," + string$ (pitch_50_quantile)
result_string$ += "," + string$ (jitter)
result_string$ += "," + string$ (shimmer)
result_string$ += "," + string$ (hammarberg)

writeInfoLine: result_string$
