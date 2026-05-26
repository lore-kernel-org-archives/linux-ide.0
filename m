Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21394401480
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805089; cv=none; b=tI52Pfdd3cfWMAr2E65p/FTQGxATn10nKvtCRXNulddA+0NafEBUw8GvNfVKb5bHaxMvArStwAOzDeAQ3zThJgRmC1n5Wucv9FQRx6CknEB0TP69uhRIpwUllsdSIsMOJS6Z3+++51N4bRzaX51Uif+UX7njsJPgAcGBXxOxctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805089; c=relaxed/simple;
	bh=A14j4ivDNBl2yGcg6n5ndH+ByZLqjyYb/4BbZyB+vg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsJAEwcP7Ugx1A8KFk1Fctd6c8PGe26iJV1Ozs1Iza/7VJl9Js1f9FbPf+bUlzMsrHNGHnhKjVQqili3XIHuKN4a+LicavzU8wuY5AhJ0zzPU9LcibrVtbiychVCJhosAD3k2JLL1tfa/klz32UUz96lUh/7WutWUSLp/ffpcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Kr5CR1pu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Kr5CR1pu"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso30332595e9.2
        for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779805085; x=1780409885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWA1rx79U563LTGj65VSgfxyjti8CkpfF8kpzyqUrdk=;
        b=Kr5CR1puBNaF4clfOgdrSY811kH0XkJYaXu+tVuev20pRHeBFa6PmkgFfS7uPTR2Mj
         fccEIsQWEhUkWS/CT8WCi3/1a7oZuBvZ0BapIIz3Tp+MeoOcr1VGd0OfwtIMkjbrk1bb
         S51PVUaLe7Z2+cP8ML/eZy1CDRItho9DvS6wXJJhHCYPnaQRkpWofV8xMl3D+fAmy3L+
         e8z7ETF1JDJ+fKIfD9mFwX7Xn3lnn0nDGBAeeV/ZNq4TxDc3KDbcEEeWE8PRq1sgwGN/
         5b2esYUBdADisNNp39HkOaTwLPlCZEXJANrO0FuFsYBD8fAgQRjXET1mdfBqRTJMj+3X
         x24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805085; x=1780409885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWA1rx79U563LTGj65VSgfxyjti8CkpfF8kpzyqUrdk=;
        b=oK1SB6Zq6Om3QB2cggfcUdEyeEasCLGLf+Fiuyi+ZCJPh7SK7RaYuRG5/npV2c10yB
         dGonDd2gkGlxbjqbAvrmEm6OaHQmbOl+SYhDCUx3vFSCGwEGKJUW3oj/yz0yBsDLHgPc
         dffws7GzLDyVnnxb/gFwG8NaJLvLcno18ZE1ydhBl/AZj3Rf7OznXxvzMty+Qy/Co/iW
         ugpjX0TK7bQAQpkzyd8oV7FZ//LFvT69D+6er4oLRndpi5H9j+chD22xXDaYFMNdqWi2
         tYoSsLYm0fuHM7ddz6Fv++KbicbJPlCIO3U9VfgwKpHNYH05wiOrimSED/CIrH1CxM8h
         fEsQ==
X-Forwarded-Encrypted: i=1; AFNElJ8s+BHPeNtT4N2/2o9kMdfqbmAzbn7mJvxalVWdhGXk1mzbBFdk/0394EUFcj8t3EizG3Gy/+ghR+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeP5sgxCLUbzyF4MiYxYvwO0Y4w2EjHih7wKDzpA7GFa9873X
	Yc5bezr6EyB5RljfMec4enaW1qTp1mNJKOM2iyKfJ2ZHH5ByeXL2lkCPrpMGlysprDE=
X-Gm-Gg: Acq92OGZ6owycZ7V9iVEBSZFf0mCFZ85bn5ix8E3+mnDkCTsIo2DpJ1ghHX4kuoAYQd
	28UzKsV6Sl3cSSd9Xs+AucI3Dvmfw9CyG2EXyamourgHyLcghYaAjvxeYMfO5FaklkcpnKytjJ6
	GqdXTgvcsZr8VJY48G1o0P5DypjeS+D2WfTuddkV8cl9Xk93P0sPyIzmrYDUcVjD3tQXgwQzavA
	iRqGukikH6ZZRQUgv42QzhVVjYrhNYMY6UI9tzd1LDlohdYRhua8WWDOjwZ/zuDUVdonJX5lrtN
	TgPBu/pd1Ds0aaQq+dPUvhQ3hydaUEylOd3GgetL46x/DvYU8a3KAGfCU9RzB4LbwOJOP8XbnHR
	ukcu2+btVfOhMnJK4+Kz/Z7dKcFhSde6nlnNhqw3o+v0WwH1NJdf4l2iwBbbfPN9zuf3YtjrXsN
	iBPLQfEdOi49Y9RZRhS/p7xHbWOiftQo0EAwp3gHa7K+JTCJvu7ObmLjWkiGpACuGF2EbqJNtT3
	2uXdyp6KWpinpTT766BAjqvkA==
X-Received: by 2002:a05:600c:4592:b0:490:6237:5213 with SMTP id 5b1f17b1804b1-4906237537cmr145220735e9.23.1779805085104;
        Tue, 26 May 2026 07:18:05 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4904561a160sm379625175e9.9.2026.05.26.07.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:18:04 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Max Staudt <max@enpas.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v1 6/8] zorro: Simplify storing pointers in device id struct
Date: Tue, 26 May 2026 16:17:32 +0200
Message-ID:  <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=A14j4ivDNBl2yGcg6n5ndH+ByZLqjyYb/4BbZyB+vg8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFauEMCO+XO5wBiq0WLDW9CPIg9uJbXOSVo41d x54C4q2mLiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWrhAAKCRCPgPtYfRL+ TjnnB/9l+SDbdriw4+P0R0QawXzQR6RNcTSEDOsG0Za0QxbkFa85XMb5sLwAO0owuw/Rowx6ky+ QMdsAXUgR3vwvQLdxYJlkEl/VA/XHq/xJJAuw+YZlvI7KLvHFN3YqbmJgo+fHO56QX05JkYBvJ2 Jk9WKvtvJ58lFHkr+5etBSYF3AixiJ+YBuoVcvjao9lM8EjUJ8SyDU/sXtdjUltWSXQmsKSN5Wa cffVeDubVIqpPQNOIDt4M8130VMFMoHEz1nySiOBmpolGD4C9tykhh7r5xGVttivy5+fc/p6kFl 64ZyNUXuXtZrf+NrGcA7ZEOvBZuObVE5B7q9XxMf4MX80c3s
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Technically it is fine (on all current Linux architectures) to store a
pointer in an unsigned long variable. However this needs explicit
casting which is an easy source for type mismatches.

By replacing the plain unsigned long .driver_data in struct
zorro_device_id by an anonymous union, most of the casting can be
dropped. There is still some implicit casting involved (between a void *
and a driver specific pointer type), but that's better than the approach
to store a pointer in an unsigned long variable as this doesn't lose the
information that the data being pointed to is const.

All users of struct zorro_device_id are initialized in a way that is
compatible with the new definition, so no adaptions are needed there.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 include/linux/mod_devicetable.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 3b0c9a251a2e..2673a1bd82c4 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -640,7 +640,11 @@ struct mdio_device_id {
 
 struct zorro_device_id {
 	__u32 id;			/* Device ID or ZORRO_WILDCARD */
-	kernel_ulong_t driver_data;	/* Data private to the driver */
+	union {
+		/* Data private to the driver */
+		kernel_ulong_t driver_data;
+		const void *driver_data_ptr;
+	};
 };
 
 #define ZORRO_WILDCARD			(0xffffffff)	/* not official */
-- 
2.47.3

