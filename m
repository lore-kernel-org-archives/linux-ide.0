From: Tejun Heo <tj@kernel.org>
Subject: Re: Intel AHCI ICH9R not detecting devices
Date: Mon, 08 Sep 2008 13:54:00 +0200
Message-ID: <48C51258.5080307@kernel.org>
References: <WorldClient-F200808221729.AA29360172@butn.net> <48B92399.6010808@kernel.org> <WorldClient-F200808302142.AA42270030@butn.net> <48BBB248.7090904@kernel.org> <WorldClient-F200809062012.AA12270277@butn.net> <WorldClient-F200809062331.AA31030286@butn.net> <48C50E1F.9040407@kernel.org> <WorldClient-F200809081343.AA43510194@butn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37970 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724AbYIHLzt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 07:55:49 -0400
In-Reply-To: <WorldClient-F200809081343.AA43510194@butn.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: xerces8 <xerces8@butn.net>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, stein@hermes.si

xerces8 wrote:
> Tejun Heo wrote:
> 
>> xerces8 wrote:
>>> I put more debug in the function that failed and tracked the problem down to setup_irq().
>>> I also enabled CONFIG_DEBUG_SHIRQ. The kernel messages are attached.
>> Aieee... please disable ide-generic.
> 
> (you mean CONFIG_IDE_GENERIC, right ?)
> 
> Can you elaborate ?
> Is this some bug ?
> 
> I can't just a tell distro owner to change a kernel build option
> because someone told me to :-) (remember, this is a problem with the
> kernel of RIPLinux, a small recovery live CD)

Enabling generic by default is a bad bad bad bad bad bad bad idea.  It
just grabs legacy IO ports and interrupts and doesn't wanna share
them.  Under some configurations, it used to cause two drivers to be
attached to the same device triggering weird problems, which shouldn't
happen anymore, but it still can prevent proper drivers from acquiring
the resources.  In your case, USB host controller was also assigned to
the same IRQ and failed to initialize IRQ.  It just can't play nice
with modern devices and drivers.

-- 
tejun
