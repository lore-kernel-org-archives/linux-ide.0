From: Sylvain LEVEQUE <kag@laposte.net>
Subject: Performance issue with SATA port multiplier
Date: Thu, 24 Feb 2011 15:32:50 +0100
Message-ID: <AANLkTimWhSbb8i1qPUCiZhGjQpdx1kWG_wyE3-hVScY+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39906 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab1BXOdL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2011 09:33:11 -0500
Received: by wyg36 with SMTP id 36so570338wyg.19
        for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2011 06:33:10 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello

I own a Venus T5C mini box based on a JMicron JM393 controller, used
in pure port multiplier mode (no JBOD, no RAID). It is plugged in
eSATA to a QNAP TS-119 NAS which runs a 2.6.37 kernel on a Marvell
Kirkwood 88F6281.

When I first started copying data on any disk of the external box, I
realized the write speed was low (read speed is OK). Testing with dd
and various block sizes shows that the larger the block size, the
higher the throughput is. On my NAS, I determined the work buffer size
of the cp command to be approximately 8KB.

With a 8KB blocksize, when writing a 16MB file with dd on one of the
disks, I average at 6,5 MB/s write speed. It is already a great
improvement compared to the 393 KB/s write speed I obtained on a
2.6.36 kernel, but it is low compared to results I obtain with higher
blocksizes (52,4 MB/s with 4MB blocksize) or using other hardware
(laptop with Intel ICH9M-E/M controller reaches 286 MB/s with 8KB
blocksize using a 2.6.31 kernel).

When I take one of the disks out and connect it in eSATA with a basic
external case, I reach 37,6 MB/s with 8KB blocksize. This result is
pretty constant whatever the blocksize value I tested (from 1KB to
16MB, doubling each time).

Please let me know what information is needed to have a better
understanding of this issue.

Thanks in advance for your help.
-- 
Sylvain
