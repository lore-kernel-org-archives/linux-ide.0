Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191433;
	b=a/dCWf/m5jvMFoss+RXrUPj/YuIvIaTgNC5TACyznNm9bSrk6cInxJ9q0C9Q1xP+ufvU
	 a7i86sbm4WgzLNbGeluM4WKn5/8BfVtj6l6fjE06wXqMdPV2pJp9K1uGbsQAVUqcsX04t
	 p4ntn71gjtZKmoNOknjLYvHf4H9goAHyClde40rPJuvs67btxIRMuGN+EBjEI53W+So+t
	 CHyY9G7+2Rt8HVw1whlYtQjmNdSMWs8qdsRBKtOs4IAF+F3ymyWvrVGgqXj2SCxW0jrmR
	 SQh6G3nYPmpngnalA7fLxIhF31QwQz/P3WEIWL8HL6H21gs5vutOkCakS/MY6sDGukg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191433;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X7We1kdQlDWc49/YeX4OfoKLmGuGPjqsoYEzvMuqZoM=;
	b=uLn3fwiNM8G3v28aRwaoCxxdEITsJVf1CduJYNO8tnMCVfeeDGERqGFDY4hkpuo9oTeP
	 RPBVNVguHkGM8wRDoohqW1SfIOPjQTlauo8y/ZXXRBPvy4kY6znR67RgfCPRj1IRmIAMt
	 kWo+DssyHChC0MIb67Gsrkfr41jGEI5eAY5T/i/LXq2SrNRvxLYqMI1WLGpY3O5CrARSA
	 ynsFoVxmV9fQslBDEeWE93MmqfNK2VZgCD4pSRAIgdoj09NxL6f1sGVjTzGk9eJe19gRE
	 ZurCQvWoerPN/4Nn6RtZAWhQ5gD/WvD9+BR24tWinN1D+ueez/iCe2gh2LTodgOPwbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BSxptgh4;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=b7pdTS9y;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A2606A31A
	for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 12:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF3A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BSxptgh4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=b7pdTS9y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793191431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7We1kdQlDWc49/YeX4OfoKLmGuGPjqsoYEzvMuqZoM=;
	b=BSxptgh45Z44bgKN8NTfW8BaJcArG30pTZ/MpJzTQankbDqYtfKDM8RQgBbuo/bHtQQ3C8
	NV0zxw9nC+lEEYdU+u6AfyWFWmcBbBASbBKGTM0/teQMmwOVhaDp7pTd5l3BjGSGes1MA1
	pC+KWLmiNBwLZuIvd6I2+wpPkaKIs30=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-FRbOCYuSPFSuj8GERnXXUA-1; Wed, 28 Oct 2026 08:43:50 -0400
X-MC-Unique: FRbOCYuSPFSuj8GERnXXUA-1
X-Mimecast-MFC-AGG-ID: FRbOCYuSPFSuj8GERnXXUA_1793191429
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a20fd059ddso6699755e9.0
        for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793191429; x=1793796229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7We1kdQlDWc49/YeX4OfoKLmGuGPjqsoYEzvMuqZoM=;
        b=b7pdTS9y0lFmbVV8yaRr7oy3wzum6lJT+Dykpw7LO7Ra97m32lAJ14iKPYTiOpLI1t
         wHQ2V0U2FxP5PS1sfH+5nmNq6779DpHCXKWBEcOxx95rivG3omy7aQfNWk0xieTajdVT
         +sVZwUujICKPc3TxpEt+6L26NkNIGdZf2QGl9ZRAPscEqPJHwVgNu3ssYv5qypLhhJMr
         oQ/kEhTKj8xfEat+pdulKTMl3f+WGL5QU39P1tZJKZ58o7gEKYjeu5dvmW2lwa02Fsq3
         nPrQSHon9u4zMgDbSVpZ7Fqsx5dWw9a1Q84/spcyul9Ss12aeqebje21wHawQwU9cdub
         /sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191429; x=1793796229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7We1kdQlDWc49/YeX4OfoKLmGuGPjqsoYEzvMuqZoM=;
        b=UrPIk/fXY079bfd7k5fT3MbJI8CadWiR3lKDm5C1Axz1ysbNKwEAOgOG+WSqmFVX5s
         YtmG37iceoQMIHFh6n5WHBLKVyGRsd8kPHQ2Uj++wraLoDanjJPz/JUVLUzFZtNKgJJ5
         h0NiyqSNxkWgPnAVwpdbbe3n4M1C1eKoO4o/2r3BXLWyVICo1+8JRn/YGTpkV2u1M4K8
         JIiFFQBbXEeJwaO3Z/OcL3G51m0wc1TIkVM90XfcrgA35zK3z9pqs7P3XpDKvcgnb07N
         KxbjUl2R7mEFP/H6gRDbcR0yWZ5iOFW0vxrEaKENStY45eRvWHmjiI4xuqUzm2cQqDX9
         bk2A==
X-Gm-Message-State: AFq9FYLo/946ytWNXfeErEBwxQwXLVisTOw0rh3XrT5SqD7G4PO4d7Mc
	A5coS1xwsqYWp/njQxPzh++iCREGho1bHSEFwpKXowhoF71T/2rg/YQ2wDh4d4hJr+a36BoWk/I
	PObWKcqU+Z+RpG+fO+wqPLz7Xxp0RH98kvDEhmUUirQhDa3vmubU5rCgl2HixHQd7bnsMD8y2tw
	X9Dev9N06QcGC8h4UUFHDAx1bBmbrP4k7irCjhQlEnbHYz0Q==
X-Gm-Gg: AYBFou3tNnRNT2BpyNFaI5QgcSVU3OkCSS4RYP7wrr3e5ZQ0ydc2UYCSWMLc2QJAclN
	hRW+sK0m/VcFD6Sc1fPkRZsO9tiOsMv4BbdGJh8P407c50sf7RJXvGNTg8HzUvPB3aCEfJsInuh
	pbj1Tw7NaNfpvFYibhULpOX7XJR3Y2DQOMrLbQ8mzZOn0jc7/ex7K0zDDgVxvrhaXffMlF+LQzc
	LggvONac2jOd09F8rAlEm1EVRvoURpRMwv9DyahQqq57MzY97OFpVqscNevQnaPziF6xPF6aM17
	jECgJhL/VjaghwNJ+zRCwKaLU6j4fie0ixu0oLhpVNK4KXT+ODCuFunea9BBIR2GvgqnuuYNY2j
	K3C4DlioVSWJ2a6Ega/wWeYPPVwY+8IkuONT8XtfVW0AUJ2x8IIMr8mBLHNI/FQ==
X-Received: by 2002:a05:600c:3d05:b0:4a2:1a:a120 with SMTP id 5b1f17b1804b1-4a9745286cbmr44622735e9.6.1793191428880;
        Wed, 28 Oct 2026 05:43:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3d05:b0:4a2:1a:a120 with SMTP id 5b1f17b1804b1-4a9745286cbmr44621945e9.6.1793191428358;
        Wed, 28 Oct 2026 05:43:48 -0700 (PDT)
Received: from laptopRH.redhat.com ([2001:861:3dc1:f6b0:3a7c:76ff:fe01:794d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a977edc08fsm41979905e9.4.2026.10.28.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:43:47 -0700 (PDT)
From: Thierry Vignaud <tvignaud@redhat.com>
To: linux-ide@vger.kernel.org
Cc: Thierry Vignaud <tvignaud@redhat.com>
Subject: [PATCH] ata: libata-core: Add NOLPM quirk for PNY 1TB SATA SSD
Date: Wed, 28 Oct 2026 13:42:55 +0100
Message-ID: <20261028124328.597603-1-tvignaud@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <[PATCH] ata: libata-core: Add quirks for PNY 1TB SATA SSD 916a>
References: <[PATCH] ata: libata-core: Add quirks for PNY 1TB SATA SSD 916a>
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

Without that, I get the errors below.
For a year, I workaround it by disabling NCQ & reducing the speed by
booting with "libata.force=0:3.0Gbps,0:noncq".
It turns out disabling LPM fixes it without the huge performance hit.

Related: bko#222187

v2:
- remove firmware revision
- drop speed to 1.5Gbs
- disable NCQ altogether (else we still see the errors from times to
  times)

Example of errors last year:
[999662.257282] ata3.00: exception Emask 0x0 SAct 0x2000 SErr 0x0 action 0x6 frozen
[999662.257298] ata3.00: failed command: READ FPDMA QUEUED
[999662.257302] ata3.00: cmd 60/20:68:40:7c:fb/00:00:d0:01:00/40 tag 13 ncq dma 16384 in
                         res 40/00:ff:00:f6:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[999662.257317] ata3.00: status: { DRDY }
[999662.257325] ata3: hard resetting link

Example of errors this year:
kernel: sd 0:0:0:0: [sda] tag#2 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=44s
kernel: sd 0:0:0:0: [sda] tag#2 CDB: Write(10) 2a 00 64 10 48 70 00 20 00 00
kernel: I/O error, dev sda, sector 1678788720 op 0x1:(WRITE) flags 0x0 phys_seg 87 prio class 2
kernel: EXT4-fs warning (device sda1): ext4_end_bio:360: I/O error 10 writing to inode 36831430 starting block 209848590)
kernel: sd 0:0:0:0: [sda] tag#3 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=44s
kernel: sd 0:0:0:0: [sda] tag#3 CDB: Write(10) 2a 00 64 10 2e 28 00 03 08 00
kernel: I/O error, dev sda, sector 1678781992 op 0x1:(WRITE) flags 0x0 phys_seg 88 prio class 2
kernel: EXT4-fs warning (device sda1): ext4_end_bio:360: I/O error 10 writing to inode 36831430 starting block 209847749)
kernel: sd 0:0:0:0: [sda] tag#4 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=44s
kernel: sd 0:0:0:0: [sda] tag#4 CDB: Write(10) 2a 00 64 10 31 30 00 05 90 00
kernel: I/O error, dev sda, sector 1678782768 op 0x1:(WRITE) flags 0x4000 phys_seg 168 prio class 2
kernel: sd 0:0:0:0: [sda] tag#5 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=44s
kernel: sd 0:0:0:0: [sda] tag#5 CDB: Write(10) 2a 00 64 10 36 c0 00 02 f0 00
kernel: I/O error, dev sda, sector 1678784192 op 0x1:(WRITE) flags 0x0 phys_seg 88 prio class 2
kernel: EXT4-fs warning (device sda1): ext4_end_bio:360: I/O error 10 writing to inode 36831430 starting block 209848024)
kernel: sd 0:0:0:0: [sda] tag#6 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=44s
kernel: sd 0:0:0:0: [sda] tag#6 CDB: Write(10) 2a 00 64 10 39 b0 00 05 70 00
kernel: I/O error, dev sda, sector 1678784944 op 0x1:(WRITE) flags 0x4000 phys_seg 168 prio class 2
kernel: EXT4-fs warning (device sda1): ext4_end_bio:360: I/O error 10 writing to inode 36831430 starting block 209848292)
kernel: sd 0:0:0:0: [sda] tag#7 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=44s
kernel: sd 0:0:0:0: [sda] tag#7 CDB: Write(10) 2a 00 64 10 88 70 00 20 00 00
kernel: I/O error, dev sda, sector 1678805104 op 0x1:(WRITE) flags 0x0 phys_seg 65 prio class 2
kernel: EXT4-fs warning (device sda1): ext4_end_bio:360: I/O error 10 writing to inode 36831430 starting block 209850638)
kernel: sd 0:0:0:0: [sda] tag#8 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=44s
kernel: sd 0:0:0:0: [sda] tag#8 CDB: Write(10) 2a 00 64 10 a8 70 00 0e c0 00
kernel: I/O error, dev sda, sector 1678813296 op 0x1:(WRITE) flags 0x4000 phys_seg 168 prio class 2
kernel: sd 0:0:0:0: [sda] tag#9 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=39s
kernel: sd 0:0:0:0: [sda] tag#9 CDB: Write(10) 2a 00 64 10 b7 30 00 11 40 00
kernel: I/O error, dev sda, sector 1678817072 op 0x1:(WRITE) flags 0x4000 phys_seg 87 prio class 2
kernel: EXT4-fs warning (device sda1): ext4_end_bio:360: I/O error 10 writing to inode 36831430 starting block 209852134)
kernel: EXT4-fs warning (device sda1): ext4_end_bio:360: I/O error 10 writing to inode 36831430 starting block 209852672)
kernel: EXT4-fs (sda1): failed to convert unwritten extents to written extents -- potential data loss!  (inode 36831430, error -5)
kernel: Buffer I/O error on device sda1, logical block 209848334
kernel: Buffer I/O error on device sda1, logical block 209848335
kernel: Buffer I/O error on device sda1, logical block 209848336
---
 drivers/ata/libata-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dadcaf9ff462..cf36f2638fab 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4398,6 +4398,11 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	/* PNY CS900 (Phison PS3111-S11, DRAM-less) drops the link on DIPM */
 	{ "PNY CS900 1TB SSD",		NULL,	ATA_QUIRK_NOLPM },
 
+	/* PNY CS900 (variant) drops the link on DIPM and NCQ */
+	{ "PNY 1TB SATA SSD",		NULL,	ATA_QUIRK_NOLPM |
+						ATA_QUIRK_1_5_GBPS |
+						ATA_QUIRK_NONCQ },
+
 	/* Silicon Motion models with LPM issues */
 	{ "MD619HXCLDE3TC",		"TCVAID", ATA_QUIRK_NOLPM },
 	{ "MD619GXCLDE3TC",		"TCV35D", ATA_QUIRK_NOLPM },
-- 
2.56.0

