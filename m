From: Frank Henkel <fhenkel@hpce.nec.com>
Subject: Instability
Date: Tue, 19 Apr 2005 16:50:09 +0200
Message-ID: <200504191650.11926.fhenkel@hpce.nec.com>
Reply-To: fhenkel@hpce.nec.com
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail01.hpce.nec.com ([193.141.139.228]:25523 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S261573AbVDSOuW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Apr 2005 10:50:22 -0400
Content-Description: clearsigned data
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear Jeff,

we have a stability problem under x86_64 Linux using the 
sata_sil driver for the SiI 3512A dual port SATA onboard
controller (BIOS Version 4.3.47) of the MSI MS-9145 Dual 
Opteron (So940) MoBo.

The proprietary drivers from SiI don't match our kernel
versions, so we rely on the sata_sil alternative.

What Linux distros I have tested:

Distro		Kernel              sata_sil Version
- -------------------------------------------------------
SuSE 9.3 x86_64	2.6.11.4-20a-smp    0.8
- -------------------------------------------------------
Scientific Linux CERN 3.0.4
                2.4.21-27.0.2.EL.cernsmp
                                    0.54
- -------------------------------------------------------
RHEL WS3 U4     2.4.X (server crashed before information 
                       was saved)   
- -------------------------------------------------------

The problem is, that I a lot of console messages like

    ata1: status=0x51 { DriveReady SeekComplete Error }
    ata1: error=0x04 { DriveStatus Error }

appear when data is written to disk.  And, suddenly, I/O 
errors are reported and the system hangs.  In the case of
RHEL WS3 U4 I lost the complete installation, because 
fsck couldn't catch up all errors in the FS.

Do you know problems with this specific SATA controller?
Do you have a solution (2.4 kernel)?
Can I help you with more information to enhance the driver?

Thank you.
Best regards,
Frank
==================================================
Frank Henkel
Application Analyst
NEC High Performance Computing Europe GmbH, EHPCTC
Hessbruehlstr. 21B, 70565 Stuttgart, Germany
Tel: +49 711 78055 14      fhenkel@hpce.nec.com
Fax: +49 711 78055 25      http://www.hpce.nec.com
==================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Further Information: www.gnupg.org, www.gnupp.de, www.sicherheit-im-internet.de/themes/engl.phtml, http://hp.vector.co.jp/authors/VA019487

iD8DBQFCZRqhbC4eWe/BlrIRAkdhAJ4oRRetabT4d3eoMIqr9CaAScOFRgCgjvzx
UHq0/yn9gxTtsZzuvNpXP14=
=qC02
-----END PGP SIGNATURE-----

