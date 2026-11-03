Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739300;
	b=lg5o0sVZTphsbs+Im6k1q4uW1T/WNxpq1mpjpo0P0Ip14UsyFRVGWHcG4bhL3G77U6yO
	 XHiw33zJGg8S5tYoWlfqSCBcFTKm+dN/4X6m9qbmrzc0JG9ogtIK0+vfzCOy1rl0s6cZH
	 MdjNDaca3X+Jb0G2xo356kK83PWasabDbSdq8i6Rh06vgO9SXmc8dnk3O8te5Yf/2Dck0
	 ZZtzFoE5x7L3XRS3t3XC0e/Xix4EMjuo4Tjtd9+crFtyx599uAmOtujLxT0F6rcjx5X/R
	 vWW7DEP23SI5euUpmONSaXN8dP+Fp3p7lwlia5FSWi1es7ysmxC/xltI9lQuDR/21hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739300;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=f5BG/BYpM//IjKk5PS+CyJ1iDYb6SqBTyJuKjBqfuew=;
	b=eOswoZuA2kXj+EVl5vtKwEF0OtNIGiJAQtzazCM0Hd69kxVCYuyOtRgaB0wfT+0o5vM6
	 X/oWBrRq39yiKH2rwQxI3lDfesCycYcQQ5oUn2Sc4bRPARbg7ymVTSVuj0Y5lq1Vp0qbE
	 CZOrj42QFJEm7db+pEgGUxjN+gkWaMv8KVqOP26PyOj4fh9eZhMdBfNr9gx7KeGe/RrIQ
	 THoYelSPaOvY6qepexFT9NSnGnBSwaZtpNjsFVJlL19itI/eAeb5wbsi3SEHNptIrsZzH
	 dbF9kkRqFhr73xeupbP9hKM8AQ6nzXFXk8AFmBIaOrA+jpoai4Gb74SoTIa4+/fhjFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6bo5w3f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6C606A31B
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6bo5w3f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD281F00919;
	Tue,  3 Nov 2026 20:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739299;
	bh=f5BG/BYpM//IjKk5PS+CyJ1iDYb6SqBTyJuKjBqfuew=;
	h=From:To:Cc:Subject:Date;
	b=P6bo5w3fxU338EuMcx8MVtytnSebKVgTlWIVHBCYP2jzJfdDUNL6NVDXpKT6AisZg
	 rUf/id+4n5HEWrtTDvSiqLXYFbbug3Vu8CW5DTTl3vGribKoJ0OOoH02gJtRqElz8i
	 CJyTxQltniryGg16qPFPEKl7tLlsL9B1UOrvDJP35E8ktd8vGUc0j1BVds81mjiwOW
	 QcgXkVsKwCcgca2BHA3/YE5wg+qoQlZywxQp4wjbT1w1YAfnnfCnZDuEvD29B1iV6t
	 8uoSgXOzztZwi7jVB6Sp2vauH5qiRJeU3apY61HliFQXOh9i13fjFFH4LCMcZqA86L
	 XiglWXMs+7B8A==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/8] ata: libata-scsi: MODE SELECT fixes and cleanups
Date: Tue,  3 Nov 2026 21:54:49 +0100
Message-ID: <20261103205448.931471-10-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4726; i=cassel@kernel.org; h=from:subject; bh=UJUoITVvL5i08ox+eKDxcEvjnD/yEffg/dVZpkqHKkg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJeeUnMCF7dc6l2pv9a+9/CDfpHf59btP6pGP+8rZMTX 6eemyw1q6OUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATaX7L8Ff2mV3D9Mqs99MU XmfktopcW1LyZbnQIRurc2uPv1jbL/iYkWHK+vV8lv9WCX1RSwxV3rjc7IvXKf3jYklPH3j/elp 15T8TAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This series fixes several problems in the MODE SELECT translation of
libata, most of them related to the FIELD POINTER reported in the sense
data when a MODE SELECT parameter list is rejected, and makes the MODE
SELECT mode page handlers significantly easier to follow.


Most of these bugs were caused by the code being more complicated than
it needs to be.

Each mode page has a fixed format, and may only be sent in that format:

  Caching mode page:             SPF=0, page_0 format (no SUBPAGE CODE)
  Control mode page:             SPF=0, page_0 format (no SUBPAGE CODE)
  ATA Feature Control mode page: SPF=1, sub_page format (SUBPAGE CODE F2h)

SAT defines the SPF bit of the Caching and Control mode pages as not
changeable and set to zero, and requires it to be set to one for the ATA
Feature Control mode page. A MODE SELECT that sets the SPF bit to a value
that does not match the mode page must therefore be rejected with
INVALID FIELD IN PARAMETER LIST, as required by SPC.


This makes it possible to simplify the code significantly, by passing
the whole mode page, starting with its mode page header, to the
handlers, just like the ata_msense_*() functions generate the whole mode
page. Offsets in the mode page buffer are then the byte numbers of the
mode page, as used in the mode page definitions of SPC, SBC and SAT, the
handlers can compare it with the mode page generated by the matching
ata_msense_*() function without adjusting offsets, and the conversion
done by ata_scsi_mode_select_xlat() becomes correct. This also allows
reporting an invalid PAGE LENGTH at the PAGE LENGTH field, which was not
part of the buffer before.


The series was tested in QEMU, by sending MODE SELECT(6) and MODE
SELECT(10) parameter lists to an AHCI disk via SG_IO and checking the
returned sense data, and by switching the cache_type of the disk.

The FIELD POINTER reported before and after this series, for MODE
SELECT(10) parameter lists without block descriptors unless noted
otherwise:

  Parameter list                                     Before After Correct
  Caching page, byte 3 changed                            9    11      11
  Caching page, byte 3 changed, MODE SELECT(6)            5     7       7
  Control page, byte 3 changed                            9    11      11
  ATA Feature Control page, CDL_CTRL 01b                  8    12      12
  CDL enable while NCQ priority is enabled                7    12      12
  Caching page, PAGE LENGTH too short                    25     9       9
  ATA Feature Control page, PAGE LENGTH too short        19    10      10
  Caching page, SUBPAGE CODE 01h                          8     9       9
  Control page, SUBPAGE CODE FFh                          8     9       9
  BLOCK DESCRIPTOR LENGTH 16                             30     6       6
  BLOCK DESCRIPTOR LENGTH 16, MODE SELECT(6)             23     3       3
  BLOCK DESCRIPTOR LENGTH 4                              18     6       6
  Caching page followed by Control page               65535    28      28
  Control page followed by 1 byte                  accepted    20      20
  ATA Feature Control page followed by 1 byte         65535    24      24
  Caching page, SPF=1, SUBPAGE CODE 00h            accepted     8       8
  Caching page, SPF=1, SUBPAGE CODE FFh            accepted     9       9

"accepted" means that the command completed without error. Before this
series, the Control mode page followed by 1 byte was applied, ignoring the
extra byte, and the ATA Feature Control mode page followed by 1 byte, which
requests enabling CDL, updated the CDL enabled flag of the device even
though the command was rejected. As only one mode page per command is
supported, data after the mode page is rejected at its first byte.

These patches were developed with the help of an AI coding assistant.


Niklas Cassel (7):
  ata: libata-scsi: fix MODE SELECT handling of data after the mode page
  ata: libata-scsi: do not accept subpage code FFh in MODE SELECT
  ata: libata-scsi: reject MODE SELECT mode pages with a wrong SPF bit
  ata: libata-scsi: fix MODE SELECT field pointer for unsupported
    subpages
  ata: libata-scsi: fix MODE SELECT field pointer for block descriptor
    length
  ata: libata-scsi: pass the whole mode page to the MODE SELECT handlers
  ata: libata-scsi: document the MODE SENSE mode page functions

Shao Mingyin (1):
  ata: libata-scsi: set the field pointer when rejecting CDL

 drivers/ata/libata-scsi.c | 278 ++++++++++++++++++++++++++------------
 1 file changed, 195 insertions(+), 83 deletions(-)


base-commit: 6ba53556f93f79e5273d9a5fcd39c3ba3b0ea391
-- 
2.56.0

