From: Ben Dooks <ben@fluff.org>
Subject: Re: [PATCH] Some IDE chipsets are architecture-specific
Date: Mon, 7 Mar 2005 15:51:52 +0000
Message-ID: <20050307155152.GA7789@home.fluff.org>
References: <20050307152803.GF28741@parcelfarce.linux.theplanet.co.uk> <20050307154755.GA31844@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:16018
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S261800AbVCGPwZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2005 10:52:25 -0500
Content-Disposition: inline
In-Reply-To: <20050307154755.GA31844@harddisk-recovery.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

On Mon, Mar 07, 2005 at 04:47:55PM +0100, Erik Mouw wrote:
> On Mon, Mar 07, 2005 at 03:28:03PM +0000, Matthew Wilcox wrote:
> > Mark some chipset support as being for specific architectures.
> > I may have got some wrong, so please double-check.
> > 
> > Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> > 
> > Index: ./drivers/ide/Kconfig
> > ===================================================================
> > RCS file: /var/cvs/linux-2.6/drivers/ide/Kconfig,v
> > retrieving revision 1.25.2.1
> > diff -u -p -r1.25.2.1 Kconfig
> > --- ./drivers/ide/Kconfig	2 Mar 2005 11:19:06 -0000	1.25.2.1
> > +++ ./drivers/ide/Kconfig	7 Mar 2005 04:49:26 -0000
> > @@ -457,6 +457,7 @@ config BLK_DEV_AEC62XX
> >  
> >  config BLK_DEV_ALI15X3
> >  	tristate "ALI M15x3 chipset support"
> > +	depends on X86
> >  	help
> >  	  This driver ensures (U)DMA support for ALI 1533, 1543 and 1543C
> >  	  onboard chipsets.  It also tests for Simplex mode and enables
> 
> AFAIK the ALI 1533 and 1543 are generic PCI southbridges that can be
> used on any PCI bus, so I wouldn't limit them to X86 only.

The Simtec (ex Chalice) CATS uses an ALI 1543, and that is an ARM

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
