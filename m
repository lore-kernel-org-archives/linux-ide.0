From: Sven Mueller <debian@incase.de>
Subject: ata_piix installation/device detection problems on Dell server
Date: Mon, 04 Apr 2005 20:35:28 +0200
Message-ID: <425188F0.60805@incase.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.ciphirelabs.net ([217.72.114.64]:20160 "EHLO
	mx1.ciphirelabs.net") by vger.kernel.org with ESMTP id S261326AbVDDSfc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Apr 2005 14:35:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Debian-Boot <debian-boot@lists.debian.org>, control@bugs.debian.org

Package: debian-installer
Version: RC3
Thanks

Hi.

I Cc this message to the ata_piix maintainer, the debian bug tracking 
system for debian-installer (since it affects installation) as well as 
the linux-ide mailinglist (as requested in the ata_piix source) and the 
debian-boot mailinglist (though it should get a report from the BTS). If 
you think any of these are inappropriate, please let me know and remove 
them from replies please.

I just experienced a problem with a Dell server which is using combined 
mode to provide a PATA port for its CD-ROM and an SATA port for its HD.

The problem I experienced is as follows:

the ata_piix driver detects PATA and SATA in combined mode (which does 
seem correct as far as I can tell). However, only the HD is 
detected/registered in the kernel while the CD-ROM remains 
undetected/unregistered.
I therefore can't install using the default settings of debian-installer 
rc3 (netinst CD tested, other still untested, but since it's a kernel 
issue, I doubt they would make a difference.

I was able to work around this issue by _not_ loading the ata_piix 
module at first, but load the generic ide driver module instead. Of 
course, that module doesn't detect the SATA part, so I would be able to 
access the CD-ROM but not the HD. However, loading ata_piix _after_ the 
generic IDE driver notes that the first port is busy (PATA, used by 
ide_generic) and only initializes the SATA part. This makes it possible 
to access both SATA (HD) and PATA (CD).

If anyone wants access to the machine in question, I guess I could 
arrange both root and serial console access to it for a limited time. 
Will have to check with my boss though. Tell me if you would need that.

regards,
Sven

PS: Please Cc me in answers unless you also send a copy to the 
debian-boot mailinglist (which I read).
