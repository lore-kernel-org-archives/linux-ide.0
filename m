From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Wed, 7 Dec 2005 16:44:39 +0100
Message-ID: <58cb370e0512070744w6a820f72h853783c851b580c4@mail.gmail.com>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
	 <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
	 <20051207145811.GA17119@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.198]:34737 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751154AbVLGPom convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Dec 2005 10:44:42 -0500
Received: by nproxy.gmail.com with SMTP id x29so122747nfb
        for <linux-ide@vger.kernel.org>; Wed, 07 Dec 2005 07:44:41 -0800 (PST)
In-Reply-To: <20051207145811.GA17119@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>

On 12/7/05, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, Dec 07, 2005 at 03:45:19PM +0100, Bartlomiej Zolnierkiewicz wrote:
>
> > OK, I understand it now - when using 'ide-generic' host driver for IDE
> > PCI device, resume fails (for obvious reason - IDE PCI device is not
> > re-configured) and this patch fixes it through using ACPI methods.
>
> Unfortunately not - you get the same failure with piix (am I right in
> thinking that piix doesn't have any suspend/resume methods beyond the
> generic PCI ones? I'm afraid I don't have enough knowledge of the IDE
> layer to know if there's some other magic that calls an ide-specific
> resume function in it...)

PCI device will get re-configured indirectly by ide_complete_power_step()
which is calling hwif->ide_dma_check() (piix_config_drive_xfer_rate).

Bartlomiej
