From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.14-rc2 0/2] libata: Marvell SATA support (v0.23-0.24)
Date: Thu, 06 Oct 2005 09:13:57 -0400
Message-ID: <43452315.7050801@pobox.com>
References: <20051005210610.EC31826369@lns1058.lss.emc.com> <Pine.LNX.4.63.0510061441050.3140@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750890AbVJFNOM@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0510061441050.3140@dingo.iwr.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bogdan Costescu wrote:
> mv_phy_reset: ENTER, port 0, mmio 0xf8a22000
> mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> ata3: no device found (phy stat 00000000)
> scsi2 : sata_mv
> mv_phy_reset: ENTER, port 1, mmio 0xf8a24000
> mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> ata4: no device found (phy stat 00000000)
> scsi3 : sata_mv
> mv_phy_reset: ENTER, port 2, mmio 0xf8a26000
> mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> ata5: no device found (phy stat 00000000)
> scsi4 : sata_mv
> mv_phy_reset: ENTER, port 3, mmio 0xf8a28000
> mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> ata6: no device found (phy stat 00000000)
> scsi5 : sata_mv

Staring at the docs a bit, I notice that the 50xx and 60xx have SATA 
S{status,control,error} registers at different locations.

50xx:

	SStatus:
	SATAHC0 0x20100 0x20200 0x20300 0x20400
	SATAHC1 0x30100 0x30200 0x30300 0x30400

	SError:
	SStatus addr + 4

	SControl:
	SStatus addr + 8

60xx:

	SStatus:
	SATAHC0 0x22300 0x24300 0x26300 0x28300
	SATAHC1 0x32300 0x34300 0x36300 0x38300

	SError:
	SStatus addr + 4

	SControl:
	SStatus addr + 8
