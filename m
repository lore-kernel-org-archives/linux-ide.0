From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Wed, 7 Dec 2005 16:49:41 +0100
Message-ID: <58cb370e0512070749y68b2f9e9t1c68a3e03f91baa0@mail.gmail.com>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
	 <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
	 <1133970074.544.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.193]:49655 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750789AbVLGPtp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Dec 2005 10:49:45 -0500
Received: by nproxy.gmail.com with SMTP id x29so123152nfb
        for <linux-ide@vger.kernel.org>; Wed, 07 Dec 2005 07:49:43 -0800 (PST)
In-Reply-To: <1133970074.544.69.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>

On 12/7/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2005-12-07 at 15:45 +0100, Bartlomiej Zolnierkiewicz wrote:
> > OK, I understand it now - when using 'ide-generic' host driver for IDE
> > PCI device, resume fails (for obvious reason - IDE PCI device is not
> > re-configured) and this patch fixes it through using ACPI methods.

I was talking about bugzilla bug #5604.

> Even in the piix case some devices need it because the bios wants to
> issue commands such as password control if the laptop is set up in
> secure modes.

I completely agree.  However at the moment this patch doesn't seem
to issue any ATA commands (code is commented out in _GTF) so
this is not a case for bugzilla bug #5604.

Bartlomiej
