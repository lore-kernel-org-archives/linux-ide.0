From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Restore Kconfig updated experimental levels and
 correct
Date: Fri, 09 Mar 2007 07:45:20 -0500
Message-ID: <45F156E0.5030509@garzik.org>
References: <20070308232449.5ce1a43b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55639 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964935AbXCIMpX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:45:23 -0500
In-Reply-To: <20070308232449.5ce1a43b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> @@ -572,15 +581,6 @@
>  
>  	  If unsure, say N.
>  
> -config PATA_SCC
> -	tristate "Toshiba's Cell Reference Set IDE support"
> -	depends on PCI && PPC_IBM_CELL_BLADE
> -	help
> -	  This option enables support for the built-in IDE controller on
> -	  Toshiba Cell Reference Board.
> -
> -	  If unsure, say N.
> -
>  endif
>  endmenu


I'm going to presume this is a diffing error.

BTW, akpm has a new email address.

	Jeff


