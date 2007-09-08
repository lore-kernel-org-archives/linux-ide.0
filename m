From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: sata & scsi suggestion for make menuconfig
Date: Sat, 08 Sep 2007 09:56:08 +0200
Message-ID: <46E25598.3060305@s5r6.in-berlin.de>
References: <20070907124800.GP16806@vanheusden.com> <20070907083522.3191a4ba.randy.dunlap@oracle.com> <20070907155903.GR16806@vanheusden.com> <46E17A81.7020304@s5r6.in-berlin.de> <20070907230529.GX16806@vanheusden.com> <46E249CB.5070505@s5r6.in-berlin.de> <Pine.LNX.4.64.0709080927490.25942@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:51565 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbXIHH4n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 03:56:43 -0400
In-Reply-To: <Pine.LNX.4.64.0709080927490.25942@fbirervta.pbzchgretzou.qr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: Folkert van Heusden <folkert@vanheusden.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jan Engelhardt wrote:
> On Sep 8 2007 09:05, Stefan Richter wrote:
>> config ATA_SD
>> 	tristate "SATA/PATA HDD support (via SCSI disk support)"
>> 	depends on ATA
>> 	select BLK_DEV_SD
>> 	help
>> 	  'SCSI disk support' is required to access SATA HDDs.  It is
[...]
>>	  You can say Y or M here to select SCSI disk support, or you
>>	  can do so in the 'SCSI device support' section.
[...]
> And what uses ATA_SD, or is the user supposed to manually enable it?

It is merely there to produce the prompt which people asked for.
CONFIG_ATA_SD (or CONFIG_ATA_BLK_DEV_SD or whatever) won't turn up in
any Makefile or source code.

Note, I'm not fond of 'select' nor of dummy Kconfig variables.  Plus I
can personally live very well with the current solution (sd_mod et al
are mentioned in the help text at CONFIG_ATA).  That's why I posted only
the example instead of a complete patch.
-- 
Stefan Richter
-=====-=-=== =--= -=---
http://arcgraph.de/sr/
