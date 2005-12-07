From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Wed, 07 Dec 2005 22:35:16 +0000
Message-ID: <1133994916.544.102.camel@localhost.localdomain>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
	 <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
	 <1133970074.544.69.camel@localhost.localdomain>
	 <58cb370e0512070749y68b2f9e9t1c68a3e03f91baa0@mail.gmail.com>
	 <1133918523.2936.12.camel@sli10-mobl.sh.intel.com>
	 <58cb370e0512071115i3dbb741aqda7f98a97221d99b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030412AbVLGWgz@vger.kernel.org>
In-Reply-To: <58cb370e0512071115i3dbb741aqda7f98a97221d99b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

On Mer, 2005-12-07 at 20:15 +0100, Bartlomiej Zolnierkiewicz wrote:
> PS1 Please don't use taskfile_lib_get_identify(), drive->id
> should contain valid ID - if it doesn't it is a BUG.

If someone swapped the drive while suspended that isnt true. OTOH I'm
not sure what the hell you'd do if that was the case and you are using
drivers/ide right now.

> PS2 Have you seen libata ACPI patches by Randy?
> Maybe some of the code dealing with ACPI can be put to
> <linux/ata.h> and be shared between IDE and libata drivers?

Definitely a good idea. Also exposing the methods will be useful for
producing a proper libata 'ata_acpi' driver that does the best it can
using ACPI methods for tuning unknown hardware.
