From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: About forcing 32bit DMA patch for AMD690G(SB600)
Date: Thu, 24 Jan 2008 23:19:31 -0500
Message-ID: <76366b180801242019h382fd604vd1458dab8b64dd4c@mail.gmail.com>
References: <B90463BC30D2E446BA423D888DC85E501BF3CB@sshaexmb1.amd.com>
	 <47992BA3.3070104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:13706 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbYAYETc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 23:19:32 -0500
Received: by rv-out-0910.google.com with SMTP id k20so523100rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 20:19:31 -0800 (PST)
In-Reply-To: <47992BA3.3070104@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Shane Huang <Shane.Huang@amd.com>, sriharivijayaraghavan@yahoo.com.au, linux-ide@vger.kernel.org

Tejun,

I have an SB600/RS690 here with SATA drives connected. I haven't been
following this thread, but I can help test something if it would help.

Thanks,
-Andrew

On Jan 24, 2008 7:21 PM, Tejun Heo <htejun@gmail.com> wrote:
> Hello, Shane.  Sorry about the delay.  Got caught up in other stuff.
>
> Shane Huang wrote:
> > Quoting Tejun:
> >> Uh-oh, wait a bit. Nope. Until we figure out what the something
> >> else
> > is
> >> and positively verify 64bit DMA works fine, the quirk stays in.
> >
> > Our HW engineer has confirmed that our SB600 SATA controller indeed
> > has some MSI issue, and we do not have any workaround.
> >
> > The workaround "quirk_msi_intx_disable_bug" to SB700 SATA controller
> > can NOT work to SB600 SATA controller in my debug, while disablement
> > to RS690 MSI in kernel source can fix it.
>
> Hmmm... Okay.  Is the SB600 SATA controller culprit or the north bridge
> - RS690?  If the former is the case, proper way to work around it is to
> add AHCI_HFLAG_NO_MSI for SB600 AHCI.
>
> > As to the SB600 64 bit DMA capacity, do you have any methods to do
> > further verification? I do NOT find any problem in my debug after I
> > disabled RS690 MSI in kernel 2.6.24-rc7.
>
> The problem is that we didn't actually prove anything.  In the tests
> you've done, pci=nomsi didn't fix the problem but disable_all_msi quirk
> did.  pci=nomsi and disable_all_msi quirk are identical.  Also,
> Srihari's problem was not reproduced, so currently we can't say much
> from the test results.  Srihari, do you still have the system around?
>
> Thanks.
>
> --
> tejun
