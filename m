From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: Should be Acard ATP8620 2SATA / 1 IDE  driver
Date: Thu, 8 Nov 2007 11:18:55 -0500
Message-ID: <20071108161855.GA31492@havoc.gtf.org>
References: <00b501c81ace$ece895f0$6200a8c0@jameshsu> <47270656.7080205@garzik.org> <003701c81c63$cee89c30$6200a8c0@jameshsu> <025c01c82016$fbcf3810$d400a8c0@laurence> <025001c82067$d76c04c0$6200a8c0@jameshsu> <20071107223031.GB25799@havoc.gtf.org> <005801c821fa$892827f0$6200a8c0@jameshsu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:39556 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756351AbXKHQS4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 11:18:56 -0500
Content-Disposition: inline
In-Reply-To: <005801c821fa$892827f0$6200a8c0@jameshsu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jameshsu <jameshsu@acard.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, tytso@us.ibm.com, Matti Aarnio <postmaster@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Jason Wu <jason_wu@acard.com>, laurence@mail.acard.com, Daniel Weng <dweng@acard.com>

On Thu, Nov 08, 2007 at 07:28:38PM +0800, jameshsu wrote:
> Not really understand your patch listed below. 
> We do not provide ahci.c file to you, so we don't know where the patch came from(diff from where)?? 
> Who create this and how can we get ahci.c file?? Can you tell us??

The file is found in the latest kernel source code.  Go to

	http://www.kernel.org/

and download the latest "full" kernel version, 2.6.23:

	http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.tar.bz2

and then to get the latest kernel, apply this patch:

	http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.24-rc2.bz2

Let me know if you need help unpacking and patching the kernel!

	Jeff



