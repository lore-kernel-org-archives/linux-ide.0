From: Tejun Heo <htejun@gmail.com>
Subject: Re: [CALL-FOR-HELP] pata_ali: can't get MWDMA working!
Date: Thu, 10 Jan 2008 02:01:48 +0900
Message-ID: <4784FDFC.7050908@gmail.com>
References: <4784FBC1.7070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.182]:33682 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbYAIRB5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 12:01:57 -0500
Received: by ro-out-1112.google.com with SMTP id p4so356423roc.5
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 09:01:55 -0800 (PST)
In-Reply-To: <4784FBC1.7070804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, andre@linux-ide.org, Bartlomiej

Oh... I forgot to mention something.

I traced DMA command execution and the following is what happens.

1. host setups DMA engine (programs BMDMA controller)
2. host issues PACKET
3. device sets BSY
4. host transfers CDB when BSY clears and DRQ sets (Status turns to 0xd0)
5. host activates BMDMA engine
6. device reports 0xd0 for all TF regs for short moment and then it
   clears BSY and sets DRQ and other regs.
7. nothing happens for quite long time (>10s)
8. after a while, device seems to give up and clears DRQ and sets
   DRDY.
9. BMDMA status is 0x21 and doesn't change.
10. after a while, timeout occurrs.

I cleared the buffer before issuing commnad and checked whether DMA
engine delievered anything from EH.  It transfered nothing.  It looks
like for some reason the BMDMA engine is losing its chance to start.

Thanks.

-- 
tejun
