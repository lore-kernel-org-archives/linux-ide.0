From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Should be Acard ATP8620 2SATA / 1 IDE  driver
Date: Wed, 7 Nov 2007 17:13:55 -0500
Message-ID: <20071107221355.GB15784@havoc.gtf.org>
References: <00b501c81ace$ece895f0$6200a8c0@jameshsu> <47270656.7080205@garzik.org> <003701c81c63$cee89c30$6200a8c0@jameshsu> <025c01c82016$fbcf3810$d400a8c0@laurence> <025001c82067$d76c04c0$6200a8c0@jameshsu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:39135 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754787AbXKGWN4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 17:13:56 -0500
Content-Disposition: inline
In-Reply-To: <025001c82067$d76c04c0$6200a8c0@jameshsu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jameshsu <jameshsu@acard.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, tytso@us.ibm.com, Matti Aarnio <postmaster@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, 'David Miller' <davem@davemloft.net>, Daniel Weng <dweng@acard.com>, Jason Wu <jason_wu@acard.com>, laurence@mail.acard.com

On Tue, Nov 06, 2007 at 07:25:46PM +0800, jameshsu wrote:
> Hi Jeff,
> 
> Please help Acard to add this chip spec on the web site in your earlier
> conveniance.
> http://gkernel.sourceforge.net/specs/
> http://linux-ata.org/driver-status.html#open_chipsets

Updated, thanks much!


> By the way, once you complete the SATA sample driver , please inform us , so
> we could modify, test and submit in the near future.
> If any chip info still missing or need us to involve, please let me know.

I began working on a sample driver, but looking at your document, it
appears you are AHCI-compatible?

If so, we would prefer to modify drivers/ata/ahci.c to support your
hardware.  This already supports AHCI variants from Intel, NVIDIA, ATI,
VIA, JMicron and Marvell.

	Jeff



