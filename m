From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 09/15] libata: implement ata_down_xfermask_limit()
Date: Sat, 01 Apr 2006 09:11:43 +0900
Message-ID: <442DC53F.7020907@gmail.com>
References: <11438230983159-git-send-email-htejun@gmail.com> <1143844292.15646.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:35317 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751294AbWDAALt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 19:11:49 -0500
Received: by zproxy.gmail.com with SMTP id o37so1087351nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 16:11:49 -0800 (PST)
In-Reply-To: <1143844292.15646.4.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Sad, 2006-04-01 at 01:38 +0900, Tejun Heo wrote:
>> Implement ata_down_xfermask_limit().  This function manipulates
>> @dev->pio/mwdma/udma_mask such that the next lower transfer mode is
>> selected.  This will be used by ata_bus_probe() rewrite and later by
>> EH speeding down.
> 
> This will need care. If it is called during a transfer mode change on
> error we should document that this function will only be called after
> the host_set has been quiesced, otherwise drivers that peek a lot at
> their ap-> mode settings at runtime (eg on an IRQ occuring during a
> speed change down) are going to burned badly.
> 
> It would be nice to see a description of the locking model for a
> changedown at this point.
> 

For new EH, every driver is responsible to freeze itself whenever it
enters an unknown state. While frozen, a low level driver is required to
either 1. plug interrupt completely from the port or 2. ignore interrupt
from the port without any side effect (ACK and clear interrupts
unconditionally). Once frozen, only reset can thaw the frozen state.

So, if anything which violates HSM occurs, LLDD freezes the port and EH
gets invoked. EH kicks in, resets the port and reconfigure transfer mode
if necessary. The EH revive routine looks pretty much like the new
ata_bus_probe() except that it uses ata_dev_revalidate in place of
ata_dev_read_id().

Thanks.

-- 
tejun
