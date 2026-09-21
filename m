Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B24A4995
	for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015095; cv=none; b=bFCVVc0FuctXUowfEymjKFzNvYNSpR88uzPKgEeFJqWk9LyELdNR+buGspV0LIzeHZaEa00VtB7ke9Mswz/OpupW8/ITZjUo3WKan6K4lvngnUxv1b8woNkMWu4jiGDY/bKyRdvHsuAhVTMmvlervOFQCX/Uaqd4xGB04pyoGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015095; c=relaxed/simple;
	bh=/+RI1Da3sET4j7aA1zAV2C4MGFpQWaqBXLaCnc5GHEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKr+X1QkI9IzPWtlVJzVizQM6NV95NETO4pwLrHuSqAhiuswgRxAPm546Vv6wVRNUc9iY0WhqPhttsnI/H0VyuYiihjkSCoJ6vE0yjuNPH1oR0KDJ49tnq+qXyVNP0us4YaqTVEktbyfXY0LS4bNzEIRl77CnVZ9qFdF0SglxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+fqubIf; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+fqubIf"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-805bf8c2661so2335710a34.3
        for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015091; x=1790619891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jjUHpPAdtuvAei0FHz1ELJs0Q5uHpEFQEpOpyheuCag=;
        b=B+fqubIfyD7Q9ZCrWnE1rYogNj98FHeI/rA0QGNT14hhQ3yJlB03SrSkbDQgOJanND
         VVchJyD5eStOOmXpx6lTnO97JgINe9A3w+lClqEznViuN9jNHEQ6Du5YsRs/BemSvqTh
         P+q5L9Hz7Knbhq+4ZZedHIjzsUhU2YRNnSBFIUqK3GRrJsDOjORFVFMU2VH8tY7Yn5D/
         l7mOIjVNwXxx492PyDjTd0VcKHgLFDVmxsQO2gRIN4Ofx6Ep/YXBFHJfeRHRl+Rsmb31
         ueYy1PefTKeNTDFsSSZn2lCgpJlyDYBSFcLJK90SMiyeJmLe8EoExTXUh2nRzsXEln7Q
         VbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015091; x=1790619891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jjUHpPAdtuvAei0FHz1ELJs0Q5uHpEFQEpOpyheuCag=;
        b=fEpHOXp9bE2Fvnx7a20VYPUx8tG9jhTQS/EYPGe1Jrszpb13rIOmwrHrFolIOIWOpV
         JynS3jQOl/hGUOKVIc4bjMSAKyh3e9KRPfrXAXIfC+iYu1ub74zokDWWE+fs6eSYZwZ5
         E/RUnvCJqNE5mycLWIoBNwZGXBwuydXo3GsDFwHER1RZizc1ZmHAWJRGfWyWaLCWJcS5
         QtivOyGivELhy+kDaviwa9tx1956/VLW7TBQ1kSWDvU7Z9pxKvEJaIB+DpSmfp/hUoNm
         tExHQ3XYLvE6LvbK88uHpIngo9psshyfmL9sGOmFKEM5QmBKba5L3kxMI3OzN0W5nal/
         lr2Q==
X-Gm-Message-State: AFuF++llT6AmT0YeUVuwG+6NR0jzOymSV8SDR3JN/GdFLL5s027eLMi+
	/8PONugf3gXLZZbbmz+MmnrA4SNMKoF+C4jiTI4ebY0F2VNwNe9aA0RsVKx0P9O4
X-Gm-Gg: AYBFou3dcXUcqyH9EDa8V9/x9iTQ9WYyoWwUrwNRWlw4X3bEDFHVJAbDSI53XsRfp3j
	d/Cbd/rSF7lwbSl6j8sSRfrMu3KtnNBygAw7diQrRgzAi+V9eC1ZsdRpu3hLnoj9+CUY11TCYDo
	Fke/YlY7jtsEP1v5Frh71KOdSwK+091IVBwlUouMhjlo/Salbg2lf4bMzQMSNXKiw+nc0Sk/M6r
	0qITHE3BVQPQ63LNp9R86CJEIjQ5BhmDrswm4+/TOsT7sDl3tjH/Hxc8KmUnKLJrjVbbI2jPxMx
	j26BmktG24TB90nPZ1RvLiB69e9JCNlbiHN7uGof2fCq/RPQmRrlGcKCcjfHKmANAmIvRLT622S
	e/jZmaJC620zdqJc37DMRPYKIw5CfKm0oLnIvjM0YSPSbWC+P3SnBdKnyduzkxUb/fnFb3WWEhr
	yEf1Ny1qyxOPROcwGCjueavYZnne+BWhXxcexKcxoP1piQB3Vz/zksxUtS0h3CQ3uSIZRpArVJj
	2fG2BeGTqxgzTG2lJT0LcwR8iR4zAeN7fpA2rwX
X-Received: by 2002:a05:6830:3144:b0:805:5e7e:9bf6 with SMTP id 46e09a7af769-80de31e766dmr11051342a34.21.1790015091211;
        Mon, 21 Sep 2026 11:24:51 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-814739aec92sm777318a34.3.2026.09.21.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:24:49 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>
Subject: [PATCH] ata: libata-sff: replace kmap_atomic() with kmap_local_page()
Date: Mon, 21 Sep 2026 13:24:48 -0500
Message-ID: <20260921182448.194307-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmap_atomic() is deprecated in favour of kmap_local_page(), as described
in Documentation/mm/highmem.rst.

ata_pio_xfer() and __atapi_pio_bytes() each map a single page, pass the
address to ->sff_data_xfer() for one transfer and unmap it again, so the
mapping never leaves the function that created it.

Neither needs the pagefault_disable() and preempt_disable() implied by
kmap_atomic(). ->sff_data_xfer() only moves data between the device and
the mapped buffer, and both functions are reached only through
ata_sff_hsm_move() with the host lock held, whether from the PIO task,
an interrupt handler or EH. kmap_local_page() is fine in all of these.

Tested on i386 with CONFIG_HIGHMEM4G and CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
under QEMU, with the PIIX IDE controller limited to PIO by
libata.force=pio4: O_DIRECT and buffered reads from an ATA disk and an
ATAPI CD-ROM, and O_DIRECT writes to the disk, all checked against the
image files. The O_DIRECT buffers were in highmem. Both call sites ran
in hardirq context, and ata_pio_xfer() also from the PIO task. No
warnings with lockdep and CONFIG_DEBUG_ATOMIC_SLEEP enabled.

Assisted-by: LLM sparse
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---
 drivers/ata/libata-sff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index d5ef0338735c..a263f886abc7 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -580,9 +580,9 @@ static void ata_pio_xfer(struct ata_queued_cmd *qc, struct page *page,
 	bool do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	unsigned char *buf;
 
-	buf = kmap_atomic(page);
+	buf = kmap_local_page(page);
 	qc->ap->ops->sff_data_xfer(qc, buf + offset, xfer_size, do_write);
-	kunmap_atomic(buf);
+	kunmap_local(buf);
 
 	if (!do_write && !PageSlab(page))
 		flush_dcache_page(page);
@@ -763,9 +763,9 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 	trace_atapi_pio_transfer_data(qc, offset, count);
 
 	/* do the actual data transfer */
-	buf = kmap_atomic(page);
+	buf = kmap_local_page(page);
 	consumed = ap->ops->sff_data_xfer(qc, buf + offset, count, rw);
-	kunmap_atomic(buf);
+	kunmap_local(buf);
 
 	bytes -= min(bytes, consumed);
 	qc->curbytes += count;

base-commit: 3bab8c7e0c6ba187a47163a1f71477213a278c48
-- 
2.55.0

