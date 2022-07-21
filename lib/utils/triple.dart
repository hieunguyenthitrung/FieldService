class Triple<F, S, T> {
  final F first;
  final S second;
  final T third;
  Triple(this.first, this.second, this.third);

  @override
  String toString() => 'Pair[$first, $second, $third]';
}