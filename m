From: maximilian attems <max@stro.at>
Subject: Re: Bug#598518: linux-image-2.6-686: ata_piix module loaded before
	ahci module deactivate hotplug support (regression from lenny)
Date: Mon, 4 Oct 2010 17:54:38 +0000
Message-ID: <20101004175438.GZ5947@vostochny.stro.at>
References: <20100929165034.21331.69639.reportbug@albatros.savanenet> <1285799230.28504.105.camel@localhost> <4CAA04FB.7070402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vostochny.stro.at ([78.47.22.85]:40184 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756393Ab0JDRyj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Oct 2010 13:54:39 -0400
Content-Disposition: inline
In-Reply-To: <4CAA04FB.7070402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 598518@bugs.debian.org, thomas.debesse+debian@gmail.com
Cc: Ben Hutchings <ben@decadent.org.uk>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

hello,

On Mon, Oct 04, 2010 at 06:46:51PM +0200, Tejun Heo wrote:
> >> The solution is to load ahci module before ata_piix module, then we can have
> >> SATA drives managed by ahci module and IDE drives managed by ata_piix module.
> > [...]
> > 
> > You can force ahci to be loaded first:
> > 1. Add the line 'ahci' to /etc/initramfs-tools/modules.
> > 2. Run 'update-initramfs -u' to regenerate the initramfs.
> > 3. Reboot.
> > 
> > But it seems like it would be better if ahci was automatically
> > preferred.
> 
> With modules.order in place, modprobe will always prefer ahci over
> ata_piix (the preference follows the link order).  Maybe debian initrd
> doesn't handle modules.order properly?

we do shipp modules.order in initramfs.

hmm thomas what are your MODULES settings, please post output of
 egrep MODULES -r /etc/initramfs-tools/

if MODULES=dep appears it could be that the sys walking code has
a bug in adding the wrong module to the initramfs.
please change it to the safe and default MODULES=most and regenerate:
update-initramfs -u -k <kernelversion>

you can check any initramfs if it has the relevant modules with
lsinitramfs /boot/initrd.img-2.6.35-trunk-amd64 | grep ahci 


thanks

-- 
maks
