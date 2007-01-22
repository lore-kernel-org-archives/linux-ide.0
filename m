From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: fix compile warning caused by ignoring
 __must_check results
Date: Mon, 22 Jan 2007 11:29:45 +0000
Message-ID: <20070122112945.772a1c40@localhost.localdomain>
References: <20070120052329.GB24749@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35497 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751447AbXAVLSn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jan 2007 06:18:43 -0500
In-Reply-To: <20070120052329.GB24749@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Sat, 20 Jan 2007 14:23:29 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Fix compile warnings in pata_cs5530, sata_inic162x and sata_nv which
> are caused by throwing away return values marked with __must_check.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK NAK NAK NAK NAK NAK

As was previously discussed the bug is the bogus __must_check on
pci_set_mwi. That __must_check should be removed and that was also the
decision before but nothing happened. Please therefore get the pci header
fixed.

>  	pci_set_master(cs5530_0);
> -	pci_set_mwi(cs5530_0);
> +	rc = pci_set_mwi(cs5530_0);
> +	if (rc)
> +		dev_printk(KERN_WARNING, &cs5530_0->dev,
> +			   "WARNING: failed to set MWI\n");

Please drop this patch. Users don't need to scared by this bogus message.

Alan
