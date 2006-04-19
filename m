From: "Dominic ES. Ijichi" <dom@ijichi.org>
Subject: Re: PIIX libata ?
Date: Wed, 19 Apr 2006 10:48:26 +0100 (BST)
Message-ID: <31311506.91145440106542.JavaMail.root@willow.ijichi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from willow.ijichi.org ([62.128.131.81]:12253 "EHLO
	willow.ijichi.org") by vger.kernel.org with ESMTP id S1750848AbWDSJsg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Apr 2006 05:48:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-ide@vger.kernel.org, Frido Ferdinand <frido@zolder.org>


----- Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Tue, 18 Apr 2006 13:59:05 +0000 (UTC) Frido Ferdinand wrote:
> 
> > Hi,
> > 
> > How can i see that PIIX is either from libata or the usual IDE
> drivers. I have
> > both enabled in the kernel but not sure which takes presedence, will
> the drives
> > show up as /dev/sda ? disks used are non-sata/normal ide disks.
> 
> If both are built into the kernel (=y and not modules), legacy
> IDE drivers take precedence since ide/ is ahead of scsi/ in
> drivers/Makefile (libata drivers are in scsi/).
> 
> I have no idea about precedence if you are using initrd or initramfs.
> 
> And if legacy ide and scsi are both modules, you won't boot...
> (without using initrd or initramfs).

if I have both ahci and ata_piix modules in initrd (as is the case in most distros), is there any way of passing a parameter to the kernel to tell it which one i want?  ahci seems to take preference on my ICH6M but the ata_piix module works better.

dom

> 
> ---
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

