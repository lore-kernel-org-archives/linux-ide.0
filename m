Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199360;
	b=Pg5c6yWCCL+lgv64PAID5lSyVSmy5x4Qq/GZf67w0tsWyVmkFqKP2XHmBltXxXx6h2hX
	 nDmuDE+KJtJ6I6kvEF+rwQ1ptO53v4IU0ORbsIQGaYQ+4Vi7f53claQA9YfiS0jMm75eU
	 UVd4LJFGyp5+zHAZqF2DNbpwa0ZpblLuNtCDSimXXK3pYNTcgld10OXN4wBwhP5tsbO9x
	 yfpmhfKp0KuUbVUdVE6w/ydfAa9QS0/8+0wqpog53/w1BwoTWI1SMv1Y0JdYjka90FOK5
	 5YU9H3x25nxc/+jenwkakrd8DNn5LZuDvBul1clT+AEQRTRBbVljlo1CV9zoUWcL0wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199360;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=7krMu5BRngJ807x3Jl2pP+hlyiyx9zTZOLuYqtgoS18=;
	b=aP2uOmz7+9gpve1FMAMqcg9GECop03zbtbgVJZCj/ZiUJZtzhzbQHnK1Z/m3cyMFF/Ul
	 srcGepgGOFse9MNuQ23dleaKA9OIPqVYAsOo1WFtzh0fMF3nHYgmjdVpvRzJ0O8ZTs+ml
	 P0wCT34w/miyuxPNdL9oj79fHPMPqVP8WWSaz1dfApjxI7V0oyps3Dk8MhMWEjYNF9dzQ
	 L8R7musffcV8CSLk4SJM5QPEa6/uQeqcbtOnSYMbZODKTZJ0FqjD3thqXET3FBmuRKlZq
	 ZupyuddIDPyMHDctArRwj1fFHuX0x4UfjRudZNb4hMUD5zKfIPNapd2NRtIi13VqlJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G9Ekvcqc;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VGSut7Br;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139D606A31A
	for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 14:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C139D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G9Ekvcqc;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VGSut7Br
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793199358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7krMu5BRngJ807x3Jl2pP+hlyiyx9zTZOLuYqtgoS18=;
	b=G9EkvcqcHi9pwYmMpStMlsNatSsvcE49SGMPndkdr75DCqSi+lLeSD3qIBZINMP7qzDbKh
	TlGGelD9Fl7vEu4Yy2hvVwQWWVHX4+ztJtdC6QcuC9HdKNyBUiIOJN69F0LWhj10cwlQH0
	JSC5EWBR3zRo92/r3XIDcZmytoguVLk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-CKll9Fk-NlSj-taO1V5IsA-1; Wed, 28 Oct 2026 10:55:57 -0400
X-MC-Unique: CKll9Fk-NlSj-taO1V5IsA-1
X-Mimecast-MFC-AGG-ID: CKll9Fk-NlSj-taO1V5IsA_1793199356
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c407a17919aso102297866b.0
        for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793199356; x=1793804156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7krMu5BRngJ807x3Jl2pP+hlyiyx9zTZOLuYqtgoS18=;
        b=VGSut7BrU/+X39P298c6TUT3X8tgdZwpmumue0nqN8O90UqvFPrrLhXADtrtDWlx5M
         KSE7X8duPi2k3NCa9uhVmaDpNA49tXI6+Y2U62xVC2p54nhavLdsvKOvjE9c0IdsYRra
         P8xcVyzh0Ai+TUwLDu6Rqi4I4RKoabNTx4NOVjgXJkpQN4tVtKa9rw2/1wVCIjE61C7L
         WOM8dgBoKFYsOXI3oAap5584aPk/MizTktcGsIW1ZqOVONlpbi1t6fS76mIEVrdRo5Rv
         YrNPF52QvT0LFub8r9pAbdfaPuf1aEyzXp2XzPeEZ1Rn/zO1TgS8md5RNPrksHsNyYoS
         uTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793199356; x=1793804156;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7krMu5BRngJ807x3Jl2pP+hlyiyx9zTZOLuYqtgoS18=;
        b=ZJxzmAel1wU7UaBF3GUIX021joKNkZnc+tcqvBfI49Jkye9bHo9ZVJVDSWjsyGiFqN
         B0PQZqY9u7StilfdbBMGfy3vm4L/9VMOiIKWusoAQUnG2d/E6Z6sFVpA2DlSt7ChZ1sC
         KnaCfFu3cxpl+Sfas3NU0qt8XFBJOb2mU1v5I90a1khQhuQI0hsftlErojF0IbgEMHjH
         U0q8zcIEdXCXZEG1JGviHmkk/DEvUsAeOpZo2pgSsCD0Rula0koKfsIq/XaGPHdPC38F
         zoHKpU5sphA6DqR/zkD+1/2pGT3RxHEAifVTpgynk6vuf5mQ+CqX8TCGfav6KlwQFpis
         CWsg==
X-Gm-Message-State: AFq9FYLnAZuqpiW8nkxfa39zqw+M6470SWdVvX2QuTAs8B7K7MYBPqET
	J9wITmzRhChLqOZ5fg4OPkYptKFhz1aSVlrVRVsIRdAN/oXrI9mh7mfL9fdTPnKYMYcx53L/Ey7
	AJH8/W544Ra2VqRTnTYKex5otekZ1Cm0mkFNseB7hHM9bPpdS665X7V+5gjJM5DzRJ+ApNVy4Ij
	SqRjYvBFmmQdnopvC31Qsh4uSKGtwg9nc3lezcjudcmFRcHw==
X-Gm-Gg: AYBFou3RdctD5TANJ16GAmGz1mUHgDPiBhYzyk263qYe+UpEijj86g8RsR5vXK0Ukfo
	p0Yt8oGFBi6jrl/9YJ9dqIdab3q/nMmQvbtgrDY4VICiFDJMtZOTXjH+TalhfpdjNEXJ0KEzcgA
	9cB8g10jZTORuvbR/68bSSA5BNnEKlvnDOE+hb/KQpdjoaBqUIalAwM6LrgTuSoJ7mKSFus6IqQ
	z5NFKN9oaz4OXvETcMdL1QSPlH9T8zshBdjhD52btBTmzw03GdTX9pnNvEUG8zajQHXC165VHDA
	mrR3nOTnZPWG/G4PJ7yv4Hyupd4vwHDgFL9ghI8lAhcYXJCi7QVCob6RqDkw6Wu2TF0eJzvg/g6
	ki52iqrWKK5Y831YFOOLc+6fFHQHh2pemYEhBgVmzZaSuy1E9d0gu+8d+9VXA+w==
X-Received: by 2002:a17:907:7f92:b0:c42:2d07:4c38 with SMTP id a640c23a62f3a-c49bdf8252cmr220107066b.26.1793199355936;
        Wed, 28 Oct 2026 07:55:55 -0700 (PDT)
X-Received: by 2002:a17:907:7f92:b0:c42:2d07:4c38 with SMTP id a640c23a62f3a-c49bdf8252cmr220104866b.26.1793199355399;
        Wed, 28 Oct 2026 07:55:55 -0700 (PDT)
Received: from laptopRH.redhat.com ([2001:861:3dc1:f6b0:3a7c:76ff:fe01:794d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b496023595sm1561280a12.9.2026.10.28.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:55:54 -0700 (PDT)
From: Thierry Vignaud <tvignaud@redhat.com>
To: linux-ide@vger.kernel.org
Cc: Thierry Vignaud <tvignaud@redhat.com>
Subject: [PATCH] ata: libata-core: Add NOLPM/NONCQ/1.5Gbps quirk for PNY 1TB SATA SSD
Date: Wed, 28 Oct 2026 15:54:34 +0100
Message-ID: <20261028145535.623209-1-tvignaud@redhat.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Without that, I get the errors below.
For a year, I workaround it by disabling NCQ & reducing the speed by
booting with "libata.force=1:3.0Gbps,1:noncq".
It tried out disabling LPM only but I was still able to see errors.

Related: bko#222187

v3:
- add firmware revision check
v2:
- remove firmware revision from SSD name
- drop speed to 1.5Gbs (as there's no 3.0Gbps quirk)
- disable NCQ altogether (else we still see the errors from times to
  times)

Example of errors:
ata1.00: exception Emask 0x0 SAct 0x1c SErr 0x0 action 0x6 frozen
ata1.00: failed command: WRITE FPDMA QUEUED
ata1.00: cmd 61/00:10:00:a8:a9/20:00:6f:00:00/40 tag 2 ncq dma 4194304 ou
                        res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1.00: failed command: WRITE FPDMA QUEUED
ata1.00: cmd 61/40:18:30:ce:51/05:00:39:00:00/40 tag 3 ncq dma 688128 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1.00: failed command: WRITE FPDMA QUEUED
ata1.00: cmd 61/50:20:70:d3:51/02:00:39:00:00/40 tag 4 ncq dma 303104 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/133
ata1: EH complete
sd 0:0:0:0: [sda] tag#10 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=43s
sd 0:0:0:0: [sda] tag#10 CDB: Write(10) 2a 00 6e e6 88 00 00 10 00 00
I/O error, dev sda, sector 1860601856 op 0x1:(WRITE) flags 0x4000 phys_seg 32 prio class 2
EXT4-fs warning (device sda1): ext4_end_bio:360: I/O error 10 writing to inode 33841832 starting block 232575232)
sd 0:0:0:0: [sda] tag#11 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=43s
sd 0:0:0:0: [sda] tag#11 CDB: Write(10) 2a 00 6e e6 98 00 00 20 00 00
I/O error, dev sda, sector 1860605952 op 0x1:(WRITE) flags 0x4000 phys_seg 64 prio class 2
(…)
EXT4-fs warning (device sda1): ext4_end_bio:360: I/O error 10 writing to inode 33841806 starting block 232583424)
EXT4-fs (sda1): failed to convert unwritten extents to written extents -- potential data loss!  (inode 36499395, error -5)
Buffer I/O error on device sda1, logical block 155756907
Buffer I/O error on device sda1, logical block 155756908
Buffer I/O error on device sda1, logical block 155756909
Buffer I/O error on device sda1, logical block 155756910
Buffer I/O error on device sda1, logical block 155756911
Buffer I/O error on device sda1, logical block 155756912
Buffer I/O error on device sda1, logical block 155756913
Buffer I/O error on device sda1, logical block 155756914
Buffer I/O error on device sda1, logical block 155756915
Buffer I/O error on device sda1, logical block 155756916
EXT4-fs (sda1): failed to convert unwritten extents to written extents -- potential data loss!  (inode 36499424, error -5)
---
 drivers/ata/libata-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dadcaf9ff462..cde9d367c20f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4398,6 +4398,13 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	/* PNY CS900 (Phison PS3111-S11, DRAM-less) drops the link on DIPM */
 	{ "PNY CS900 1TB SSD",		NULL,	ATA_QUIRK_NOLPM },
 
+	/* PNY CS900 (variant) drops the link on DIPM and NCQ
+	 * This covers only the 1TB variant but other sizes are affected
+	 * according to forum posts */
+	{ "PNY 1TB SATA SSD",		"H220916a",	ATA_QUIRK_NOLPM |
+							ATA_QUIRK_1_5_GBPS |
+							ATA_QUIRK_NONCQ },
+
 	/* Silicon Motion models with LPM issues */
 	{ "MD619HXCLDE3TC",		"TCVAID", ATA_QUIRK_NOLPM },
 	{ "MD619GXCLDE3TC",		"TCV35D", ATA_QUIRK_NOLPM },
-- 
2.56.0

