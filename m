From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sun, 29 Apr 2007 16:45:20 +0900
Message-ID: <46344D10.507@gmail.com>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <463414FA.5080802@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:54406 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038AbXD2Hpb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Apr 2007 03:45:31 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1321826wra
        for <linux-ide@vger.kernel.org>; Sun, 29 Apr 2007 00:45:31 -0700 (PDT)
In-Reply-To: <463414FA.5080802@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> and thus clear DRQ, right?  Stuck DRQ after SRST seems odd to me.
> 
> Unfortunately not odd on ata_piix, which can get stuck DRQ-on somewhere
> deep inside its IDE emulation engine.  And neither draining the FIFO nor
> SRST nor a couple other tricks ever helped.  The only thing that seemed
> to make any difference was an enable/disable reset via our beloved PCS
> register.

OIC, it's the SFF emulation which doesn't reset itself on SRST.  So,
flipping PCS helps.  Maybe we should do that in prereset?

-- 
tejun
