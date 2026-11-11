Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415066;
	b=ma+a7Jj9MHp5KK22wkwIIJk/pbqJC66wTNdVWag/tN1+HvURqScJ3ku97vm3BWJ9/T02
	 gdpcWvSuXCmWMPf9mcIfQvDWkM01xO1ydDBL4CUWvGHrk/PD++y9Vig8VCmS6UUENzUXI
	 GeNY8dmEfVpfritowW7RMDiSsa3Pw7z1utz0tNC7ytJXqxJpCqT/m6LTZDFdzbaJcRRD1
	 cK5MkgH15vKR+pBLICWn/7O1R6Cv79RiRXpEDjrkfXJadv8fZcSTxxOgyfc476U5VI1Dh
	 dmoJR0nfKuW9skz7zKLH/nsnmXbxzjv0uWDfNNIOS+zFaFan5MeuMaHMzC7PCm6sM5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gbBLkzczqje5q5Cdgiw240astKZC/MyEc22DQrkWanU=;
	b=UNS2wsagUptNnuE672MkG5i+LE2z/HGmVwVP+kKKYxP4U/oT9o/bxWhLNUT4XUAxluHh
	 V4YQQucxAawmwHbP4tzf6p9qbmD65zryElAzyuOHB3+6j4XwXKqC9NbBATESbbHk2Lmwz
	 h5I8uiT0/ZIM9cUECDwPDKEv9o0BXQXbI0TiGuUM2tzYU4L/P7CwAox8qbVMrhgDGL7z4
	 BjzuQcDss2UQblax0+Lq5QkweszT5wlxlahyknyAwTBh/99gyq8qUMjO8iZgc4JqDhmI3
	 f5cNrxjN2fHCVdKqQf4pFvq1+2cnBQJGsCrk1WNkVieSDaRJ1K0VYL9kbdj9V0yODHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zSXGPVh3;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B623B606A8BF
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 16:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B623B606A8BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zSXGPVh3
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so33192425e9.3
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 08:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415064; x=1795019864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gbBLkzczqje5q5Cdgiw240astKZC/MyEc22DQrkWanU=;
        b=zSXGPVh3eZ6dh3GRnYH6oUgf9iQxK5XdkEeTaNUgQg9ub3mFf7yHL1uOwN8uIqluYA
         OMCL1P9w2f2dAm0Ks4mBsrm8mDwPgo9G2jbUhHNtFZpqoRb9wJhO/Y7zPQ02DXA+IKSo
         7pMXRcyKsVPaEPm8HRFyIRibpcCNdYPc4MMzL0x33YIpFlgrCbVoaMlFKSs1V2Y5M8o7
         RRjfTCXGPnzwhCSFALxjVkdJNK/+mfTmWjEiIN+AsffYVc5orGy5kOmY43Zcxoqk8X0a
         j1DD98kA6Yrz2m8vrVc6x0sgMNotK6gbQGyrqtULoLYTBRj0LqmfQXKtmlN7M5sltTR8
         iUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415064; x=1795019864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gbBLkzczqje5q5Cdgiw240astKZC/MyEc22DQrkWanU=;
        b=zTVGccYqpLAyQ2Wp4lXSJZA1IcrYqEOo/dBsOSIjjCXYfw7oN1i4Ryy8He9uy5pv1y
         E/W+bgGPn7vHHMi6sIYy1Aqqb+fBJnjurKhkc/+EqbqtssgpnVu0+5F4K3TqUPzpiRvx
         td6OCQEbY4yYQ9//3e2E9rrVLy2hl61jdnoDNIdxAQ/o28YGtvVRgtgNDyf2QPqJj16Z
         AnGgRZDGA08gFkqJ2LL4ol41zZ1oDQhVAM8vQeeQSZzY3nigItRYCMOUQ9KPY3FPPltL
         ZkhiZTwi9LiayjRhQdXjiJxL7cuFc0fke3AM5vfmbaRvxyL9v3rqStB3B6y5XtZHp+lZ
         LkXQ==
X-Forwarded-Encrypted: i=1; AL+hErFMaoInovT4YUYzVUwWN4S+1iJTb2XB26yJlQUrDHOHEMgYxMCRQgrqCOrY6QWLMJLYDvqHdURKjRI=@vger.kernel.org
X-Gm-Message-State: APuU4Z928AfRaAkQHWlGUr6ynNRIkk+8P7RdcYXIX+cA1JR7v4iuN2SB
	CRNYp0jhPgJ2V9a6z9ktbLc6Ya1GIBV4g/Z3d2rRyAokMbu65gvxmPdi
X-Gm-Gg: AYBFou1ynGjofizz0Li5bDXeNKQGVePHS7lf7e2KlBTamMIq8zScrXfEug1PjRa6vPa
	qtcfeRO4OLPBqYPYLfBlru4TchkXv7gKENc9m8QGd2Ofy6GTDY+lzx9yO5p0C+b5wcDgCZElR9j
	NzQ+qXzXTc4ZafKRZsV6+4/lxe4IiTa7qV2nxw2GwTpIVZ7B2b6e2j37RZFNhgMOM16JCMNNXZr
	Ck3N6vpLytXY5K9zSi4SqBCcp3v+x6zKheSLJRoHfU1fMiFHn62duyWlms9oChVdAjGgtda+/MN
	kN4HgiX3lpTWQnh/2i9cHsyXdsrXu6VO1CK5xJHzP7DivJqS0cQjCbE9cM02ecKAKIHTO2lnLJF
	zfF2xy5CNnepkIgIq6uu5XrxGDRpWc9eOOkvxTwtb2Lz6f6XseskTENtaW/m1nKNSxVjdodD9VK
	ghY2uMuJnvKUJpBYmhHw6Su7prFenK8N2uyqtHVMuicn7O+XMq0zOALWHkPdbiSlPU89tRJgAg7
	UmwDr1lSSdPjuoex3qqKa9Jgwh9ZwtB72+RkaPqN8lIW0+SiC0Zu4+zKntHP4y9FasvGOcBtURx
	6uAG5C6n4PISBa3w+VY9cgiEuICO24LoVi7T0zPrqNbsx2ObTGJB2peWkIkPNuq4F0AdaGb1KBP
	JK5bEi7dvodwt
X-Received: by 2002:a05:600c:468c:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4ba0939b3eamr53551675e9.25.1794415063769;
        Wed, 11 Nov 2026 08:37:43 -0800 (PST)
Received: from gmail.com ([2a01:e11:1403:8620:6e81:13fe:ca06:8db8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08e35e44sm64559995e9.1.2026.11.11.08.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:37:43 -0800 (PST)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev
Subject: [PATCH v1 6/7] zorro: warp mfd: expose the fan duty cycle
Date: Wed, 11 Nov 2026 17:37:33 +0100
Message-ID: <20261111163735.227286-7-p.pisati@gmail.com>
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

The diagnostic frame also reports the fan drive as a percentage.
Expose it as fanspeedpercent.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-warp-mfd | 7 +++++++
 drivers/zorro/warp-mfd.c                        | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-warp-mfd b/Documentation/ABI/testing/sysfs-driver-warp-mfd
index fec712b8b9b0..a8213affb153 100644
--- a/Documentation/ABI/testing/sysfs-driver-warp-mfd
+++ b/Documentation/ABI/testing/sysfs-driver-warp-mfd
@@ -33,3 +33,10 @@ Contact:	Paolo Pisati <p.pisati@gmail.com>
 Description:
 		(RO) Voltages in volts, with two decimals: vbatt is the backup
 		battery, vcc5v the 5 V rail.
+
+What:		/sys/bus/zorro/devices/zorro<N>/fanspeedpercent
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	Paolo Pisati <p.pisati@gmail.com>
+Description:
+		(RO) Fan drive, as a percentage.
diff --git a/drivers/zorro/warp-mfd.c b/drivers/zorro/warp-mfd.c
index d407c786d44b..a438faeaa232 100644
--- a/drivers/zorro/warp-mfd.c
+++ b/drivers/zorro/warp-mfd.c
@@ -303,6 +303,7 @@ out:									\
 static DEVICE_ATTR_RO(name)
 
 warp_config_string_attr(boardname, board_name);
+warp_config_uint_attr(fanspeedpercent, fan_percent, "%u");
 warp_config_uint_attr(fmwver, fmw_ver, "%04X");
 warp_config_uint_attr(hwver, hw_ver, "%04X");
 /* board sensors: volts to 2 decimals, temperatures to 1, as WarpDiag shows them */
@@ -315,6 +316,7 @@ warp_config_sensor_attr(vcc5v, vcc5v, 2);
 static struct attribute *warp_attrs[] = {
 	/* RO attr */
 	&dev_attr_boardname.attr,
+	&dev_attr_fanspeedpercent.attr,
 	&dev_attr_fmwver.attr,
 	&dev_attr_hwver.attr,
 	&dev_attr_t60int.attr,
-- 
2.43.0

