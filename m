From: Jeff Garzik <jgarzik@pobox.com>
Subject: Additions to libata patch archive
Date: Wed, 05 Oct 2005 00:13:24 -0400
Message-ID: <434352E4.8090002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:36052 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751210AbVJEEN3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 00:13:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>


I just added a few more patches to the libata patch archive.  The patch 
archive is a collection of libata patches that aren't being actively 
maintained, but could potentially be useful as a reference for a better 
patch in the future.


http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/archive/2.6.12-rc5-git8-ioctl-get-identity.patch.bz2
This patch adds support for the HDIO_GET_IDENTITY ioctl.  Bart (IDE 
maintainer) raised some valid objections -- objections that I keep 
forgetting once months pass -- and so the patch just sat.


http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/archive/2.6.13-vsc-mwi.patch.bz2
More properly configure Vitesse 7174 / Intel 31244 SATA controllers' 
MSI, DMA burst, and cacheline size settings.  Jeremy Higdon tested this 
patch and didn't see any problems, but since the current driver has been 
working, I didn't see any need to rush this patch in.  Maybe someone 
with hardware will become interested in it, as it does program the 
hardware more correctly.


http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/archive/2.6.14-rc3-sil-lbt.patch.bz2
This patch turns on the Silicon Image 311x "Large Block Transfer" 
feature, which eliminates legacy PCI IDE DMA limitations such as 64k 
boundary and 64k max DMA segment size.  This needs a lot of stress 
testing, but really should get merged as soon as enough people verify 
that it works for them.


http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/archive/2.6.14-rc3-sil24-original.patch.bz2
Original Silicon Image 3124 driver contributed by Silicon Image.  Since 
there is a newer driver, this is merely provided as a reference.



