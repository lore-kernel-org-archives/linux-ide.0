From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [RFC] ata/core: don't enable the interrupt while activating
 the host
Date: Thu, 25 Mar 2010 23:04:22 +0100
Message-ID: <20100325220421.GA1051@Chamillionaire.breakpoint.cc>
References: <20100311220417.GA16022@Chamillionaire.breakpoint.cc>
 <4BAAAEA1.9040906@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:43670 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751626Ab0CYWEX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2010 18:04:23 -0400
Content-Disposition: inline
In-Reply-To: <4BAAAEA1.9040906@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

* Tejun Heo | 2010-03-25 09:30:25 [+0900]:

>ata_host_start() calls ata_eh_freeze_port() on each port which is
>supposed to block the IRQs.  For pata_platform, the callback is
>libata-sff.c::ata_sff_freeze() which does all that's necessary.  Can
>you please play with ata_sff_freeze() and find out why it's not
>working?
I've been there. I've moved the functions around and nothing changed.
After removing the ATA_NIEN bit it started working. So it looks like
->sff_check_status() & ->sff_irq_clear() are not clearing the interrupt
for what reason ever.
Right now I belive that the firmware is doing something with the chip.
Is it possible to reset the chip to its power-on state?
ata_bus_softreset() did not help. Maybe I find something when I dig
through the firmware code....

>Thanks.

Sebastian
