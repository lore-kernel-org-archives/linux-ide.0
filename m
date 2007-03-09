From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Restore Kconfig updated experimental levels and
 correct
Date: Fri, 9 Mar 2007 14:01:05 +0000
Message-ID: <20070309140105.1090c9f8@lxorguk.ukuu.org.uk>
References: <20070308232449.5ce1a43b@lxorguk.ukuu.org.uk>
	<45F156E0.5030509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45241 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1767240AbXCIM5b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 07:57:31 -0500
In-Reply-To: <45F156E0.5030509@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On Fri, 09 Mar 2007 07:45:20 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > @@ -572,15 +581,6 @@
> >  
> >  	  If unsure, say N.
> >  
> > -config PATA_SCC
> > -	tristate "Toshiba's Cell Reference Set IDE support"
> > -	depends on PCI && PPC_IBM_CELL_BLADE
> > -	help
> > -	  This option enables support for the built-in IDE controller on
> > -	  Toshiba Cell Reference Board.
> > -
> > -	  If unsure, say N.
> > -
> >  endif
> >  endmenu
> 
> 
> I'm going to presume this is a diffing error.

Looks like it, that file took a lot of merging after all the fallout.
Andrew - Jeff is right that this segment shouldnt be applied

Alan
