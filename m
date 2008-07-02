From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] sata_sil24: add DIDs for adaptec
 flavors
Date: Wed, 2 Jul 2008 08:55:17 +0100
Message-ID: <20080702085517.61909c74@lxorguk.ukuu.org.uk>
References: <486AED59.7020606@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47886 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751444AbYGBINF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jul 2008 04:13:05 -0400
In-Reply-To: <486AED59.7020606@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Travis Read <ics@dark.net.au>

On Wed, 02 Jul 2008 11:52:09 +0900
Tejun Heo <tj@kernel.org> wrote:

> Adaptec uses different DIDs for 3132.  Add them.
> 
> Reported by Travis Read.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Travis Read <ics@dark.net.au>

NAK

>  	{ PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
>  	{ PCI_VDEVICE(CMD, 0x3131), BID_SIL3131 },
>  	{ PCI_VDEVICE(CMD, 0x3531), BID_SIL3131 },
> +	{ PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
> +	{ PCI_VDEVICE(CMD, 0x0244), BID_SIL3132 },

The first of those is a duplicate (see the top entry)

Alan
