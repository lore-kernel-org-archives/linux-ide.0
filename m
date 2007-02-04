From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Sun, 04 Feb 2007 11:47:32 +0900
Message-ID: <45C54944.9040109@gmail.com>
References: <20070202151856.GD1625@htj.dyndns.org>	<20070202174235.14b13f3e@localhost.localdomain>	<45C3E7F0.6000506@gmail.com> <20070203200428.4a7a5682@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:2151 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbXBDCrj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 21:47:39 -0500
Received: by an-out-0708.google.com with SMTP id b33so850024ana
        for <linux-ide@vger.kernel.org>; Sat, 03 Feb 2007 18:47:38 -0800 (PST)
In-Reply-To: <20070203200428.4a7a5682@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: ahaas@airmail.net, linux-ide@vger.kernel.org

Alan wrote:
>>> Yep and if the BIOS programmed the slave into DMA that might not be ideal.
>> How so?  The bit will be programmed by set_dmamode() right after
>> set_piomode() is complete.
> 
> IFF we also put the device into a DMA mode. A blacklisted device would be
> wrong.

Hmmm... I might be misunderstanding, but if libata is going to put the
device into PIO mode, why does it matter what BIOS configured slave to?
 The slave is going to be put into PIO mode libata selected so the
control bits should match, no?

[--snip--]
>>>> * MWDMA mode programming cleared udma_mask even when the controller
>>>>   doesn't support UDMA.  This doesn't matter for your case.
>>> Or on the actual hardware.
>> I was trying to make it more consistent with pio counterpart.  We can
>> remove if() from set_piomode too.  Let's just keep things in sync
>> between stuff including ide piix driver.
> 
> The one you must not touch is the UDMA register rather than added UDMA
> bits in older registers.

OIC.  I was confused there.

Thanks.

-- 
tejun
