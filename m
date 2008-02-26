From: saeed <saeed@marvell.com>
Subject: Re: Sata-MV, Intergated Sata Device Support
Date: Tue, 26 Feb 2008 00:39:25 -1100 (SST)
Message-ID: <alpine.DEB.0.99.0802260024400.22022@ubuntu-saeed.il.marvell.com>
References: <1176673884.5109.30.camel@Desktop> <47C35203.20402@garzik.org>
 <47C3585D.8070701@rtr.ca> <47C35A85.3020307@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shoshil.marvell.com ([199.203.130.250]:28608 "EHLO
	il.marvell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751454AbYBZIxH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 03:53:07 -0500
In-Reply-To: <47C35A85.3020307@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, jon@ngndg.com, LKML <linux-kernel@vger.kernel.org>



On Mon, 25 Feb 2008, Jeff Garzik wrote:

> > ...
> > 
> > Saeed:  isn't this what your SOC patches already implemented for us?
> > As near as I can tell, sata_mv now already has support for the 60x1C0.
> 
> Saeed's stuff didn't support PCI though, and Jon Li is definitely talking
> about PCI...
yes, my patch added support for the SoC sata like in the 5182, and this 
is what Jon Li was concerned about. he mentioneded the 60x1C0 pci device 
just to suggest to use it's code for the SoC sata as it is very similar.

saeed
