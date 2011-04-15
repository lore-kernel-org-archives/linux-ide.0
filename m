From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Fri, 15 Apr 2011 11:36:38 -0400
Message-ID: <4DA86606.308@teksavvy.com>
References: <C1438B59050E1B4C9482FF3266AD6BA32C7493557A@gretna.indigovision.com> <C1438B59050E1B4C9482FF3266AD6BA32C7493559F@gretna.indigovision.com> <4D9CD275.9000002@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C749358D0@gretna.indigovision.com> <4D9FACC9.7020200@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C772D9EB1@gretna.indigovision.com> <4DA5BCF3.5080205@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C772DA491@gretna.indigovision.com> <4DA79134.1010508@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C772DA5DD@gretna.indigovision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:54374 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754497Ab1DOPgk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Apr 2011 11:36:40 -0400
In-Reply-To: <C1438B59050E1B4C9482FF3266AD6BA32C772DA5DD@gretna.indigovision.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Stenning <b.stenning@indigovision.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Justin Maggard <jmaggard10@gmail.com>, Tejun Heo <htejun@gmail.com>

On 11-04-15 09:21 AM, Bruce Stenning wrote:
..
> sata_mv 0000:00:04.0: Gen-II 32 slots 4 ports SCSI mode IRQ via INTx
..
> 
> I had noticed occasional messages similar to the following earlier in the week:
> 
> ata4.00: limiting speed to UDMA/100:PIO4

Ugh.   Tejun:  that's just plain silly.
Why would we EVER EVER EVER fall back to "PIO" for SATA ???


> I am building with CONFIG_ARCH_SUPPORTS_MSI=y, but also with CONFIG_PCI_MSI
> not set.
> 
> With all this discussion of SATA link speed, I ought to say that we limit our
> SATA links to 1.5Gbps with the following kernel parameter:
> 
> libata.force=1.5g

Mmm... I suppose it could be getting stuck at 1.5g,
and not transitioning back to "auto detect" or something.

That part of sata_mv involves a bit of voo-doo,
because I was reluctant to cut/paste the 200 lines or so
of generic code just for the sake of changing five lines.

Perhaps the generic code has changed since this was originally working,
and now no longer always works for sata_mv..

I suppose you have a good reason for using "libata.force=1.5g" there?

Cheers
