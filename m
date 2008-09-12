From: "xerces8" <xerces8@butn.net>
Subject: Re: Intel AHCI ICH9R not detecting devices
Date: Fri, 12 Sep 2008 09:53:48 +0200
Message-ID: <WorldClient-F200809120953.AA53480062@butn.net>
References: <WorldClient-F200808221729.AA29360172@butn.net> <48B92399.6010808@kernel.org> <WorldClient-F200808302142.AA42270030@butn.net> <48BBB248.7090904@kernel.org> <WorldClient-F200809062012.AA12270277@butn.net> <WorldClient-F200809062331.AA31030286@butn.net> <48C50E1F.9040407@kernel.org> <WorldClient-F200809081343.AA43510194@butn.net> <48C51258.5080307@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ikar.perftech.si ([195.246.0.20]:23224 "EHLO ikar.perftech.si"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbYILHxx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Sep 2008 03:53:53 -0400
Received: from dedal.perftech.si (unknown [10.12.0.44])
	by ikar.perftech.si (Spam Firewall) with ESMTP id 61D591F743A
	for <linux-ide@vger.kernel.org>; Fri, 12 Sep 2008 09:53:52 +0200 (CEST)
Received: from dedal.perftech.si ([10.12.0.44]) by ikar.perftech.si with ESMTP id lmGDKleQZ4ByMNT5 for <linux-ide@vger.kernel.org>; Fri, 12 Sep 2008 09:53:52 +0200 (CEST)
Received: from WorldClient by butn.net (MDaemon PRO v9.6.4)
	with ESMTP id 59-md50000233330.msg
	for <linux-ide@vger.kernel.org>; Fri, 12 Sep 2008 09:53:51 +0200
In-Reply-To: <48C51258.5080307@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, stein@hermes.si

Tejun Heo wrote:

> xerces8 wrote:
> > Tejun Heo wrote:
> > 
> >> xerces8 wrote:
> >>> I put more debug in the function that failed and tracked the problem down to setup_irq().
> >>> I also enabled CONFIG_DEBUG_SHIRQ. The kernel messages are attached.
> >> Aieee... please disable ide-generic.
> > 
> > (you mean CONFIG_IDE_GENERIC, right ?)
> > 
> > Can you elaborate ?
> > Is this some bug ?
> > 
> > I can't just a tell distro owner to change a kernel build option
> > because someone told me to :-) (remember, this is a problem with the
> > kernel of RIPLinux, a small recovery live CD)
> 
> Enabling generic by default is a bad bad bad bad bad bad bad idea.  It
> just grabs legacy IO ports and interrupts and doesn't wanna share
> them.  Under some configurations, it used to cause two drivers to be
> attached to the same device triggering weird problems, which shouldn't
> happen anymore, but it still can prevent proper drivers from acquiring
> the resources.  In your case, USB host controller was also assigned to
> the same IRQ and failed to initialize IRQ.  It just can't play nice
> with modern devices and drivers.

Maybe a summary of this should be added as a help for the CONFIG_IDE_GENERIC option ?

Regards,
David


