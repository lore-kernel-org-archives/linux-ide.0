From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: sata & scsi suggestion for make menuconfig
Date: Sat, 08 Sep 2007 09:05:47 +0200
Message-ID: <46E249CB.5070505@s5r6.in-berlin.de>
References: <20070907124800.GP16806@vanheusden.com> <20070907083522.3191a4ba.randy.dunlap@oracle.com> <20070907155903.GR16806@vanheusden.com> <46E17A81.7020304@s5r6.in-berlin.de> <20070907230529.GX16806@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752562AbXIHHHB@vger.kernel.org>
In-Reply-To: <20070907230529.GX16806@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

(added Cc linux-ide)

Folkert van Heusden wrote:
>>>> A popup makes some sense, but I don't know if menuconfig knows how to
>>>> do popup warnings... and it needs to be done for all *configs,
>>>> not just menuconfig.
>>> Maybe add a new type?
>> How about
>> comment "Note: 'SCSI disk support' is required for SATA/PATA HDDs!"
>> 	depends on ATA && !BLK_DEV_SD
> 
> Yes! Maybe create some status-line at the bottom of the screen in which
> these hints scrollby. Like powertop does.

'comment' is already supported by make {menu,x,g}config and AFAIK by
make oldconfig too.  It is not effective in make oldconfig though
because it will scroll off the screen quickly.

I am not a friend of 'select', but maybe the following actually helps.
I didn't follow all of this and previous related discussions, so I guess
somebody else suggested something like this before:


# drivers/ata/Kconfig

config ATA
	[...]

comment "Controller drivers"

[...low-level drivers go here...]

comment "Storage device drivers"

config ATA_SD
	tristate "SATA/PATA HDD support (via SCSI disk support)"
	depends on ATA
	select BLK_DEV_SD
	help
	  'SCSI disk support' is required to access SATA HDDs.  It is
	  also necessary for parallel ATA (IDE) HDDs if you use the
	  experimental parallel ATA option.

	  You can say Y or M here to select SCSI disk support, or you
	  can do so in the 'SCSI device support' section.

[...ditto for CD/DVD-ROMs, tapes, and generic support...]
-- 
Stefan Richter
-=====-=-=== =--= -=---
http://arcgraph.de/sr/
