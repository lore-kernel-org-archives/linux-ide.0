From: Dominic Ijichi <dom@ijichi.org>
Subject: Re: [PATCH 6/6 update] SATA ACPI: ata_acpi functions
Date: Wed, 07 Dec 2005 17:24:30 +0000
Message-ID: <1133976270.43971ace1c015@www.ijichi.org>
References: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com> <20051202100850.11b831ea.randy_d_dunlap@linux.intel.com> <20051206135815.5026647c.randy_d_dunlap@linux.intel.com> <1133973407.43970f9fdf6dd@www.ijichi.org> <20051207091639.00a7a232.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from buffy.ijichi.org ([213.161.76.94]:39321 "EHLO buffy.ijichi.org")
	by vger.kernel.org with ESMTP id S1750977AbVLGRYi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2005 12:24:38 -0500
In-Reply-To: <20051207091639.00a7a232.randy_d_dunlap@linux.intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-ide@vger.kernel.org, axboe@suse.de, jgarzik@pobox.com

Quoting Randy Dunlap <randy_d_dunlap@linux.intel.com>:

> On Wed, 07 Dec 2005 16:36:47 +0000
> Dominic Ijichi <dom@ijichi.org> wrote:
> 
> > I get a segfault when applying these patches to 2.6.15-rc4.  ahci compiled
> as
> > module and inserted through initrd so the module fails with segfault and
> kernel
> > doesnt go any further through boot, hence no logging.  last thing screen
> shows is:
> >
> > Code: e3 36 34 c0 c7 44 24 18 29 02 00 00 59 5b 5e 5f 5d e9 f3 05 00 00 53
> 8b 5c
> > 2408 e8 e9 03 00 00 a1 dc 0c 42 c0 eb 04 39 d8 74 07 <8b> 40 04 85 c0 75 f5
> 5b
> > c3 55 57 56 53 50 8b 44 24 20 8b 5c 24
> 
> Can you provide any more of the segfault messages?  That one
> isn't particularly helpful.

ok, see below. this is typed in on another computer, i'll try to minimise typos!
 
> Is this on your Fujitsu notebook, with the same hardware
> configuration as last week?

yup

--

[<c02516c9>] ata_device_add+0x1e9/0x2b0
[<e082d850>] ahci_interrupt+0x0/0x1e0 [achi]
[<e082e263>] ahci_init_one+0x1a3/0x270 [achi]
[<c01cb5d6>] __pci_device_probe+0x56/0x70
[<c01cb61f>] pci_device_probe+0x2f/0x50
[<c023b313>] driver_probe_device+0x43/0xd0
[<c023b420>] __driver_attach+0x0/0x50
[<c023b461>] __driver_attach+0x41/0x50
[<c023a84d>] bus_for_each_dev+0x5d/0x80
[<c023b495>] driver_attach+0x25/0x30
[<c023b420>] __driver_attach+0x0/0x50
[<c023ada9>] bus_add_driver+0x89/0xf0
[<c01cb8a4>] __pci_register_driver+0x74/0xa0
[<e0832018>] ahci_init+0x18/0x1c [achi]
[c01364c2>] sys_init_module+0xd/0x210
[<c0103291>] syscall_call+0x7/0xb

then the Code: line

thats all that's left on the screen unfortunately, the rest scrolls off the top.

cheers
dom







> > also, is there a working archive for this list?  the MARC archive died on
> 25th
> > november.
> 
> I contacted them.  It appears that their subscription to linux-ide
> was dropped, so they resubscribed.  However, they are missing
> linux-ide archives from Nov. 25 - Dec. 7, so if anyone has those,
> they would like to get them and stuff those into the archives.
> If you have linux-ide archives from that period, please let me
> know or (even better) send them to hlein at progressive-comp.com .
> 
> Thanks,
> ---
> ~Randy


------------------------------------------
This message was penned by the hand of Dom
