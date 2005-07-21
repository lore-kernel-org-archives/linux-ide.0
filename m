From: GaLi <gali@cleia.org>
Subject: sata_sil and hotswap
Date: Thu, 21 Jul 2005 16:23:52 +0200
Message-ID: <42DFAFF8.4070804@cleia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wpc0444.amenworld.com ([62.193.225.58]:48013 "EHLO
	WPC0444.AMENWORLD.COM") by vger.kernel.org with ESMTP
	id S261783AbVGUOX3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jul 2005 10:23:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org


Hi,

I have a Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 
[SATALink/SATARaid] Serial ATA Controller and want to use hotswap on it.

Disks are visible in /proc/scsi/sci :

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD2500JD-40G Rev: 09.0
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD2500JD-40G Rev: 09.0
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD2500JD-40G Rev: 09.0
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD2500JD-40G Rev: 09.0
   Type:   Direct-Access                    ANSI SCSI revision: 05


I'm trying to use the following command:

echo "scsi remove-single-device 2 0 0 0" > /proc/scsi/scsi

before removing the rack and change it by another with a maxtor drive.


When I'm launching :

echo "scsi add-single-device 2 0 0 0" > /proc/scsi/scsi

I always have :

Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD2500JD-40G Rev: 09.0
   Type:   Direct-Access                    ANSI SCSI revision: 05

in /proc/scsi/scsi intead of :

"Model: MAXTOR..."



What's wrong ? Is hotswap supported on Linux for this controller ?

Thank you,

GaLi

-- 
                        _
ASCII ribbon campaign ( )
  - against HTML email  X
              & vCards / \
