Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B648E0E7
	for <linux-ide@vger.kernel.org>; Tue, 22 Sep 2026 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101621; cv=none; b=OdS1XcQaBQn0vfV4/J7IzyRtQoKH63ngGqPqInv3IvE9B6ZosTp6cNcLPz7h6qoN9XzGXS7g7IBCCsTY3csfecPKqIiucjPb/2MUrA3f/y3enEZ9P9NVop1HKaSFtwXvJDwp6JBz/jj3z49iMpbjpIBbbYfccovgCU8xHSps9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101621; c=relaxed/simple;
	bh=byoBrJIoQXZTuPf9GsZIBDK4FdjAZpb1BrnfoGWJZRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HphLxi+eBzvJU4tiWyKf0jxCVOfa0ef75fYf3GY1kismgxHUVHW+UYgbvafWxIEErzI6JZHsmRme32h2qLcr1gF26jRWJcmb+jRKrB3Qoh0khERN7LO2zdgDo8cqLSZxzRGNFT/unoI/hJzudEnNgIt56s3t+Ec1c1yuULcGb4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jco0PSf8; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jco0PSf8"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso180366a12.2
        for <linux-ide@vger.kernel.org>; Tue, 22 Sep 2026 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101619; x=1790706419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/wiz0Foooqtebc+pPDKHlqOysQ9uT0UIO/Y22KOvVgU=;
        b=jco0PSf8w0T9+Vsw0MpOkLkAfBoaD9oLM9PIPqsTe5WzA7HIEJxFZ+b1igCmSM0rFb
         gJuc/vzETTYVyr6d02oeypgWxsMs789j6ZwrQdGPVik21eW+ATndNowtZ2IHuAfc2JNV
         xOc3/Za3s/53oq33d/GRCRDPvXK9LkPWQ7jtleiEuZcu7bizqFllebm/XvqNTAnvNpqO
         SB+J63XhCCx+ihcDwkkd9rai7d1TRGuvxPXHHZ/MGaiOb2LpAVTnz5D4NGtobvECCWdd
         b+/8RYBqS37xKlfIQF9PvmcgKIujbKPIhC2PLzGz9xOvTC9/vDJSB9DY7dGH9JMkyt1e
         GwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101619; x=1790706419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/wiz0Foooqtebc+pPDKHlqOysQ9uT0UIO/Y22KOvVgU=;
        b=REz3I/XtLAPIkQlKZHE5+uqwaobzRVf6eScQhkKP9bTZY0S0N4Rqg4HwLWeDAeFTWR
         JQMX0jFghBm4CQNaqRqYU0D+rXL2LmbdtvD+FHcuYhXGEok7v9akqVuYx941pSlpOqWc
         4xTBmASmgDJuB9SyP5PxZGvUxE/Ku0M9gTA6NZi5mrqoOOlmoAf3jnTlKN1/oQCZC56f
         8RHMP4u+9NsHZDdoiotD+nPyM0bU7i9vGF6rpUc+rICtluuGXBKgahDPjqsdWHoicM2K
         6CRxXJxc7fnqnsPOx/jJNKoDx+o+gXYuD7HqNDdd477LAxB8P+dWVNscQKZ0HEp7+OCN
         RdNQ==
X-Gm-Message-State: AFuF++njtBIUsrkmAGs3ny5m9fMgWlsNhhT7RaWgkYwDK6vTfRVZYbvT
	lIqEcsrE41E1qtCnLmAmsFXb9Gql+r6GJpUajM5GnA3cEb9rPIoxfraN
X-Gm-Gg: AYBFou2rH3XCqy6aHEyyHIAdrMLbnci7gMC1YagpSwy5+oJPpsenhsPhtgoidA5/M5J
	MvEtUiedjgh1zr5yC0xEGwIpnKqo/lELH58rKMRULa9fanDbGXcMbl7Ac9HIF7V3d0v6e8MflXV
	Jsz93f1/MPdF8bUvfRP3Usa6R196NeiBeuXiHrnm8oWCGbt2oze2FQKGH6qVaGt32CRxpjfIDub
	m0BVZLe7H1ureMXZBjaT3XlDNCdcmtDppG66hkseenM94p3EwvvdwF710QNAR7JnqJfC7Whu1Uh
	5FTezLwF/UNJoRmaoG0hihCCEw/kIxc7rUQzLOXMlEcLGiOV9BG48aAcBeAsXXZLAbglbbEJD7t
	awxHwJj2jeO8FwEcoGZbDf0emn9L3RaCzt7+TIKSAC3MH7kAn4vX9C6oe+6v2JxTH/tGXG+XTbM
	CizPcrAjU74pv08sct82ZJrKe5P86XAbWOt08GFGpFl9ET+tlxuE0i2qSV82Bfj8JxLigAa8lYD
	Pd2qEwS+LmW4UVXSwr1J2eu91SwCfwyuwPlaaceKmRpxXKOgCrThsSg2gg5zvH1JkW0NEfQPNKA
	uNfA7Sb4dyxMNdQbUufkrY/OG8tYcTSNQJsY9UFeZDKE8JHxGuMRrq4LWGm4bEGfLbKoSnSRGg=
	=
X-Received: by 2002:a17:90b:6cb:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-3a07e4a0c36mr280315a91.4.1790101619120;
        Tue, 22 Sep 2026 11:26:59 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07f820fd0sm24499a91.2.2026.09.22.11.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:26:58 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Goergens <matthias.goergens@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ata: libata-scsi: bound the ATA passthru sense descriptor writes
Date: Wed, 23 Sep 2026 02:26:55 +0800
Message-ID: <20260922182655.2423663-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an ATA PASS-THROUGH command to an ATAPI device fails, the sense
buffer holds the device's REQUEST SENSE reply, and
ata_scsi_set_passthru_sense_fields() trusts its additional length
byte, sb[7], when adding the ATA Status Return descriptor.  A faulty
or malicious device can use that to make the kernel read and write
past the 96-byte buffer in three ways:

- scsi_sense_desc_find() is passed sb[7] + 8 as the buffer length, so
  its clamp against sb[7] does nothing and the walk runs off the end.
- A type-9 descriptor found near the end is filled in unchecked.
- A new descriptor at sb[8 + len] needs len + 22 bytes, not len + 14,
  so len 75..82 writes up to 8 bytes past the end.

Reproduced with KASAN under qemu, with the emulated ATAPI REQUEST SENSE
reply patched:

  BUG: KASAN: slab-out-of-bounds in scsi_sense_desc_find+0x1a5/0x210
  BUG: KASAN: slab-out-of-bounds in ata_scsi_qc_complete+0x1a15/0x1a50

Both are gone with this patch, and a valid descriptor is still filled
in.

Fixes: 97981926224a ("ata: libata-scsi: Do not overwrite valid sense data when CK_COND=1")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 drivers/ata/libata-scsi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7e22bbc38238..40e56ff52f09 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -261,12 +261,18 @@ static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
 
 		/* descriptor format */
 		len = sb[7];
-		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
+		desc = (char *)scsi_sense_desc_find(sb, SCSI_SENSE_BUFFERSIZE, 9);
 		if (!desc) {
-			if (SCSI_SENSE_BUFFERSIZE < len + 14)
+			/*
+			 * The descriptor is written at sb[8 + len] and is 14
+			 * bytes long, so it needs len + 22 bytes of buffer.
+			 */
+			if (len + 22 > SCSI_SENSE_BUFFERSIZE)
 				return;
 			sb[7] = len + 14;
 			desc = sb + 8 + len;
+		} else if (desc + 14 > sb + SCSI_SENSE_BUFFERSIZE) {
+			return;
 		}
 		desc[0] = 9;
 		desc[1] = 12;

base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
-- 
2.55.0

