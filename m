From: "Grant Grundler" <grundler@google.com>
Subject: Re: [PATCH 1/8] sata_mv more cosmetics
Date: Fri, 25 Apr 2008 09:40:05 -0700
Message-ID: <da824cf30804250940o4f0e0396k1696348f8d86cb77@mail.gmail.com>
References: <480A3D2E.4040503@rtr.ca> <480A3D5E.8090206@rtr.ca>
	 <481168E7.50402@pobox.com> <4811E0B7.2060508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:27562 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758478AbYDYQkR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Apr 2008 12:40:17 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id m3PGe7OS024552
	for <linux-ide@vger.kernel.org>; Fri, 25 Apr 2008 17:40:08 +0100
Received: from yw-out-1718.google.com (ywk9.prod.google.com [10.192.11.9])
	by zps75.corp.google.com with ESMTP id m3PGdt3U008467
	for <linux-ide@vger.kernel.org>; Fri, 25 Apr 2008 09:40:06 -0700
Received: by yw-out-1718.google.com with SMTP id 9so1558603ywk.12
        for <linux-ide@vger.kernel.org>; Fri, 25 Apr 2008 09:40:06 -0700 (PDT)
In-Reply-To: <4811E0B7.2060508@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, Apr 25, 2008 at 6:46 AM, Mark Lord <liml@rtr.ca> wrote:
...
>  But there are just *so many* irq cause / mask registers in these chips,
>  (one for PCI, one for the host function, and one per-port for EDMA,
>  plus the SATA SError + mask, ..), that even I was getting confused
>  while working on the code.

Yeah, it's confusing because most of the bits from one "interrupt"
(quotes explained in the next paragraph) register are rolled up into one bit
and available in another register. It seems like someone thought it
would be more efficient to read one register for all possible "causes"
and then have evidence a second register read is really necessary
(because a bit was set). Unfortunately, the result was the default
programming model as suggested by Marvell asks for at least two
MMIO reads just to find out if any IO completions are pending. 'Nuf said.
Kudos to Mark for figuring out how to reduce that to one MMIO read.

WRT "Interrupt", only the main cause (register can actually
generate interrupts. All the other "interrupt" registers
are effectively status registers. If a bit gets set in the main cause
register and it's not masked, an interrupt will get generated
(subject to any coalescing rules that have been enabled).
This is important to know for MSI support where we are dealing
with exclusive edge triggered interrupts instead of PCI shared
level triggered interrupts.

>  So, for now, they've been renamed back to something closer to
>  what is used in the (NDA only) documentation.
>
>  I did consider main_irq_{cause,mask} as an even better set of names there,
>  but in the end went for the shortened versions to avoid hitting the
>  pedantic 80-character line "limits" too often.

I think you can associate any names you want with whatever the
non-public documentation is calling the registers by adding a comment
in the header files where the bit masks and register offsets are defined.
Or vice versa. Which ever way works for you.

I prefer to use the non-public register names in the code only because it
will be easier for Marvell engineers to participate in _maintaining_
this driver. I think getting involved with open source developement
is a good career developement experience. And the device drivers for
"obsolete" HW allows them to take more risks/make mistakes
without getting into serious trouble with the company.

hth,
grant
