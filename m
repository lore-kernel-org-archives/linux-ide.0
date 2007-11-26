From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: bump transfer chunk size if it's
	odd
Date: Mon, 26 Nov 2007 20:58:02 +0900
Message-ID: <20071126115802.GC9232@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:52470 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbXKZL6W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Nov 2007 06:58:22 -0500
Received: by wa-out-1112.google.com with SMTP id v27so705067wah
        for <linux-ide@vger.kernel.org>; Mon, 26 Nov 2007 03:58:21 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

None of the drives I have follows what the standard says about
transfer chunk size.  Of the four SATA and six PATA ATAPI devices
tested, four ignore transfer chunk size completely and the ones which
honor it don't behave according to the spec when it's odd.

According to the spec, transfer chunk size can be odd if the amount of
data to transfer equals or is smaller than the chunk size and the
device can indicate the same odd number and transfer the whole thing
at one go with a pad byte appended.  However, in reality, none of the
drives I have does that.  They all indicate and transfer even number
of bytes one byte shorter than the chunk size first; then indicate and
transfer two bytes, which is clearly out of spec.

In addition to unnecessary second PIO data phase, this also creates a
weird problem when combined with SATA controllers which perform PIO
via DMA.  Some of these controllers use actualy number of bytes
received to update DMA pointer so chunks which are sized 4n + 2 makes
DMA pointer off by two bytes.  This causes data corruption and buffer
overruns.

This patch rounds nbytes up to the nearest even number such that ATAPI
devices don't split data transfer for the last odd byte.  This
shouldn't confuse controllers which depend on transfer chunk size as
devices will report the rounded-up number, actually transfer that much
and padding buffer is there to receive them.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |   35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -2485,11 +2485,40 @@ static unsigned int atapi_xlat(struct at
 	if (!using_pio && ata_check_atapi_dma(qc))
 		using_pio = 1;
 
-	/* Some controller variants snoop this value for Packet transfers
-	   to do state machine and FIFO management. Thus we want to set it
-	   properly, and for DMA where it is effectively meaningless */
+	/* Some controller variants snoop this value for Packet
+	 * transfers to do state machine and FIFO management.  Thus we
+	 * want to set it properly, and for DMA where it is
+	 * effectively meaningless.
+	 */
 	nbytes = min(qc->nbytes, (unsigned int)63 * 1024);
 
+	/* Most ATAPI devices which honor transfer chunk size don't
+	 * behave according to the spec when odd chunk size which
+	 * matches the transfer length is specified.  If the number of
+	 * bytes to transfer is 2n+1.  According to the spec, what
+	 * should happen is to indicate that 2n+1 is going to be
+	 * transferred and transfer 2n+2 bytes where the last byte is
+	 * padding.
+	 *
+	 * In practice, this doesn't happen.  ATAPI devices first
+	 * indicate and transfer 2n bytes and then indicate and
+	 * transfer 2 bytes where the last byte is padding.
+	 *
+	 * This inconsistency confuses several controllers which
+	 * perform PIO using DMA such as Intel AHCIs and sil3124/32.
+	 * These controllers use actual number of transferred bytes to
+	 * update DMA poitner and transfer of 4n+2 bytes make those
+	 * controller push DMA pointer by 4n+4 bytes because SATA data
+	 * FISes are aligned to 4 bytes.  This causes data corruption
+	 * and buffer overrun.
+	 *
+	 * Always setting nbytes to even number solves this problem
+	 * because then ATAPI devices don't have to split data at 2n
+	 * boundaries.
+	 */
+	if (nbytes & 0x1)
+		nbytes++;
+
 	qc->tf.lbam = (nbytes & 0xFF);
 	qc->tf.lbah = (nbytes >> 8);
 
