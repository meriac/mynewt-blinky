#include <bootutil/sign_key.h>

#include "image_sign_pub.c.import"

const struct bootutil_key bootutil_keys[] = {
    [0] = {
        .key = image_sign_pub_der,
        .len = &image_sign_pub_der_len,
    },
};
const int bootutil_key_cnt = sizeof(bootutil_keys) / sizeof(bootutil_keys[0]);
