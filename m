From: Jeff Garzik <jeff@garzik.org>
Subject: Random libata notes
Date: Sat, 04 Mar 2006 12:33:40 -0500
Message-ID: <4409CF74.7030808@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:34735 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932249AbWCDRdn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Mar 2006 12:33:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>

These are small TODO bits that I didn't want to forget...  Patches welcome.

1) ATAPI edge case.  Due to adding the padding s/g entry, we must adjust 
sg_tablesize to include ' - 1' for each driver

2) ata_scsi_slave_config() hardcodes a call to
blk_queue_max_phys_segments(, LIBATA_MAX_PRD), when the value passed
should not be so limited on nice hardware like AHCI.

3) sata_mv: add back SCR_ERR clear?
         mv_scr_write(ap, SCR_ERROR, mv_scr_read(ap, SCR_ERROR));

4) sata_mv: set DMA mask

