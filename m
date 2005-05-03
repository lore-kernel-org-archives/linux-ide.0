From: "Oskar Liljeblad" <oskar@osk.mine.nu>
Subject: Re: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Date: Tue, 3 May 2005 18:02:01 +0200
Message-ID: <20050503160201.GA12461@oskar>
References: <66F9227F7417874C8DB3CEB057727417045148@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aquila.skane.tbv.se ([193.13.139.7]:17822 "EHLO
	diadema.skane.tbv.se") by vger.kernel.org with ESMTP
	id S261804AbVECQCH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 May 2005 12:02:07 -0400
Content-Disposition: inline
In-Reply-To: <66F9227F7417874C8DB3CEB057727417045148@MILEX0.Miltope.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Drew Winstel <DWinstel@Miltope.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, May 03, 2005 at 10:17, Drew Winstel wrote:
> 
> Hmm... that puzzles me, although for no other reason than I'm not familiar 
> with how Maxtor drives report themselves.  Having the BIOS-reported LBA 
> sectors not equal to the OS-reported geometry may not be a problem, but 
> I must defer to the experts on that one.  
> 
> As an FYI just in case, the new libata-based driver will treat your drives 
> as SCSI drives, so you'll see the drives as sda, sdb, and so forth instead of
> hd?.  

Hm, I patched the kernel with 2.6.11-libata-dev1, compiled it with

# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_VIA82CXXX=y   (for the motherboard IDE)
CONFIG_SCSI=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_PATA_PDC2027X=y

and rebooted. SCSI is initialized and the pata_pdc2027x driver is
loaded, but it doesn't seem to find any devices. Or maybe it doesn't
look for devices at all. I can tell that it's loaded by the existence
of /sys/bus/pci/drivers/pata_pdc2027x (a directory which is empty).

/proc/scsi/scsi is also empty besides the "Attached devices:" line.
During startup the kernel does say "Probing IDE interface ide0"
through "ide5" (finding only devices on ide0). I also tried compiling
pata_pdc2027x as a module, with same result.

What's wrong here?

Regards,

Oskar Liljeblad (oskar@osk.mine.nu)
