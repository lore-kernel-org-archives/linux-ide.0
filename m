Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415065;
	b=Yp+mr6X2tOmUGIxnH67s82/jb7QqRWwvkQwTp4djQu5gtgX6tPggB+KwKytz0qZNKQav
	 oE6HRR34Oz4KdeBpC1iIs1gNhJMHneehxAmieEC/6LqyyXrhUnGRwVv/PWwCwKyFShGS/
	 0aIqeVhTRdInIx+owBcgDfBJdulu2AkYuTYqXXWXnWHHBsSAMm6FHDCGqKk407fb7Oh2V
	 B6IV2AS5RxOXR+ddJG02xm4DcV6P9x80Mp44w4twb1WyhfOIQ60U8lssUkCiiNh8fxUdA
	 hkvIA0u/CODyZ7Iqx0Io/iZEdCGBuVo/oFEYn+LRPJ4aGhHXZ2McHL7zjapcJsjAeBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=O4LCoxfztIxiO4Ve6PdwkUlzn+vvBZo5he0KpnyIOes=;
	b=Ltstab3mPsfTQOJZkJipTFQGJ6OTcboW1653RbTQ8XfLHXHZOTk7hn9C/SmSFfQH/+wA
	 xJLug5WzI2stxXvleS2V6wYTW2THc+hoZ2CCcQ8yV1qKtr9cOgh4XCl7HbuIUbNCGRdcC
	 VLkhZbrhdfQLq5Vs0BWQP2Nx0WiNfZpk+P/qYr4y/qy/qAzjKgj0JmIe9bw7+2ir4vvli
	 CaEbod6DxXRdBqupi9Q/OhRDUD8JuiWNBZDX6jpVNqY1ZymcYobKpK7Yr8bqsK2SUll2m
	 pB6MqxRbKE5Pp6Uvt3kpqxWq+OqgREyhgdq16fVNVoRwlWWGv943aSJMlS8yAtXK/mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dae87Cy;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84174606A8B0
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 16:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84174606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dae87Cy
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dee593f18so2572784f8f.3
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415063; x=1795019863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O4LCoxfztIxiO4Ve6PdwkUlzn+vvBZo5he0KpnyIOes=;
        b=0dae87Cy/B9YUhxZrRX3+f0D/Rj3UEQYH6g+Gqwe8026eNj4hsPNt149zkXFJyMyvk
         AruDO4TRtTFhYaSMu7KFHyzESFZeLSgahD4SBrUCsq9t6bYO0GpAIk3oc10M1B79b+QG
         /YvQEQd4o2dPzysD+NhFds/Nf9fOmZmcugnPa/fw9ydl7KC7QTmvMf7fKjDTct8MDs5f
         fZkuxH3qENaspZ6NvRbVllAdxh+Z3MyHEwqof4x+FPOMD7LMaqUI+N1KFbq7WWCCkA4e
         ZV6EpQDdQfyGWUDYkyD1aLRntBfa4prMpXWfDV8hR08IdqHicaqDzOXJIsprZSuW1h0l
         /nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415063; x=1795019863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O4LCoxfztIxiO4Ve6PdwkUlzn+vvBZo5he0KpnyIOes=;
        b=m36CySlH/sLtgjvBjsMllNUdouQXaWsGOO8tGI2nvFsYAIQhsg7pYkN5kwmwbFhpzD
         KSvKQMsMIF6gemjYlE54P7HheEQxhLfhZSrTKw+Q4tL7FmycFkgu1eCXYVD6i3DWnao7
         ZYhtDgTwphJLt51+D/mDZwVqsaKifYkZWpVbhviOweLzgMVAYXUmrTF03QsmC5vWO8xZ
         p/gu3ir5A1pzMTXpa1UZiyiMSQwv2MRPiVyeDyqvXuaVBz+lWiSiwZV+SRIlMLNawUYa
         lguxMNamtwwUguKVA5D3b74dn57SqwzEjzHmBKtZVW3P9ZbX+0AnYNTZnTVLAXgh++Bc
         KbvA==
X-Forwarded-Encrypted: i=1; AL+hErHd5gkb13FJPLRHrIIhi6vvDAbwKy9vxB7p0nFbfnP/V3No+09KFxYXMQPFxANEzYDfNVEwCo3p4pY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Hd7haM7tBsTHjK+/UoX1mZlAXbA/YimK4+5GkatZE4QCxSG9T
	KvBqVnGgRiGFdHVO23zqo9vvYURhaTE+KRMYf1mJ/9QwPlAnYU8kGUdT
X-Gm-Gg: AYBFou394xpVNWGFi64R15O4kkL7iIzuVJz3NvsobRugO48u/z51skDdTkyRxxQ38t3
	jkQfb1Pwj7T5UZ6mzPhlOC6dgHBI7p0uMYPldCIgpjfLL24V+gzgHC353c9e4a8VQ5BATF8GG8x
	drftwGISTEeCZgDXeNjkaxRlLuI/Nw0g4hgbyJEj2DYeS9MvgWEkW7K6tqDcZ5ylfN9eSVKRpQB
	pb6BfE/Ku0ov8dLzm6ONSCZk4oTHfRuidPvtkVVx7P3p3MjECHMwTq/h+oKtljkRs3ZAyrwTCiB
	1R/R0wTAjFt6GYnGylgkIOME8ZquCJcG6enlZp6pakCqVl4ElHsZzre8YM7VoC90aE3ECNq15C5
	uyOAOm3W0QEz2SA3g+Gfoe3rBAwRGih0AWpf397bc7g4FxinWqaBbiP/2QTG01ZkkVUXvvJpB/0
	j4+2aTHdUIQusDEUZ7BRlkzOGZsGWgEcMO5Io1sU0V79uWW9pm/lncQSMOXBxwJmw7S/+x9Vlnh
	4gqnpwX/TZbdByNi9h+LYSgiPlEHLzLiNDyNwW6mN3zyRcycrA7x1wczYZiutn+7DA6lJUWsNWK
	+tLI7IvLD6jL1f6QxwBVZ7m8zJxj/MeFVSlTRXmhaCHSqv5klUdZ2Mb9GCZP43hqhBcTv9/es3D
	/T1v0Ap/Jo+1mNaxswIPnIhIPo/CDE0SdDJ8=
X-Received: by 2002:a05:6000:2213:b0:493:c7aa:7cef with SMTP id ffacd0b85a97d-499ca844595mr4406823f8f.52.1794415062584;
        Wed, 11 Nov 2026 08:37:42 -0800 (PST)
Received: from gmail.com ([2a01:e11:1403:8620:6e81:13fe:ca06:8db8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bc9asm11050119f8f.29.2026.11.11.08.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:37:42 -0800 (PST)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev
Subject: [PATCH v1 5/7] zorro: warp mfd: expose the voltage and temperature sensors
Date: Wed, 11 Nov 2026 17:37:32 +0100
Message-ID: <20261111163735.227286-6-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111163735.227286-1-p.pisati@gmail.com>
References: <20261111163735.227286-1-p.pisati@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The diagnostic frame carries the 5 V rail, the backup battery and three
temperatures - the 68060, its NTC and the ARM - as IEEE-754 binary32.

Decode the bit pattern with integer arithmetic into milli-units.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 .../ABI/testing/sysfs-driver-warp-mfd         | 19 +++++
 drivers/zorro/warp-mfd.c                      | 80 +++++++++++++++++++
 drivers/zorro/warp-mfd.h                      |  4 +
 3 files changed, 103 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-warp-mfd b/Documentation/ABI/testing/sysfs-driver-warp-mfd
index 8996d1961b96..fec712b8b9b0 100644
--- a/Documentation/ABI/testing/sysfs-driver-warp-mfd
+++ b/Documentation/ABI/testing/sysfs-driver-warp-mfd
@@ -14,3 +14,22 @@ Contact:	Paolo Pisati <p.pisati@gmail.com>
 Description:
 		(RO) Firmware and hardware version, as four hexadecimal digits:
 		an fmwver of 2027 is firmware release 20.27.
+
+What:		/sys/bus/zorro/devices/zorro<N>/t60int
+What:		/sys/bus/zorro/devices/zorro<N>/t60ext
+What:		/sys/bus/zorro/devices/zorro<N>/tarm
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	Paolo Pisati <p.pisati@gmail.com>
+Description:
+		(RO) Temperatures in degrees Celsius, with one decimal: t60int
+		is the 68060, t60ext its NTC, tarm the ARM co-processor.
+
+What:		/sys/bus/zorro/devices/zorro<N>/vbatt
+What:		/sys/bus/zorro/devices/zorro<N>/vcc5v
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	Paolo Pisati <p.pisati@gmail.com>
+Description:
+		(RO) Voltages in volts, with two decimals: vbatt is the backup
+		battery, vcc5v the 5 V rail.
diff --git a/drivers/zorro/warp-mfd.c b/drivers/zorro/warp-mfd.c
index 61866f678b61..d407c786d44b 100644
--- a/drivers/zorro/warp-mfd.c
+++ b/drivers/zorro/warp-mfd.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -22,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
@@ -190,6 +192,73 @@ static int warp_get_status(struct warp_mfd *warp, union warp_reply *rpl)
 	return 0;
 }
 
+/*
+ * The board reports its sensors as IEEE-754 binary32: decode the
+ * bit pattern by hand and carry the result as milli-units.
+ */
+static int warp_f32_to_milli(u32 bits)
+{
+	int exp = (bits >> 23) & 0xff;
+	u32 frac = bits & GENMASK(22, 0);
+	int shift = exp - 127 - 23;
+	s64 v;
+
+	/*
+	 * inf, NaN, zero and subnormals all round to nothing useful here, and
+	 * so does anything of 2^23 or more: that is already past what an int
+	 * holds in milli-units, let alone what a sensor reports.
+	 */
+	if (exp == 0xff || exp == 0 || shift >= 0)
+		return 0;
+	if (shift <= -63)		/* smaller than a milli-unit */
+		return 0;
+
+	v = ((s64)(frac | BIT(23)) * 1000) >> -shift;
+	if (v > INT_MAX)		/* a shift of -1 or -2 can still overflow */
+		return 0;
+
+	return (bits & BIT(31)) ? -(int)v : (int)v;
+}
+
+/* Render milli-units with @dec decimal places, rounded, as WarpDiag shows them. */
+static int warp_print_milli(char *buf, int milli, unsigned int dec)
+{
+	unsigned int scale = (dec == 1) ? 100 : 10;
+	unsigned int units = (dec == 1) ? 10 : 100;
+	const char *sign = "";
+	unsigned int v;
+
+	if (milli < 0) {
+		sign = "-";
+		milli = -milli;
+	}
+	v = ((unsigned int)milli + scale / 2) / scale;
+
+	return sysfs_emit(buf, "%s%u.%0*u\n", sign, v / units, dec, v % units);
+}
+
+#define warp_config_sensor_attr(name, field, dec)			\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	int ret;							\
+	struct warp_mfd *warp = dev_get_drvdata(dev);			\
+	union warp_reply *rpl;						\
+									\
+	rpl = kmalloc_obj(*rpl);					\
+	if (!rpl)							\
+		return -ENOMEM;						\
+	ret = warp_get_status(warp, rpl);				\
+	if (ret)							\
+		goto out;						\
+	ret = warp_print_milli(buf,					\
+			       warp_f32_to_milli(rpl->diag.field), dec);\
+out:									\
+	kfree(rpl);							\
+	return ret;							\
+}									\
+static DEVICE_ATTR_RO(name)
+
 #define warp_config_uint_attr(name, field, format_string)		\
 static ssize_t name##_show(struct device *dev,				\
 			   struct device_attribute *attr, char *buf)	\
@@ -236,12 +305,23 @@ static DEVICE_ATTR_RO(name)
 warp_config_string_attr(boardname, board_name);
 warp_config_uint_attr(fmwver, fmw_ver, "%04X");
 warp_config_uint_attr(hwver, hw_ver, "%04X");
+/* board sensors: volts to 2 decimals, temperatures to 1, as WarpDiag shows them */
+warp_config_sensor_attr(t60int, t60_internal, 1);
+warp_config_sensor_attr(t60ext, t60_ntc, 1);
+warp_config_sensor_attr(tarm, t_arm, 1);
+warp_config_sensor_attr(vbatt, vbatt, 2);
+warp_config_sensor_attr(vcc5v, vcc5v, 2);
 
 static struct attribute *warp_attrs[] = {
 	/* RO attr */
 	&dev_attr_boardname.attr,
 	&dev_attr_fmwver.attr,
 	&dev_attr_hwver.attr,
+	&dev_attr_t60int.attr,
+	&dev_attr_t60ext.attr,
+	&dev_attr_tarm.attr,
+	&dev_attr_vbatt.attr,
+	&dev_attr_vcc5v.attr,
 	NULL
 };
 
diff --git a/drivers/zorro/warp-mfd.h b/drivers/zorro/warp-mfd.h
index 366848545ea4..4fa09fa972d4 100644
--- a/drivers/zorro/warp-mfd.h
+++ b/drivers/zorro/warp-mfd.h
@@ -84,6 +84,10 @@ struct warp_rpl_hdr {
  * Reply to WARP_CMD_GET_DIAG. Fields this driver does not expose are kept
  * so the ones after them land at the right offset.
  *
+ * The board reports its sensors as IEEE-754 binary32. They are kept as raw
+ * bit patterns because the kernel cannot use the FPU; warp_f32_to_milli()
+ * decodes them with integer arithmetic.
+ *
  * turbo_level and tz_corr_secs are reported by the firmware but no longer
  * maintained by it; treat their contents as stale.
  */
-- 
2.43.0

