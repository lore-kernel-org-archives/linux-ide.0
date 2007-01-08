From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: SATA Promise
Date: Mon, 08 Jan 2007 10:06:49 -0700
Message-ID: <45A27A29.5040604@mlbassoc.com>
References: <200612191738.kBJHcFkP003688@alkaid.it.uu.se>	<45A27571.3060106@mlbassoc.com> <17826.31038.143943.152976@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sta-204-188-98-27.rockynet.com ([204.188.98.27]:2901 "EHLO
	hermes.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbXAHRGw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jan 2007 12:06:52 -0500
In-Reply-To: <17826.31038.143943.152976@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Gary Thomas writes:
>  > Mikael Pettersson wrote:
>  > > On Tue, 19 Dec 2006 08:54:07 -0700, Gary Thomas wrote:
>  > >   
>  > >> I'm trying to use the sata_promise driver (1.04) with a CDROM
>  > >> and having little luck.  I'm using this chipset:
>  > >>    00:0b.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus) (rev 02)
>  > >>
>  > >> If I plug in a SATAPI drive, the driver hangs during initialization.
>  > >> If I plug in a (PATA) ATAPI drive, I'm told:
>  > >>
>  > >> ata3.01: ATAPI, max MWDMA2
>  > >> ata3.01: configured for MWDMA2
>  > >>    Vendor: ATA       Model: ST3250824NS       Rev: 3.AE
>  > >>    Type:   Direct-Access                      ANSI SCSI revision: 05
>  > >> ata3.01: WARNING: ATAPI is not supported with this driver, device ignored.
>  > >>
>  > >> Is there any way to get this working (I'm using Linux 2.6.18, with
>  > >> linux-2.6-sata-promise-pata-ports.patch from Fedora Core 6)
>  > >>     
>  > >
>  > > Patience. The driver doesn't support ATAPI yet, but I
>  > > intend to work on that soon.
>  > >
>  > >   
>  > Any progress on this? 
> 
> Yes. SATAPI and PATAPI are working. Patches have been posted
> to linux-ide, and hopefully final combined/reworked/tidied-up
> patches should be available tomorrow.

Very nice, thanks.

BTW, what SATAPI drive did you try this with?  I have a Lite-On
LTN-52S1S that doesn't seem to work at all with the PDC40775 - it
just hangs during the bootup.


-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
