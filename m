From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] Add the device IDs for AMD/ATI SB700
Date: Fri, 25 May 2007 07:30:04 -0400
Message-ID: <4656C8BC.6060807@garzik.org>
References: <FFECF24D2A7F6D418B9511AF6F35860201B3658E@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54002 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbXEYLaL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 07:30:11 -0400
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F35860201B3658E@shacnexch2.atitech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henry Su <henry.su@amd.com>
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, bzolnier@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, xiaosuzi520@hotmail.com

Henry Su wrote:
> I check the latest kernel source code with git, and find out that the SMBus patch has not been applied yet, 

Correct.  When you don't see a patch in the upstream git tree 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
then the next step is consult the MAINTAINERS file, and determine to 
whom you should send a follow-up patch, or simply contact about the 
status of a patch you just sent.  In this case, SMBus is in drivers/i2c 
sub-directory, which leads us to find in MAINTAINERS,

I2C SUBSYSTEM
P:      Jean Delvare
M:      khali@linux-fr.org
L:      i2c@lm-sensors.org
T:      quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
S:      Maintained

That tells us the maintainer of the subsystem, and also ("T:") an 
external reference (a tree) to where the maintainer posts accepted 
patches, prior to sending them upstream.

So for SMBus, you should make sure your SMBus changes appear in Jean 
Delvare's quilt tree.  If they do not, create a new patch and send it to 
Jean and CC i2c@lm-sensors.org and linux-kernel@vger.kernel.org.


> and the patch for IDE  has not been  applied completely.one more device id should be added to pata_atiixp.c,
> l list the patch as following, or you can fetch it from the attached file, could you please apply this for me? 

Actually it has been applied -- the part that I maintain (drivers/ata/*) 
is currently stored in a secondary tree, as described above.  Your patch 
has been stored on the 'upstream' branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Currently, the upstream Linux kernel is only accepting bug fixes.  I 
merge ATA bug fixes (and sometimes simple PCI ID additions) into 
libata-dev.git#upstream-fixes during this phase of development.  These 
changes are sent upstream in 24-48 hours, to ensure that they will be 
included in the next release (kernel 2.6.22).

All other ATA changes are merged into libata-dev.git#upstream.  When 
Linus releases kernel 2.6.22, the "merge window" opens, allowing 
non-bug-fix changes to be submitted upstream.  When the merge window 
opens, I submit everything in libata-dev.git#upstream to Linus and 
Andrew Morton for inclusion in the official upstream kernel tree.

That is our development process in a nutshell.

The kernel development process is conducted entirely via email, so you 
see why it is so important to learn how to email patches in the proper 
format.

	Jeff


