From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] ata/core: don't enable the interrupt while activating the
 host
Date: Thu, 25 Mar 2010 09:30:25 +0900
Message-ID: <4BAAAEA1.9040906@kernel.org>
References: <20100311220417.GA16022@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46679 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096Ab0CYHOp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Mar 2010 03:14:45 -0400
In-Reply-To: <20100311220417.GA16022@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linux-ide@vger.kernel.org

Hello,

On 03/12/2010 07:04 AM, Sebastian Andrzej Siewior wrote:
> I just migrated from ide_platform to pata_platform on my Swarm/Mips
> board. This resulted in "nobody cared" during request_irq().
> The only difference I noticed between ATA and IDE before registering the
> interrupt handler is that IDE does not enable the interrupt.
> After removing the flag it looks like the controller is working with the
> ATA layer.
> 
> If I flip the polarity of the interrupt, I see the "nobody cared"
> message shortly after seeing ata_sff_softreset() during boot. So I tried
> to perform the software reset with ATA_SRST before requesting the
> interrupt hoping that it makes interrupt go away. It did not so.
> 
> Does anyone have an idea what might go wrong here?

ata_host_start() calls ata_eh_freeze_port() on each port which is
supposed to block the IRQs.  For pata_platform, the callback is
libata-sff.c::ata_sff_freeze() which does all that's necessary.  Can
you please play with ata_sff_freeze() and find out why it's not
working?

Thanks.

-- 
tejun
