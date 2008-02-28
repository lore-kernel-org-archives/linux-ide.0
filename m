From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Thu, 28 Feb 2008 22:56:03 +0000
Message-ID: <20080228225603.2764bfd1@core>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39896 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757039AbYB1XGw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Feb 2008 18:06:52 -0500
In-Reply-To: <Pine.LNX.4.64.0802282306190.10087@axis700.grange>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Thu, 28 Feb 2008 23:37:36 +0100 (CET)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> Hi
> 
> just found out that the eSATA connector on my Intel DQ35JO motherboard 
> doesn't work... because it is connected to the controller with product ID 
> 29b6... And this ID is not yet handled by the driver. Can I have a patch, 
> please?:-) I think the correct entry would be

If the device is in AHCI mode it should match the ahci class entry - is
the device in AHCI mode or PIIX mode ?

