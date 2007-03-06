From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: RE: [patch 26/30] Support for Marvell 7042 Chip
Date: Tue, 6 Mar 2007 07:42:52 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901053E84BD@EMPBEDEX.empirix.com>
References: <200703061038.l26AcBaO019542@shell0.pdx.osdl.net> <45ED5825.2000605@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from empbedex1.empirix.com ([12.38.203.54]:35013 "EHLO
	empbedex1.empirix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933251AbXCFMnB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 07:43:01 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org

I have tested with generic 2.6.20.2 on on x86 (XEON)
platform and a similiar (but not exactly same) 2.6.20.x 
(git tree from Freescale) for my target CPU: MPC8548E

Its exactly the same SATA chip - the only difference
between 7042 & 6042 is the PCI bridge interface.

In the case of 6042 - its a PCI to PCI Bridge
In the case of 7042 - its a PCI to PCI Express Bridge

I do not believe there is any other difference - except
the physical bus interface.

I should have 'said' this in the patch request...

Tom Morrison




-----Original Message-----
From: Jeff Garzik [mailto:jeff@garzik.org]
Sent: Tue 3/6/2007 7:01 AM
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org; Morrison, Tom
Subject: Re: [patch 26/30] Support for Marvell 7042 Chip
 
akpm@linux-foundation.org wrote:
> From: "Morrison, Tom" <tmorrison@empirix.com>
> 
> Added Support for Marvell 7042 Chip - 7042 has same capabilities & behavior
> as 6042.
> 
> Signed-off-by: Thomas A. Morrison <tmorrison@empirix.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/sata_mv.c |    3 +++
>  1 file changed, 3 insertions(+)

applied, although it's questionable whether this works at all on PCI-Express



