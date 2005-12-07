From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Wed, 7 Dec 2005 23:42:13 +0100
Message-ID: <58cb370e0512071442j7ed609cev1a4a27dc30e43af8@mail.gmail.com>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
	 <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
	 <1133970074.544.69.camel@localhost.localdomain>
	 <58cb370e0512070749y68b2f9e9t1c68a3e03f91baa0@mail.gmail.com>
	 <1133918523.2936.12.camel@sli10-mobl.sh.intel.com>
	 <58cb370e0512071115i3dbb741aqda7f98a97221d99b@mail.gmail.com>
	 <1133994916.544.102.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.201]:38430 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751811AbVLGWmP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Dec 2005 17:42:15 -0500
Received: by nproxy.gmail.com with SMTP id x29so154388nfb
        for <linux-ide@vger.kernel.org>; Wed, 07 Dec 2005 14:42:13 -0800 (PST)
In-Reply-To: <1133994916.544.102.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Shaohua Li <shaohua.li@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>

On 12/7/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2005-12-07 at 20:15 +0100, Bartlomiej Zolnierkiewicz wrote:
> > PS1 Please don't use taskfile_lib_get_identify(), drive->id
> > should contain valid ID - if it doesn't it is a BUG.
>
> If someone swapped the drive while suspended that isnt true. OTOH I'm
> not sure what the hell you'd do if that was the case and you are using
> drivers/ide right now.

This is unsupported anyway so doesn't matter for IDE ACPI support...
