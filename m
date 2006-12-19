From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: SATA Promise
Date: Tue, 19 Dec 2006 18:38:15 +0100 (MET)
Message-ID: <200612191738.kBJHcFkP003688@alkaid.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38327 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932856AbWLSRjI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Dec 2006 12:39:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gary@mlbassoc.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

On Tue, 19 Dec 2006 08:54:07 -0700, Gary Thomas wrote:
> I'm trying to use the sata_promise driver (1.04) with a CDROM
> and having little luck.  I'm using this chipset:
>    00:0b.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus) (rev 02)
> 
> If I plug in a SATAPI drive, the driver hangs during initialization.
> If I plug in a (PATA) ATAPI drive, I'm told:
> 
> ata3.01: ATAPI, max MWDMA2
> ata3.01: configured for MWDMA2
>    Vendor: ATA       Model: ST3250824NS       Rev: 3.AE
>    Type:   Direct-Access                      ANSI SCSI revision: 05
> ata3.01: WARNING: ATAPI is not supported with this driver, device ignored.
> 
> Is there any way to get this working (I'm using Linux 2.6.18, with
> linux-2.6-sata-promise-pata-ports.patch from Fedora Core 6)

Patience. The driver doesn't support ATAPI yet, but I
intend to work on that soon.

/Mikael
