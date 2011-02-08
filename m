From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/1] PCI: tune up ICH4 quirk for broken BIOSes
Date: Tue, 8 Feb 2011 13:20:55 -0800
Message-ID: <20110208132055.1c55ff93@jbarnes-desktop>
References: <1294327066-23518-1-git-send-email-jslaby@suse.cz>
	<AANLkTinN40GMRL3bJ7LKDmhCYK1AYZfQ+mVYwxDP1ZQe@mail.gmail.com>
	<4D3025F4.6020001@gmail.com>
	<201101140910.07154.bjorn.helgaas@hp.com>
	<4D5112F5.8030700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpoproxy1-pub.bluehost.com ([69.89.21.11]:50962 "HELO
	cpoproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752708Ab1BHVU6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 16:20:58 -0500
In-Reply-To: <4D5112F5.8030700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Thomas Renninger <trenn@suse.de>

On Tue, 08 Feb 2011 10:55:01 +0100
Jiri Slaby <jirislaby@gmail.com> wrote:

> On 01/14/2011 05:10 PM, Bjorn Helgaas wrote:
> > On Friday, January 14, 2011 03:31:16 am Jiri Slaby wrote:
> >> On 01/14/2011 01:15 AM, Linus Torvalds wrote:
> >>> On Thu, Jan 13, 2011 at 3:19 PM, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> >>>>
> >>>> I think we're back to the question of why we have the ICH4 quirk in
> >>>> the first place, and I don't know the answer to that.
> >>>
> >>> Iirc, there were several laptops that didn't have the ACPI region
> >>> mentioned in any of the regular places, and we'd allocate the PCMCIA
> >>> IO region on top of them. The machine would boot, but if anybody ever
> >>> inserted a PCCard into the machine, the first access to the IO region
> >>> would generally just halt it (because it was trying to read the
> >>> PCCard, but the APCI region decodes first, and then the read from that
> >>> usually put the CPU in a sleep state that it would never wake up from
> >>> for obvious reasons).
> >>>
> >>> So we do want the ICH4 quirk.
> >>
> >> Yes, this is an "official" way how ICH4 (and later) advertises the region.
> > 
> > The quirk is a bug workaround, *not* the "official, planned" way to
> > deal with these regions.  The official way is to use ACPI, because
> > that's a generic way that doesn't require changes for new versions
> > of ICH.
> 
> Ok, I understand that. For non-ACPI setups this is probably the only
> place to look at.
> 
> Anyway, has anybody had a chance to look at the patches? Any comments,
> nacks/acks?
> 
> https://lkml.org/lkml/2011/1/14/115
> https://lkml.org/lkml/2011/1/14/113
> https://lkml.org/lkml/2011/1/14/114

I don't have a problem making the quirk quirkier, but it would be nice
to get rid of the need for it entirely (though we can leave that to
Bjorn :). Can you re-submit these three against my linux-next branch?

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
