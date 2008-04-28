From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support
Date: Mon, 28 Apr 2008 09:20:56 +0800
Message-ID: <20080428092056.1e710a45@dxy.sh.intel.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080426103012.21dcf0fb@core>
	<20080427075115.3ea40204@dxy.sh.intel.com>
	<20080427093434.182a2137@core>
	<20080427220315.794a6df3@dxy.sh.intel.com>
	<20080427153111.3438dce8@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35452 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620AbYD1B1p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Apr 2008 21:27:45 -0400
In-Reply-To: <20080427153111.3438dce8@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Sun, 27 Apr 2008 22:31:11 +0800
"Alan Cox" <alan@lxorguk.ukuu.org.uk> wrote:

> Re: [PATCH] ata: Add Intel SCH PATA support
> 
> On Sun, 27 Apr 2008 22:03:15 +0800
> Alek Du <alek.du@intel.com> wrote:
> 
> > Alan,
> >
> > One problem I still do not understand, if I return PATA_UNK for cable detection result, could the
> > driver finally set the disk to UDMA5 mode if I plug in 80 wire disk?
> 
> You tell me - you've got the hardware documentation I assume. Assuming the
> system implements detection then it should. If a PATA controller doesn't
> implement any detection (cable or host side) and it does UDMA5 then I
> believe the correct description for it is usually "broken" as people will
> have horrible problems trying to use things like flash drives with it.
> 
> Alan

The data sheet of SCH (http://download.intel.com/design/chipsets/embedded/datashts/319537.pdf) page 347 shows
the only supported PATA registers, for those not shown should be treated as "Reserved". 
Unfortunately, IOCFG (0x54) and port enable bits (0x41, 0x43) are all reserved.

Let's regard SCH PATA controller is an usually "broken" one :-), what do you suggest me to work around it?
Force it to 40-wire pin? or use a KConfig option to select 40-wire or 80-wire?

Thanks,
Alek
