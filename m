Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135919;
	b=O2xjy8IO/qK/Os9FuCesoUkVSL3qCJQqg4J3uzXipwDWabP1+d5OmeSZesDQKIGnjSbV
	 Ai+OEoJuJzsPhQwaItTp4nnpI9OtNwzy68k6cq4NULqAxoA1UDbMksWJpFNNtGMAQplfb
	 leYGPgMBT1lbDlA0a5dR3Mmp0rVH2hDllsRezKhpDoEg/7zgQxb+HIKeWS8XBYhx5HhO3
	 E9wCJioOLfX8hT2KafojMAxqe0tkgycItvM1RrLxS5HlXpty4OPUeRONYRMCRN8tpJdv8
	 V/9f6vDsv1cE32XcYjBHyMQ5lNn8opEMI8NgKVSCN9N4gVJuljvxsRFXJuzMFefkxzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135919;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XDerHtkHAJbRk0F/9XgEQan6CROvKA2Jy+iE+e/awQ0=;
	b=J/AZW7vzjhiFMLVOSqxqr+7RxdTHWLKNTWJfxlYOkFdIy/7ydpjV2HDdmX86+ax91VRT
	 wqOKRsCgsTneTp4whErWIDNf/5wh7EKQo6kCs2YwYtjjT41Eeyzea4ADfQ/lAvFhfnaxY
	 rKDCZKZeQNrywjVdtTKLJBD0ZaKU7TeW9NCcdROSuGNyETs8ZsPR7/tUKw7XXcxn5VGCo
	 a3Xb84SjcCyY9WziE5al0JB+wHhfUk7UAZNNSHaCxyrEdZdMgHXVbZ/LBOiuQdfgorr82
	 dkngfOCABgtq+hgh8XVaxm0Hhpq5QhoOISN6m25e38N1IhzP/A2XX6Y/23iZhAIHPRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldDcHkEe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F1606A326
	for <linux-ide@vger.kernel.org>; Sun,  8 Nov 2026 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldDcHkEe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBDA1F008A1;
	Sun,  8 Nov 2026 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794135919;
	bh=XDerHtkHAJbRk0F/9XgEQan6CROvKA2Jy+iE+e/awQ0=;
	h=From:To:Cc:Subject:Date;
	b=ldDcHkEeYEmllEK/BUQ+3p6r8PDUjaABW/yMDVm1tGSgYSgihP/uFxlGuu8pkJi/0
	 BfvlpjNZKSormvTh7E1zrAQmPGXufKlNqcJnWBLXsVssj7+D3vMh5HNpKc3tLeurry
	 QYYiX28HOyMl5DvBHuLty2w+Vu7bqUXkX4CIZn8ZiGwDs/5UbXmhS0+J3OH0boPlhW
	 86qZxavkBeuXZsFt90Fh4Wb9HQs4SZg0mc23OZZD3PQ0kChUijNu+l6aPbNLiqHt9f
	 K598th8rENUZNJPrGTMjgGg2ob5lQjcRsFC8g6D+t0GUV5sk4Pibwh7UHgAq5lp9MJ
	 2m4aPlkDxuIfg==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.4-rc2
Date: Sun,  8 Nov 2026 12:04:35 +0100
Message-ID: <20261108110435.1028471-1-cassel@kernel.org>
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
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc2

for you to fetch changes up to a4845f077415ef32fe672c841e2fc58ae9e28273:

  ata: libata-scsi: reject data-in commands with a data-out buffer (2026-11-07 14:35:25 +0100)

----------------------------------------------------------------
ata fixes for 7.4-rc2

 - Allow re-enabling NCQ, after EH disabled it, by writing the current
   queue depth to the queue_depth sysfs attribute (Igor)

 - Retry failed non-NCQ commands when their sense data asks for a
   retry, as is already done for NCQ commands. Previously, such
   non-NCQ commands were never retried (me)

 - Only check the power mode of ATA and ZAC devices before putting
   them in standby mode (on suspend, shutdown or device removal).
   libata never puts other devices, such as ATAPI devices, in standby
   mode, and some ATAPI devices reject the CHECK POWER MODE command
   (Giuseppe)

 - Fix several bugs in the MODE SELECT translation.

   Reject parameter lists with data after the mode page before the
   mode page is handled. Previously, a rejected command could leave
   the CDL enabled state tracked by libata out of sync with the
   device, and data after the control mode page was silently ignored.

   Reject mode pages with SUBPAGE CODE FFh, and mode pages with the
   SPF bit set but SUBPAGE CODE 00h, which were incorrectly accepted.

   The commit that passes the whole mode page to the MODE SELECT
   handlers might look like a cleanup, but it is a fix, and thus has
   a Fixes tag: the FIELD POINTER pointed 2 bytes (page_0 format) or
   4 bytes (sub_page format) before the invalid byte in the mode page
   (me, Shao)

 - Disable the enclosure management (SEMB) port of the Marvell
   88SM9705 port multiplier. The port never answers SRST, and the
   resulting EH retries delayed disk discovery by minutes (Marco)

 - Reject data-in commands, e.g. INQUIRY, submitted via SG_IO with a
   data-out buffer, whose pages may be pinned without write access.
   Writing a reply to such a buffer could oops the kernel (Zhao)

----------------------------------------------------------------
Giuseppe Piscitelli (1):
      ata: libata-core: Check device support before querying power state

Igor Pylypiv (1):
      ata: libata-sata: allow re-enabling NCQ with the same queue_depth

Marco Ziliani (1):
      ata: libata-pmp: disable the SEMB port on Marvell 88SM9705

Niklas Cassel (7):
      ata: libata-eh: Retry non-NCQ commands when their sense data asks for it
      ata: libata-scsi: fix MODE SELECT handling of data after the mode page
      ata: libata-scsi: do not accept subpage code FFh in MODE SELECT
      ata: libata-scsi: reject MODE SELECT mode pages with a wrong SPF bit
      ata: libata-scsi: fix MODE SELECT field pointer for unsupported subpages
      ata: libata-scsi: fix MODE SELECT field pointer for block descriptor length
      ata: libata-scsi: pass the whole mode page to the MODE SELECT handlers

Shao Mingyin (1):
      ata: libata-scsi: set the field pointer when rejecting CDL

Zhao Gongyi (1):
      ata: libata-scsi: reject data-in commands with a data-out buffer

 drivers/ata/libata-core.c |   8 +-
 drivers/ata/libata-eh.c   |  16 +++-
 drivers/ata/libata-pmp.c  |  14 ++++
 drivers/ata/libata-sata.c |   2 +-
 drivers/ata/libata-scsi.c | 206 ++++++++++++++++++++++++++++++----------------
 5 files changed, 168 insertions(+), 78 deletions(-)
