From: chris.bu@gmx.net
Subject: sata_via + VT8237 RAID 0 array of 2 s-ata drives
Date: Thu, 10 Mar 2005 11:22:16 +0100 (MET)
Message-ID: <29362.1110450136@www25.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received: from pop.gmx.de ([213.165.64.20]:60122 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262505AbVCJKWR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Mar 2005 05:22:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff,

a quick question about libata + sata_via V1.10 as included in the most
recent kernel 2.6.11.2:

I have a MSI KT6V (MS-7021) mainboard with VIA VT-8237 Southbridge and want
to connect two S-ATA hard disk drives. Both drives should run in a RAID 0
array, which is to be configured through the S-ATA RAID BIOS on the main
board.

Is it possible that the sata_via driver recognizes the existence of the
array and treats it as one drive under LINUX? As far as I've learned, the
VT-8237 is not a real hardware RAID solution and needs some software support
from the OS, too. Again, is it possible to do this, or does the driver only
support seperate s-ata channels, no matter what is configured in the S-ATA
RAID BIOS? If the BIOS configured RAID volumes are not supported at all (any
plans for the near future?) what would you recommend to do instead to
provide fast and efficient RAID 0 striping for both s-ata drives (to double
the r/w data rate).

Are there any other limitations with the current sata_via driver concerning
VT8237 with two S-ATA drives?

Thank you very much for your support and the continued effort to maintain
this driver.


Best regards,

Chris

-- 
DSL Komplett von GMX +++ Supergünstig und stressfrei einsteigen!
AKTION "Kein Einrichtungspreis" nutzen: http://www.gmx.net/de/go/dsl
