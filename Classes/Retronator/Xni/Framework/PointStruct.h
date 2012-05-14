typedef struct {
	int x;
	int y;
} PointStruct;

static inline PointStruct PointMake(int x, int y) {
	PointStruct point;
	point.x = x;
	point.y = y;
	return point;
}

static inline void PointSet(PointStruct *point, int x, int y) {
	point->x = x;
	point->y = y;
}

static inline void PointAdd(PointStruct *value1, PointStruct *value2, PointStruct *result) {
    PointSet(result, value1->x + value2->x, value1->y + value2->y);
}

static inline void PointSubtract(PointStruct *value1, PointStruct *value2, PointStruct *result) {
    PointSet(result, value1->x - value2->x, value1->y - value2->y);
}
