From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 31 Jan 2007 12:20:34 +0000
Message-ID: <20070131122034.5b457c68@localhost.localdomain>
References: <200612111003.39928.kovid@theory.caltech.edu>
	<4588877D.1000400@gmail.com>
	<20061220032941.GA8903@us.ibm.com>
	<4588B3D5.4030406@gmail.com>
	<20061221171035.GC6171@us.ibm.com>
	<20070130015507.GA30069@us.ibm.com>
	<45BEF492.9000000@gmail.com>
	<20070130233735.GA7483@us.ibm.com>
	<45BFE8BC.3000906@pobox.com>
	<45C076B9.3030106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40807 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933139AbXAaMSa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 07:18:30 -0500
In-Reply-To: <45C076B9.3030106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Gary Hade <garyhade@us.ibm.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, konradr@us.ibm.com

> Some SATA controllers use 0xff to indicate empty port.  This seldomly
> matters as we have the almighty SStatus register to check device
> presence (there is a bug regarding this, patch pending).
> 
> This GoVault drive fails because ata_piix doesn't have SCR while using
> 0xff to indicate port not ready (dunno exact which state causes 0xff
> status tho) while the GoVault drive fails to clear that state in 150ms
> (not 30s).  The libata sees 0xff after SRST if GoVault drive is attached

So we can also cut this down by only doing the extra polling on a device
which is SATA and lacks SCR ?

