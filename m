From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [RFC] ata/core: don't enable the interrupt while activating
 the host
Date: Tue, 6 Apr 2010 11:45:35 +0200
Message-ID: <20100406094535.GA30917@Chamillionaire.breakpoint.cc>
References: <20100311220417.GA16022@Chamillionaire.breakpoint.cc>
 <4BAAAEA1.9040906@kernel.org>
 <20100325220421.GA1051@Chamillionaire.breakpoint.cc>
 <4BABF7CE.6060908@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:36645 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751821Ab0DFJph (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 05:45:37 -0400
Content-Disposition: inline
In-Reply-To: <4BABF7CE.6060908@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

* Tejun Heo | 2010-03-26 08:54:54 [+0900]:

>Hello,
Hello,

sorry for the delay.

>On 03/26/2010 07:04 AM, Sebastian Andrzej Siewior wrote:
>>> Can you please play with ata_sff_freeze() and find out why it's not
>>> working?
>> I've been there. I've moved the functions around and nothing changed.
>> After removing the ATA_NIEN bit it started working. So it looks like
>> ->sff_check_status() & ->sff_irq_clear() are not clearing the interrupt
>> for what reason ever.
>
>What happens if you remove everything else from the function and just
>set ATA_NIEN?

removing everything from ata_sff_freeze() makes the interrupt storm go
away.
Leaving
- ap->ctl |= ATA_NIEN;
  => seems to work
- the upper and "ap->last_ctl = ap->ctl;"
  => seems to work
- the upper and "iowrite8(ap->ctl, ioaddr->ctl_addr);"
  => irq storm on request irq.

ata_sff_check_status() does not report ATA_DRQ set so I don't know why
the interrupt is comming.

>Thanks.
>
Sebastian
