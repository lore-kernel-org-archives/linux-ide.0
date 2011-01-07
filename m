From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/1] PCI: tune up ICH4 quirk for broken BIOSes
Date: Fri, 7 Jan 2011 14:37:41 -0800
Message-ID: <20110107143741.7b2b2a8d@jbarnes-desktop>
References: <1294327066-23518-1-git-send-email-jslaby@suse.cz>
	<201101061224.40596.bjorn.helgaas@hp.com>
	<4D277B33.1000508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpoproxy2-pub.bluehost.com ([67.222.39.38]:41492 "HELO
	cpoproxy2-pub.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753875Ab1AGWho (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 17:37:44 -0500
In-Reply-To: <4D277B33.1000508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Jiri Slaby <jslaby@suse.cz>, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Thomas Renninger <trenn@suse.de>

On Fri, 07 Jan 2011 21:44:35 +0100
Jiri Slaby <jirislaby@gmail.com> wrote:

> On 01/06/2011 08:24 PM, Bjorn Helgaas wrote:
> > Theoretically, ACPI tells us about the GPIO/TCO/etc. regions in a
> > generic way via namespace devices or something in the static tables.
> > Is that generic information missing, or is it there and Linux is
> > ignoring it?  If we're ignoring it, I'd rather fix that.
> 
> It works for most boxes I would say. Try to google for "claimed by ICH4
> ACPI/GPIO/TCO", it reports sane ranges like 0400-047f or 4000-407f.
> 
> > The main reason for claiming I/O regions is to keep us from placing
> > another device on top of them.  But we've had PCIBIOS_MIN_IO = 0x1000
> > forever, which should keep us from putting anything below that anyway
> > (at least for PCI devices).  So there must be some other reason for
> > claiming space in this quirk.
> 
> Anyway, this ACPI space may be below 0x1000 as can be seen above. From
> the ICH standard, it can be anywhere...

Is there some other resource we should be considering to avoid this
space?

And we know it won't work if we try to use the IDE controller in the
LPC allocated space?  Have you checked the ICH4 specs to see what the
decode rules are on this space?  I guess LPC has priority and doesn't
forward requests through to IDE?

Either way, it would be good to understand this issue a little better
before we start restricting the LPC space like this.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
