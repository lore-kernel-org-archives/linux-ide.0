From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] 2.6.18: 32-bit compatibility HDIO IOCTLs
Date: Thu, 05 Oct 2006 06:38:29 -0400
Message-ID: <4524E0A5.5010901@pobox.com>
References: <Pine.LNX.4.64N.0610031703010.4642@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:16603 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751619AbWJEKid (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Oct 2006 06:38:33 -0400
In-Reply-To: <Pine.LNX.4.64N.0610031703010.4642@blysk.ds.pg.gda.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-ide@vger.kernel.org

Maciej W. Rozycki wrote:
> Hello,
> 
>  A couple of HDIO IOCTLs are not yet handled and a few others are marked 
> as using a pointer rather than an unsigned long.  The formers include: 
> HDIO_GET_WCACHE, HDIO_GET_ACOUSTIC, HDIO_GET_ADDRESS and 
> HDIO_GET_BUSSTATE.  The latters are: HDIO_SET_MULTCOUNT, 
> HDIO_SET_UNMASKINTR, HDIO_SET_KEEPSETTINGS, HDIO_SET_32BIT, 
> HDIO_SET_NOWERR, HDIO_SET_DMA, HDIO_SET_PIO_MODE and HDIO_SET_NICE.  
> Additionally 0x330 used to be HDIO_GETGEO_BIG and may be issued by 32-bit 
> `hdparm' run on a 64-bit kernel making Linux complain loudly.
> 
>  The following patch fixes these issues.  Please apply.
> 
>   Maciej
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

Looks OK to me, but I would forward to Alan Cox and Andrew Morton for 
review and application...


