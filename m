From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Sat, 3 Jul 2010 10:23:04 +0200
Message-ID: <20100703082304.GA25293@liondog.tnic>
References: <20100618074510.GD32368@liondog.tnic>
 <20100619005045.2173fcce@cpc>
 <20100619100511.GA31429@liondog.tnic>
 <20100619132708.030fe408@cpc>
 <20100623080200.GB5010@liondog.tnic>
 <20100625185846.72171be0@cpc>
 <20100630065426.GA1857@liondog.tnic>
 <20100630200254.45ab84d1@cpc>
 <20100630183138.GA11036@liondog.tnic>
 <20100703094918.03007437@cbook.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:47089 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282Ab0GCIXL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jul 2010 04:23:11 -0400
Content-Disposition: inline
In-Reply-To: <20100703094918.03007437@cbook.fritz.box>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans Mueller <hans42mueller@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

From: Hans Mueller <hans42mueller@googlemail.com>
Date: Sat, Jul 03, 2010 at 09:49:18AM +0200

> Hi, 
> 
> On Wed, 30 Jun 2010 20:31:38 +0200
> Borislav Petkov <bp@alien8.de> wrote:
> > Alternatively, if you have a spare PCI NIC, you can insert it into one
> > of the PCI slots after having disabled the onboard NIC in the BIOS. Just
> > for testing purposes, to see whether "unsharing" the IRQ line fixes the
> > issue.
> 
> I have currently no access to the computer, I will be able to test
> things again on monday.
> But as I wrote in my original bugreport, I tested with a PCI NIC. (But
> the onboard NIC was not completely disabled, it was only disabled via
> ifconfig ... down)
> When using the PCI NIC, the whole problem (kernel panik) did not occure.

Ok, this confirms my suspicion that it is shared-irq related. Also, we
already verified that switching to libata does fix the issue for you so
you are good to go. Considering the DEPRECATED status of ide, I have a
very little incentive in hunting this thing further down, so let's leave
it at that.

I'll send the first fix to Dave since it is still needed and add a note
to bugzilla for further reference.

Jonas, big thanks for your hard work with testing patches and ideas. I
really appreciate it! :)

-- 
Regards/Gruss,
    Boris.
