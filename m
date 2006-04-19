From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: PIIX libata ?
Date: Wed, 19 Apr 2006 12:34:32 -0700
Message-ID: <20060419123432.949d13bb.rdunlap@xenotime.net>
References: <31311506.91145440106542.JavaMail.root@willow.ijichi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:60090 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751075AbWDSTcH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Apr 2006 15:32:07 -0400
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Wed, 19 Apr 2006 12:32:05 -0700
In-Reply-To: <31311506.91145440106542.JavaMail.root@willow.ijichi.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Dominic ES. Ijichi" <dom@ijichi.org>
Cc: linux-ide@vger.kernel.org, frido@zolder.org

On Wed, 19 Apr 2006 10:48:26 +0100 (BST) Dominic ES. Ijichi wrote:

> 
> ----- Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Tue, 18 Apr 2006 13:59:05 +0000 (UTC) Frido Ferdinand wrote:
> > 
> > > Hi,
> > > 
> > > How can i see that PIIX is either from libata or the usual IDE
> > drivers. I have
> > > both enabled in the kernel but not sure which takes presedence, will
> > the drives
> > > show up as /dev/sda ? disks used are non-sata/normal ide disks.
> > 
> > If both are built into the kernel (=y and not modules), legacy
> > IDE drivers take precedence since ide/ is ahead of scsi/ in
> > drivers/Makefile (libata drivers are in scsi/).
> > 
> > I have no idea about precedence if you are using initrd or initramfs.
> > 
> > And if legacy ide and scsi are both modules, you won't boot...
> > (without using initrd or initramfs).
> 
> if I have both ahci and ata_piix modules in initrd (as is the case in most distros), is there any way of passing a parameter to the kernel to tell it which one i want?  ahci seems to take preference on my ICH6M but the ata_piix module works better.

combined_mode ?  from Documentation/kernel-parameters.txt:

	combined_mode=	[HW] control which driver uses IDE ports in combined
			mode: legacy IDE driver, libata, or both
			(in the libata case, libata.atapi_enabled=1 may be
			useful as well).  Note that using the ide or libata
			options may affect your device naming (e.g. by
			changing hdc to sdb).
			Format: combined (default), ide, or libata


---
~Randy
