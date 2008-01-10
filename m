From: Tejun Heo <htejun@gmail.com>
Subject: Re: [CALL-FOR-HELP] pata_ali: can't get MWDMA working!
Date: Thu, 10 Jan 2008 10:49:33 +0900
Message-ID: <478579AD.2020301@gmail.com>
References: <4784FBC1.7070804@gmail.com> <4785038D.1030503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:59639 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbYAJBtm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 20:49:42 -0500
Received: by rv-out-0910.google.com with SMTP id k20so407850rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 17:49:39 -0800 (PST)
In-Reply-To: <4785038D.1030503@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, andre@linux-ide.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Mark Lord wrote:
> Are you really sure that the old IDE is actually issuing DMA commands,
> rather than falling back to PIO ?

Yeap, pretty sure.  Here is debug dump of IDE transferring sector zero.

[  114.377898] XXX writing 0x8 to dma_cmd
[  114.381718] XXX read dma_stat 0x24 and writing 0x26
[  114.386638] XXX writing feat=0x1 ireason=0 sector=0 cntl=0x0
cnth=0x80 ctrl=0x8
[  114.393991] XXX executing WIN_PACKETCMD
[  114.397878] XXX CDB 28 00 00 00 00 00 00 00 01 00 00 00
[  114.403899] XXX writing 0x8 | 1 to dma_command

-- 
tejun
