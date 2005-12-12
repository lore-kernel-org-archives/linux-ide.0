From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 6/6 update] SATA ACPI: ata_acpi functions
Date: Sun, 11 Dec 2005 18:13:02 -0800
Message-ID: <20051211181302.4ec1dedb.rdunlap@xenotime.net>
References: <20326763.31241134350644508.JavaMail.root@willow.ijichi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:57045 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751028AbVLLCMb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Dec 2005 21:12:31 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Sun, 11 Dec 2005 18:12:29 -0800
In-Reply-To: <20326763.31241134350644508.JavaMail.root@willow.ijichi.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Dominic ES. Ijichi" <dom@ijichi.org>
Cc: randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org, axboe@suse.de, jgarzik@pobox.com

On Mon, 12 Dec 2005 01:24:04 +0000 (GMT) Dominic ES. Ijichi wrote:

> ----- Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Mon, 12 Dec 2005 00:24:53 +0000 (GMT) Dominic ES. Ijichi wrote:
> > 
> > > ----- Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > > > On Sat, 10 Dec 2005 19:01:50 +0000 Dominic Ijichi wrote:
> > > > 
> > > 
> > > oh right.  sorry to trouble you but the list archive has a 'hole'
> > when that patch was released, could you possibly forward it to me?
> > 
> > Sure, I forgot about that.  It's below for anyone who wants to try
> > it.
> 
> apologies if i'm being a bit thick here (ssh!), but don't i need to be running the ahci module, which doesnt use the ide code?  i could never get the machine to boot with the ide driver, and my suse10 distro has this note in /etc/modprobe.conf:
> 
> # ata_piix can't handle ICH6 in AHCI mode
> install ata_piix /sbin/modprobe ahci; /sbin/modprobe --ignore-install ata_piix
> 
> i believe this controller is an intel ih6 sata controller in ahci mode, with a physical old-style ide port and udma100 ide drive plugged into it.


Good question.  I wish that I could answer it, but I'm confused about
it too.  Hopefully someone else will jump in and answer it.

---
~Randy
