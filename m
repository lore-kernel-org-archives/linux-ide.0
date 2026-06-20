Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39248DF6C;
	Sat, 20 Jun 2026 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781922990; cv=none; b=WGWz1itbHXRoQBzt6StIVMV8HJ9tlV+q5w7EoCYIYVUX1SxmYLZi7X0okB5Xogt0XKEsPwIvWD+DLrHAXJXSuVsWYPx92ePyl4/tPVpSqsktefBOjSECxuynvnyrFWlVJx10FvMNBxNIkZonqxChXpZift95LwJPLRo1srNS3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781922990; c=relaxed/simple;
	bh=sl+x0zbv7W4APzUsTzopmwRWUhyw4YHCdBIiabkqoQ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xr/6ANXdaYftpHlh9UnaZroeiOp1zV9/vYd/SgM3FxYubbqIWPGVYMze9pc1Q1tMYA3l6q1uIFIOIbHg+BOITlnIJH9YCRM2QJh6d6Y16N8WC1M45qp4E+wIwJl5WWRZUcgz/sMIlvXXLvBloP/QAF4yKd1Kfc42OPinAAaxoc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlIrIzlg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlIrIzlg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D29DEC2BCB4;
	Sat, 20 Jun 2026 02:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781922989;
	bh=sl+x0zbv7W4APzUsTzopmwRWUhyw4YHCdBIiabkqoQ4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TlIrIzlg8ro/K2KMH9q/6AKlrbzDwTJhj2Me051wYDUU2FdA6utCAZttoqOjnwjDC
	 hf2EbVOjTAf1/AnzkEdMg2EdfxucYInrbjgLvx8N7Aafe09cYLIFtmcWuZb/AiMlo5
	 qj2/h6bGrogKTqHS1yS2Ds0WOq+Q8p/XyCF1VNogeU95LIl2tuxf2UmjJKEu0SblSu
	 epENFTGHaZ6f2oCbJWlH8NwVQmo9NhU0PjbqodgBYl44r5a5vwyaD2HJUp9ZDmsfRI
	 CTzc2Cti4oFzxLVbhxoy7xkJerVfqhkCQKkUptX/onaNKPti2R1stjisbQi6JT3/Bu
	 A2L0OUbVOaXgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB484CD98F6;
	Sat, 20 Jun 2026 02:36:29 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Subject: [PATCH 0/2] ata: bound the concurrent positioning ranges count
 from the device
Date: Fri, 19 Jun 2026 21:36:28 -0500
Message-Id: <20260619-b4-disp-6200c44e-v1-0-4624a4707d9e@proton.me>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKz8NWoC/x3MQQqAIBBA0avIrBvQQSy7SrQwnWo2JQoRRHdPW
 r7F/w9ULsIVRvVA4UuqnEeD6RTEPRwbo6RmIE1OO+NxsZikZnSkdbSWMbmwROoHT2yhZbnwKve
 /nOb3/QBC4v2aYgAAAA==
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781922988; l=2755;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=sl+x0zbv7W4APzUsTzopmwRWUhyw4YHCdBIiabkqoQ4=;
 b=HgLMQDLpCbpEDXXJOuNP5DT0+IsyEoECbM7+duD9INuzwkmtnaKmHx0AEFQJB17+KJgCVZUV1
 J6CfokVDrQCDb1x9Nyl1DO4ltd6x0MJZSSlw3kfUZJOaOhBHaUxqYNW
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

The concurrent positioning ranges log (0x47) reports its number of range
descriptors in the first byte, up to 255. Two paths walk that count at a
fixed 32-byte stride into a buffer whose size does not depend on it, with no
bound:

  1/2  ata_dev_config_cpr() reads nr_cpr=buf[0] descriptors out of a buffer
       sized from the (independent) GPL-directory log length. A small log
       with buf[0]=255 reads up to 7704 bytes past the slab; those bytes then
       reach the initiator via VPD B9h. Regression of c745dfc541e7.

  2/2  ata_scsiop_inq_b9() writes cpr_log->nr_cpr descriptors into the fixed
       2048-byte ata_scsi_rbuf. More than 62 ranges overflows it by up to
       6168 bytes.

Both counts come from the device, so the trigger is a malicious or faulty
drive (or an emulated one); 2/2 is then reachable by any INQUIRY VPD B9h,
including unprivileged SG_IO. drivers/scsi/sd.c:sd_read_cpr() derives the
count from the validated page length instead; these two paths don't.

They need separate bounds. With a large but self-consistent log
(buf_len=8704, buf[0]=255) the 1/2 clamp leaves nr_cpr=255: the read stays in
bounds but the 2/2 emit into the 2048-byte buffer still overflows. An
alternative for 2/2 is to grow ata_scsi_rbuf to the full page size
(64 + 256*32); I bounded the emitted count instead, since that buffer is
shared by every INQUIRY actor. Happy to switch if you'd rather size it.

A-B summary -- count vs buffer, both paths, unpatched vs patched, identical
on -m64 and -m32:

  path   nr_cpr  buf_len  unpatched        patched
  read   14      512      safe (boundary)  safe
  read   15      512      OOB read         safe
  read   255     512      OOB read         safe
  read   255     8704     safe             safe
  write  62      -        safe (boundary)  safe
  write  63      -        OOB write        safe
  write  255     8704     OOB write        safe   <- the cross-path case above

Early-return guards (major version < 11, absent log, zero count, NULL
cpr_log) and the unreachable buf_len < 64 underflow edge were checked too;
the 1/2 clamp is written to stay safe there. Reproducer modules (out-of-tree
KASAN sink-mirror + a userspace ASan twin, -m64/-m32) available on request.

---
Bryam Vargas (2):
      ata: libata-core: Clamp the concurrent positioning ranges count
      ata: libata-scsi: Bound the VPD B9h ranges to the response buffer

 drivers/ata/libata-core.c | 11 +++++++++++
 drivers/ata/libata-scsi.c | 12 +++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260619-b4-disp-6200c44e-d6abc27892e4

Best regards,
-- 
bryamzxz <hexlabsecurity@proton.me>


