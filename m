Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092114;
	b=Qed5xbcPcMowmBDwPNLl/cAmymLJrncufeLWWUZ8vmGGh89QjoacZP38Mht7ncc65aWU
	 cvtEEadzvbr/iV8Oql0MqVp/JCf56kpaSZgtVbRlCl3WmAQKhp81l6W4tzeoc2iM6PnId
	 v0xoGJWiizddUVKXaoxnZZsGXz1IqbMJyGA/ilgHPgF8ieUMdO5+fpx5A2qnfpAW+Djfm
	 UDiIqODdf35W1/0SpvLMpT49J1YY9dgUrI1ejNuJpd/elSqA0KETq1iXh0+zaVdlMLbGD
	 3+e5ZNMcgYNkJCMZm3zoI/jqHrYBkc+l209Xyc8/2l5UKa8yDHk5y3904aFYqhsITnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092114;
	h=DMARC-Filter:DKIM-Signature:Content-Transfer-Encoding:Content-Type:
	 Date:Message-Id:X-Original-From:X-Lms-Return-Path:Cc:Subject:To:
	 X-Mailer:From:Mime-Version;
	bh=kDiKhnpR+rplcMQYgHFJZgudNbuciPpjRLcKNluE7GY=;
	b=tn6vF4Nr+d49pEzg/eYe1TT1oiJj9KRiD7VWRdmyJnPtWS4XYcYHIGbpAYHKuubu1q0/
	 n4Yn1SxzkqDMY2dPisKnujs1hRkXeo91iuCiwtXrqhG6Ht3ChVOVLKQjsOyU92lmwD8NG
	 Jijn4Y7W3ouDo6b74TXixfnlU82GvrGecLoDdisNHZKl/Sl8qNt60KkIgrSpCuGZ8fEj8
	 Do0rhuDy7rHmEn1mbibnnq+7j98IwcBnQhP5x2SKeyucpT/SylKXZfsjqvHajAT72AFxe
	 4PmHM9bQ/YlaUz8UW2gCUydSbMYVOnzmoBj4kfKbHw2yfyJ4ZSc0SJ3CZzxZlh9miDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=gQGQpjDE;
	arc=none smtp.remote-ip=209.127.231.111
Received: from va-2-111.ptr.blmpb.com (va-2-111.ptr.blmpb.com [209.127.231.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9F606A31B
	for <linux-ide@vger.kernel.org>; Tue, 27 Oct 2026 09:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12B9F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=gQGQpjDE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793092107; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kDiKhnpR+rplcMQYgHFJZgudNbuciPpjRLcKNluE7GY=;
 b=gQGQpjDEdaGyWcrFixPWZ8NkgZEsMhzYSUKuftf0r1z1eGIvs9jukVvzAM/BPSIoVJook2
 qZkSBF9hWuafthUcbVHuE6GbYO8Nn5zM3o1dMZliJQGNIEyqeCbPIrZK9QpPhpzf6VuFnb
 gSldzqV2mXGwu3yf7WMRqRuB/AamIlF32vkJVyeYeZDG1vz+eYdKeQ08GmTWzIECOTo9Gh
 A2c2bLySVU+0/HsckPghzPkj7aHQv3DGL32IgQlnjQSRxq1aGOToXwGFq/E5+pW+yytodN
 CmjKeeNlnnz+PTy/po36ABcftXygiwEqIvpJmadl3nps1DGQHcu7YlWYqV3Mng==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 17:08:09 +0800
Message-Id: <20261027090809.94126-1-zhaogongyi@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
X-Lms-Return-Path: <lba+26ae06a09+93a4b4+vger.kernel.org+zhaogongyi@bytedance.com>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: [PATCH] ata: libata-scsi: reject to-device transfers for simulated commands
To: <dlemoal@kernel.org>, <cassel@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0

ata_scsi_rbuf_fill() emulates commands that only return data to the
initiator (INQUIRY, MODE SENSE, READ CAPACITY, REPORT LUNS and
MAINTENANCE IN).  It builds the reply in a kernel buffer and then copies
it into the request's scatterlist without looking at the transfer
direction.

The scatterlist is built from the user buffer by the passthrough paths
(bsg/SG_IO), which derive the data direction from the transfer lengths
supplied by userspace.  A request can therefore carry a data-in command
while declaring a to-device transfer.  The buffer is then pinned for
reading only.  In the observed crash, an anonymous VMA covered the
buffer address, but its page was not populated; the read-only pin
resolved to the shared zero page.  Copying the reply into that
scatterlist attempted to write to a read-only kernel page:

  BUG: unable to handle page fault for address: ffff888005140038
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0003) - permissions violation
  PGD 7d00067 P4D 7d00067 PUD 7d01067 PMD 80000000050001a1
  RIP: 0010:memcpy_orig+0x68/0x140
  Call Trace:
   sg_copy_buffer+0x1e2/0x250
   ata_scsi_rbuf_fill+0xe6/0x280
   __ata_scsi_queuecmd+0x12e4/0x1580
   scsi_queue_rq+0x1ff7/0x33d0
   blk_execute_rq+0x1c5/0x390
   scsi_bsg_sg_io_fn+0x3bc/0xb00
   bsg_ioctl+0x3ef/0x550

The faulting address falls inside the kernel rodata mapping and matches
empty_zero_page (Kernel rodata 05000000-05dc2fff, empty_zero_page at
physical 0x5140000), which confirms the reply copy attempted to write
to the shared read-only zero page.

Even when the pinned page happens to be writable the reply silently
corrupts the user buffer, since it was not mapped for writing.  Reject
to-device transfers for these commands with an ILLEGAL REQUEST sense
instead of copying the reply into them.  This is the same class of
problem as commit 5da5231bb478 ("libata: if T_LENGTH is zero, dma
direction should be DMA_NONE"), which rejects inconsistent data
directions for ATA pass-through commands.

Reproduced on 7.3.0-rc6 with the syzkaller C reproducer against an
ata_piix disk (/dev/bsg/0:0:0:0): the unpatched kernel panics on every
attempt (4/4), while with this change the request completes with CHECK
CONDITION and the reproducer survives 5/5 runs.

Standard-length CDBs behave the same way.  A correctly directed 6-byte
INQUIRY still completes normally, while a 6-byte INQUIRY and a 10-byte
READ CAPACITY(10) declared as to-device are rejected with CHECK
CONDITION; on the unpatched kernel those same requests silently write
the reply into the caller's page (the transfer has to be page aligned to
take the zero-copy mapping path, otherwise it bounces through a kernel
buffer and nothing is visible to the caller).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
 drivers/ata/libata-scsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b3666519b..8b65b896e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2009,6 +2009,12 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
 	unsigned long flags;
 	unsigned int len;
 
+	/* A data-out request may contain pages pinned without write access. */
+	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST, 0x24, 0x0);
+		return;
+	}
+
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
-- 
2.39.5 (Apple Git-154)
