From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] ata_piix: improve combined mode handling
Date: Fri, 2 Feb 2007 16:09:30 +0900
Message-ID: <11704001701015-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:3191 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423168AbXBBHJh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 02:09:37 -0500
Received: by nz-out-0506.google.com with SMTP id s1so786356nze
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 23:09:37 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org, htejun@gmail.com

Subject: [PATCHSET] put some intelligence into speed down sequence

Hello,

The current EH speed down code is more of a feature demonstration and
goes through rdiculously many meaningless steps when condition is met.
This patchset tries to put some intelligence into speed down sequence.
The goal is to achieve reasonable number of speed down steps
reasonably spaced from one another and consider NCQ, cable type and
the current protocol when determining speed down steps, while not
bloating the code too much with nitty gritty details.

Roughly, the rules are...

1. If NCQ and protocol/timeout/unknown dev errors occur, turn off NCQ

2. If excessive transfer errors occur, speed down within the current
   transfer mode (UDMA/MWDMA/PIO).  If UDMA, it's first adjusted down
   a step, if error conditions persist, 40c limit is applied.  Speed
   down is done only twice.

3. If PATA && used up all DMA speed down steps && a LOT of
   transmission/unknown errors occur, switch to PIO.  So, we never
   automatically step down to PIO on SATA.  This is intended.  Some
   SATA hdd even seems to have problem with PIO data transfer
   commands.

The last patch makes ahci report HSM violation error on spurious
completion of NCQ commands, thus causing NCQ off after several such
incidents.  These drives should be blacklisted for DMA eventually.

This patchset is against...

  upstream (eb0e63cca36a3389f0ccab4584f6d479b983fad5)
+ [1] pata_platform-fix-devres-conversion
+ [2] libata-convert-to-iomap

Ric, I guess this resolves the to-do item from you which has been
sitting in my mailbox for way too long.  What do you think about the
rules?

Thanks.

--
tejun


