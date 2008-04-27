From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support
Date: Sun, 27 Apr 2008 09:34:34 +0100
Message-ID: <20080427093434.182a2137@core>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080426103012.21dcf0fb@core>
	<20080427075115.3ea40204@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44372 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752800AbYD0Ily (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Apr 2008 04:41:54 -0400
In-Reply-To: <20080427075115.3ea40204@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

> > PATA_80 means "controller *knows* we are 80 wire". PATA_UNK means
> > "controller can't do detect."
> 
> I need to force SCH to use PATA 80 pins to enable UDMA5, just like the way ich_laptop force
> to use 40 pins.

What if I plug in a non 80 wire device ?

> hmmm... for non-sch chipsets, there is no impact, this will only affect sch. You mean
> I should create a ata_sch.c file instead of patching ata_piix.c ?

No an sch subtype in the driver just as we have types for ich/piix etc.

