From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 with port multiplier
Date: Fri, 28 Sep 2007 14:48:09 -0700
Message-ID: <46FD7699.9010404@gmail.com>
References: <FD6311B7ED175B4480F31633F6098B4D911D1F@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:4153 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293AbXI1Vtt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 17:49:49 -0400
Received: by py-out-1112.google.com with SMTP id u77so5505835pyb
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 14:49:48 -0700 (PDT)
In-Reply-To: <FD6311B7ED175B4480F31633F6098B4D911D1F@ffpglobal_mail.corp.ffplus.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon Chelton <jchelton@ffpglobal.com>
Cc: linux-ide@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Jon Chelton wrote:
> Tejun,
> 
> Below is the kernel log from boot to when error occurred.  You can see
> right when the raid5 array was built and started the recovery process
> the exception occurred.  Also, its now been 24 hours since I disabled
> smartd and have not seen any other exceptions since. (also included is
> output from smartd -V)
[--snip--]
> ata1.03: exception Emask 0x0 SAct 0x2220897f SErr 0x400000 action 0x2
> ata1.03: irq_stat 0x00020002, device error via SDB FIS
> ata1.03: cmd 61/88:a8:3f:00:00/00:00:00:00:00/40 tag 21 cdb 0x0 data
> 69632 out
>          res 41/84:38:8f:00:00/60:00:00:00:00/40 Emask 0x410 (ATA bus
> error) <F>
> ata1.03: soft resetting link
> ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.03: configured for UDMA/100
> ata1: EH complete
> ata1.03: exception Emask 0x0 SAct 0x1ffc SErr 0x400000 action 0x2
> ata1.03: irq_stat 0x00020002, device error via SDB FIS
> ata1.03: cmd 61/88:10:3f:00:00/00:00:00:00:00/40 tag 2 cdb 0x0 data
> 69632 out
>          res 41/84:78:4f:00:00/00:00:00:00:00/40 Emask 0x410 (ATA bus
> error) <F>
> ata1.03: soft resetting link
> ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.03: configured for UDMA/100
> ata1: EH complete
> ata1.03: exception Emask 0x0 SAct 0x7ff SErr 0x400000 action 0x2
> ata1.03: irq_stat 0x00020002, device error via SDB FIS
> ata1.03: cmd 61/70:00:57:03:00/01:00:00:00:00/40 tag 0 cdb 0x0 data
> 188416 out
>          res 41/84:a0:27:04:00/60:00:00:00:00/40 Emask 0x410 (ATA bus
> error) <F>
> ata1.03: soft resetting link
> ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.03: configured for UDMA/100
> ata1: EH complete
> ata1.03: limiting SATA link speed to 1.5 Gbps
> ata1.03: exception Emask 0x0 SAct 0x7ff SErr 0x400000 action 0x6
> ata1.03: irq_stat 0x00020002, device error via SDB FIS
> ata1.03: cmd 61/88:00:3f:00:00/00:00:00:00:00/40 tag 0 cdb 0x0 data
> 69632 out
>          res 41/84:38:8f:00:00/00:00:00:00:00/40 Emask 0x410 (ATA bus
> error) <F>
> ata1.03: hard resetting link
> ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.03: configured for UDMA/100
> ata1: EH complete

All errors are interface CRC errors reported by device on FPDMA_WRITE.
It doesn't seem to have anything to do with SMART.  In all cases, SError
DIAG is reporting handshake error too (R_ERR received).  I'm fairly sure
these were actual hardware problems.  You don't have to pay too much
attention unless it happens repeatedly.  Good cure for the problem is
probably to re-seat the harddrive.

Bruce, I don't think this is SMART related.  Sorry about the noise.  Thanks.

-- 
tejun
