From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/12] sata_sil: convert to new reset mechanism
Date: Sat, 28 Jan 2006 13:09:15 -0500
Message-ID: <43DBB34B.1050302@pobox.com>
References: <1138089922913-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:41417 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751608AbWA1SJT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jan 2006 13:09:19 -0500
In-Reply-To: <1138089922913-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Convert sata_sil to use new reset mechanism.  sata_sil is fairly
> generic and can directly use std routine.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Major NAK.

The placement of every hardware register read/write has been very 
carefully laid out, and your reset hardware re-orders a lot of that. 
Code re-ordering is fine.  Changing the order of I/O operations is not. 
  With this patch, sata_sil fails to wake up and initialize the SATA phy!

Proper code transformation is art.  You're doing really well, but this 
was a bit of a hiccup.  You should have presented a series of patches 
which changed over to your new ata_drive_probe_reset() stuff, while -not 
changing the hardware operations at all-.  Like a mathematical solution, 
your code is then provably correct.  If there is a regression, then you 
know it is a driver bug, and not a problem with hardware acting weird.

If the driver can access the SATA PHY registers, the very first thing it 
should usually do is the code in sata_std_hardreset()... everything 
except the 0x301 value write.  Or in other words, follow the code in 
__sata_phy_reset() PRECISELY (presuming that ATA_FLAG_SATA_RESET is not 
set).

sata_sil hardware initialization order and behavior should not change at 
all [though certainly you will change it sometime in the future].

So...   I will drop all other patches from you, let you resync with the 
latest stuff in libata-dev.git#upstream (NOTE: renamed from 
upstream-2.6.17 to upstream), and wait for your next barrage of patches ;-)

	Jeff


