Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6661AB8EF
	for <linux-ide@vger.kernel.org>; Fri, 14 Jun 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392735; cv=none; b=AoR2K1VE8Wa/zWIeg/FVh9Kugut18R3V4WrNvCUBxQWM8NDJupjBumb+xL+mO5R1SqCKDX9UNb3rOCOE8EIc+oVC5v/DoQEuZ59oAVnOfUmAJ4AZcDaAHTp7x+MFQxWqH2PoC9ikJ1iOOueI0bFmb/n1sLhe41WhLIiMIjryIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392735; c=relaxed/simple;
	bh=qgmtNL4k97jHCwRfQqDmBVh7jd6+0c78XagNpSAyDsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f1fEvT7OPTmA3McVBdl/nmhogiGd6lCZAdXrw7nbW4CkhTP/XshDTI6FXm88FT8COQG8UsfbggRe+Ix3ral9tM9Gq9JiM0w2+WO/hoZquifq2rpiuxCX49rOCb+b8nEl0s+YHQdDcdJdcCFEfrk6Z10/olok9eESaoBwshuPn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6Yo+ktA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6Yo+ktA"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6cebd09196bso1602425a12.2
        for <linux-ide@vger.kernel.org>; Fri, 14 Jun 2024 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718392734; x=1718997534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4AyfSTdpu6N2Lo5b6nZ4La1DDoSqqNXNC9AYdKo6X0=;
        b=B6Yo+ktA4Y6r0pnzTunJVbAAVCggpn02WJlQah7rNLepgOF10Ue7B9hbbDHeNi7Sff
         um9ZhtjPxHctqi4rM1PiBTV76aZksTMo7WhKDr+/9VFuY/3XSpIzmj6JCix2hslAV258
         ePiqhnQd3WtakFp0EqYdtrqnPkCJLnXh+xZ8n9licsks2I5uaws8Gd1lP9p5hK8vMVt0
         YLKsnZFUXagyci6m77TSRQC68AGLEJmaZMDgfqKYkvRmTb4C7N/HvXXLOme0jOI0dpKo
         a7Ye4bfKLypEV9dxmSQUUY5bwYpmTyLVPS2tw085zPtGWseih0JJ6UKT64ChrRd+andL
         ehRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718392734; x=1718997534;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/4AyfSTdpu6N2Lo5b6nZ4La1DDoSqqNXNC9AYdKo6X0=;
        b=SxhscAd9fg9lZxzt8wYNMqt2kbFzYS1VTPr+HEMnvGlOscy8smeFcGJ5CklcxyiLRI
         vwZTOHompufAijgmIDTrmIsd2eId89KZC0e8230OBXQm7LbVFWLV/Cz8cy4gIV1keKPw
         jHdCe4hcvG7b3YlFhEoaP2HFaGZO6xA9mxeg11heQGHT4VgwVXvrO1zN5uDhW2Nhkhej
         gGGPHpfQq6Eh+tucxcM9QYqSkdKUxZJX60qTttrDoBOzgMwlPMJQgJnQv53hyI6jH+yG
         HjEQYKGBUiQVPYDMDT/k0DiWv/BVwLd69VSGXIXuJhZbPwltc+oX8EcoK6blPsAFSXvC
         EDoA==
X-Forwarded-Encrypted: i=1; AJvYcCWF5lWRYQ6eLQSMxlCdgtPDOdewQEOm7dab93lZueBxP/tdXp3NKKvBHKiB6Vd3gOEWddnze+a08360avaErCC+k83pQJUHuHUn
X-Gm-Message-State: AOJu0YxN6J8IeZyglxgFQl4iWQC76vR/LNQ50Eb01EROP6dsa/rSnVix
	izG57Sb9B7Nsx+uc+iBOdc2yq5e/elVCbUZcT1ZI43Sl1LVh8iWm9q2mA6i4vAwcmFVFh4v7Nzu
	CUBACgr7Fgw==
X-Google-Smtp-Source: AGHT+IFhH0CY+7Imr4D7VPghy++YvEZgaw5IeIxH2RrSR71z103r+UyBHoV1Cf87mIAHSR19WF+ZEMhiq4U01Q==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a63:4c04:0:b0:6ea:87eb:9493 with SMTP id
 41be03b00d2f7-7019504fd99mr9226a12.2.1718392733536; Fri, 14 Jun 2024 12:18:53
 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:18:35 +0000
In-Reply-To: <20240614191835.3056153-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240614191835.3056153-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614191835.3056153-5-ipylypiv@google.com>
Subject: [PATCH v1 4/4] ata: libata-scsi: Fix offsets for the fixed format
 sense data
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	Akshat Jain <akshatzen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Correct the ATA PASS-THROUGH fixed format sense data offsets to conform
to SPC-6 and SAT-5 specifications. Additionally, set the VALID bit to
indicate that the INFORMATION field contains valid information.

INFORMATION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

SAT-5 Table 212 =E2=80=94 "Fixed format sense data INFORMATION field for th=
e ATA
PASS-THROUGH commands" defines the following format:

+------+------------+
| Byte |   Field    |
+------+------------+
|    0 | ERROR      |
|    1 | STATUS     |
|    2 | DEVICE     |
|    3 | COUNT(7:0) |
+------+------------+

SPC-6 Table 48 - "Fixed format sense data" specifies that the INFORMATION
field starts at byte 3 in sense buffer resulting in the following offsets
for the ATA PASS-THROUGH commands:

+------------+-------------------------+
|   Field    |  Offset in sense buffer |
+------------+-------------------------+
| ERROR      |  3                      |
| STATUS     |  4                      |
| DEVICE     |  5                      |
| COUNT(7:0) |  6                      |
+------------+-------------------------+

COMMAND-SPECIFIC INFORMATION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

SAT-5 Table 213 - "Fixed format sense data COMMAND-SPECIFIC INFORMATION
field for ATA PASS-THROUGH" defines the following format:

+------+-------------------+
| Byte |        Field      |
+------+-------------------+
|    0 | FLAGS | LOG INDEX |
|    1 | LBA (7:0)         |
|    2 | LBA (15:8)        |
|    3 | LBA (23:16)       |
+------+-------------------+

SPC-6 Table 48 - "Fixed format sense data" specifies that
the COMMAND-SPECIFIC-INFORMATION field starts at byte 8
in sense buffer resulting in the following offsets for
the ATA PASS-THROUGH commands:

Offsets of these fields in the fixed sense format are as follows:

+-------------------+-------------------------+
|       Field       |  Offset in sense buffer |
+-------------------+-------------------------+
| FLAGS | LOG INDEX |  8                      |
| LBA (7:0)         |  9                      |
| LBA (15:8)        |  10                     |
| LBA (23:16)       |  11                     |
+-------------------+-------------------------+

Reported-by: Akshat Jain <akshatzen@google.com>
Fixes: 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense"=
)
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4bfe47e7d266..8588512f5975 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -855,7 +855,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cm=
d *qc)
 	struct scsi_cmnd *cmd =3D qc->scsicmd;
 	struct ata_taskfile *tf =3D &qc->result_tf;
 	unsigned char *sb =3D cmd->sense_buffer;
-	unsigned char *desc =3D sb + 8;
 	u8 sense_key, asc, ascq;
=20
 	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
@@ -880,8 +879,9 @@ static void ata_gen_passthru_sense(struct ata_queued_cm=
d *qc)
 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
=20
-	if ((cmd->sense_buffer[0] & 0x7f) >=3D 0x72) {
+	if ((sb[0] & 0x7f) >=3D 0x72) {
 		u8 len;
+		unsigned char *desc;
=20
 		/* descriptor format */
 		len =3D sb[7];
@@ -919,21 +919,21 @@ static void ata_gen_passthru_sense(struct ata_queued_=
cmd *qc)
 		}
 	} else {
 		/* Fixed sense format */
-		desc[0] =3D tf->error;
-		desc[1] =3D tf->status;
-		desc[2] =3D tf->device;
-		desc[3] =3D tf->nsect;
-		desc[7] =3D 0;
+		sb[0] |=3D 0x80;
+		sb[3] =3D tf->error;
+		sb[4] =3D tf->status;
+		sb[5] =3D tf->device;
+		sb[6] =3D tf->nsect;
 		if (tf->flags & ATA_TFLAG_LBA48)  {
-			desc[8] |=3D 0x80;
+			sb[8] |=3D 0x80;
 			if (tf->hob_nsect)
-				desc[8] |=3D 0x40;
+				sb[8] |=3D 0x40;
 			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
-				desc[8] |=3D 0x20;
+				sb[8] |=3D 0x20;
 		}
-		desc[9] =3D tf->lbal;
-		desc[10] =3D tf->lbam;
-		desc[11] =3D tf->lbah;
+		sb[9] =3D tf->lbal;
+		sb[10] =3D tf->lbam;
+		sb[11] =3D tf->lbah;
 	}
 }
=20
--=20
2.45.2.627.g7a2c4fd464-goog

