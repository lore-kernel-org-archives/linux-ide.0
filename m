From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch] Add the device IDs for AMD/ATI SB700
Date: Mon, 28 May 2007 22:16:59 +0200
Message-ID: <200705282216.59611.bzolnier@gmail.com>
References: <FFECF24D2A7F6D418B9511AF6F35860201B3658E@shacnexch2.atitech.com> <4656C8BC.6060807@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:65097 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbXE1VFq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 May 2007 17:05:46 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1705528ugf
        for <linux-ide@vger.kernel.org>; Mon, 28 May 2007 14:05:46 -0700 (PDT)
In-Reply-To: <4656C8BC.6060807@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Henry Su <henry.su@amd.com>, alan@lxorguk.ukuu.org.uk, greg@kroah.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, xiaosuzi520@hotmail.com


Hi,

Sorry for the late reply and thanks to Jeff for stepping in. :)

Since Jeff covered both status of your patches and administrative issues
I would only like to add one small hint for people adding support for
multi-function PCI chipsets (with multiple PCI device IDs):

It makes sense to put addition of _all_ new PCI IDs into the first patch
of the series and send it to PCI Maintainer (Hi Greg).  This should make
all other patches from the series independent of each other (in the usual
case I'm not talking about all crazy scenarios here).  After the patch
with PCI IDs gets applied upstream you may now send all other patches to
the respective maintainers without worrying about inter-patch dependencies
and without maintainers worrying about your patches not applying cleanly.

IIRC Intely guys are using this process when adding support for their new
chipsets and it works smoothly.

[ Yep, this process is the exception from the general "patch shouldn't add
  unused code" rule but the amount of _temporarily_ unused stuff is _minimal_
  and doing it this way saves a lot of time for all parties involved. ]

PS Greg/Jeff If I'm totally wrong on this please correct me...

Thanks,
Bart

On Friday 25 May 2007, Jeff Garzik wrote:
> Henry Su wrote:
> > I check the latest kernel source code with git, and find out that the
> > SMBus patch has not been applied yet,  
> 
> Correct.  When you don't see a patch in the upstream git tree 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
> then the next step is consult the MAINTAINERS file, and determine to 
> whom you should send a follow-up patch, or simply contact about the 
> status of a patch you just sent.  In this case, SMBus is in drivers/i2c 
> sub-directory, which leads us to find in MAINTAINERS,
> 
> I2C SUBSYSTEM
> P:      Jean Delvare
> M:      khali@linux-fr.org
> L:      i2c@lm-sensors.org
> T:      quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
> S:      Maintained
> 
> That tells us the maintainer of the subsystem, and also ("T:") an 
> external reference (a tree) to where the maintainer posts accepted 
> patches, prior to sending them upstream.
> 
> So for SMBus, you should make sure your SMBus changes appear in Jean 
> Delvare's quilt tree.  If they do not, create a new patch and send it to 
> Jean and CC i2c@lm-sensors.org and linux-kernel@vger.kernel.org.
> 
> 
> > and the patch for IDE  has not been  applied completely.one more device
> > id should be added to pata_atiixp.c, 
> > l list the patch as following, or you can fetch it from the attached file,
> > could you please apply this for me?  
> 
> Actually it has been applied -- the part that I maintain (drivers/ata/*) 
> is currently stored in a secondary tree, as described above.  Your patch 
> has been stored on the 'upstream' branch of 
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> Currently, the upstream Linux kernel is only accepting bug fixes.  I 
> merge ATA bug fixes (and sometimes simple PCI ID additions) into 
> libata-dev.git#upstream-fixes during this phase of development.  These 
> changes are sent upstream in 24-48 hours, to ensure that they will be 
> included in the next release (kernel 2.6.22).
> 
> All other ATA changes are merged into libata-dev.git#upstream.  When 
> Linus releases kernel 2.6.22, the "merge window" opens, allowing 
> non-bug-fix changes to be submitted upstream.  When the merge window 
> opens, I submit everything in libata-dev.git#upstream to Linus and 
> Andrew Morton for inclusion in the official upstream kernel tree.
> 
> That is our development process in a nutshell.
> 
> The kernel development process is conducted entirely via email, so you 
> see why it is so important to learn how to email patches in the proper 
> format.
> 
> 	Jeff
