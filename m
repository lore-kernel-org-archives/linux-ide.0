From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PCI Constants Update for SATA Driver
Date: Sun, 27 Feb 2005 15:07:22 -0500
Message-ID: <20050227200722.GA16996@havoc.gtf.org>
References: <1109526163.19325.2.camel@forge.intermeta.de> <42220CAA.90702@pobox.com> <1109532002.19325.4.camel@forge.intermeta.de> <4222250C.6060302@pobox.com> <1109534706.19325.6.camel@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:50585 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261321AbVB0UHa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Feb 2005 15:07:30 -0500
Content-Disposition: inline
In-Reply-To: <1109534706.19325.6.camel@forge.intermeta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henning Schmiedehausen <hps@intermeta.de>
Cc: Linux IDE Mailingliste <linux-ide@vger.kernel.org>

On Sun, Feb 27, 2005 at 09:05:06PM +0100, Henning Schmiedehausen wrote:
> Let me rephrase:
> 
> What sense does it make to have PCI_VENDOR_ID and PCI_DEVICE_ID
> constants if using them is optional/discouraged?

Only PCI_DEVICE_ID_xxx is discouraged.  Not PCI_VENDOR_ID_xxx.

	Jeff



