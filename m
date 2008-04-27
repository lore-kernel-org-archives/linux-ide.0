From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support
Date: Sun, 27 Apr 2008 22:03:15 +0800
Message-ID: <20080427220315.794a6df3@dxy.sh.intel.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080426103012.21dcf0fb@core>
	<20080427075115.3ea40204@dxy.sh.intel.com>
	<20080427093434.182a2137@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:31817 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530AbYD0OKF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Apr 2008 10:10:05 -0400
In-Reply-To: <20080427093434.182a2137@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Alan,

One problem I still do not understand, if I return PATA_UNK for cable detection result, could the
driver finally set the disk to UDMA5 mode if I plug in 80 wire disk?

Thanks,
Alek

On Sun, 27 Apr 2008 09:34:34 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > > PATA_80 means "controller *knows* we are 80 wire". PATA_UNK means
> > > "controller can't do detect."
> > 
> > I need to force SCH to use PATA 80 pins to enable UDMA5, just like the way ich_laptop force
> > to use 40 pins.
> 
> What if I plug in a non 80 wire device ?
> 
> > hmmm... for non-sch chipsets, there is no impact, this will only affect sch. You mean
> > I should create a ata_sch.c file instead of patching ata_piix.c ?
> 
> No an sch subtype in the driver just as we have types for ich/piix etc.
> 
