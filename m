From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: sata & scsi suggestion for make menuconfig
Date: Sat, 8 Sep 2007 09:29:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709080927490.25942@fbirervta.pbzchgretzou.qr>
References: <20070907124800.GP16806@vanheusden.com>
 <20070907083522.3191a4ba.randy.dunlap@oracle.com> <20070907155903.GR16806@vanheusden.com>
 <46E17A81.7020304@s5r6.in-berlin.de> <20070907230529.GX16806@vanheusden.com>
 <46E249CB.5070505@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:46557 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbXIHH3M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 03:29:12 -0400
In-Reply-To: <46E249CB.5070505@s5r6.in-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Folkert van Heusden <folkert@vanheusden.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


On Sep 8 2007 09:05, Stefan Richter wrote:
>config ATA
>	[...]
>
>comment "Controller drivers"
>
>[...low-level drivers go here...]
>
>comment "Storage device drivers"
>
>config ATA_SD
>	tristate "SATA/PATA HDD support (via SCSI disk support)"
>	depends on ATA
>	select BLK_DEV_SD
>	help
>	  'SCSI disk support' is required to access SATA HDDs.  It is
>	  also necessary for parallel ATA (IDE) HDDs if you use the
>	  experimental parallel ATA option.
>
>	  You can say Y or M here to select SCSI disk support, or you
>	  can do so in the 'SCSI device support' section.
>
>[...ditto for CD/DVD-ROMs, tapes, and generic support...]

And what uses ATA_SD, or is the user supposed to manually enable it?



	Jan
-- 
