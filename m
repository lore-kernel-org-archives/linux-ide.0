From: "Oliver Korpilla" <Oliver.Korpilla@gmx.de>
Subject: [SATA] SATA_SIL and ATI SB400 chipset
Date: Wed, 9 Mar 2005 13:40:10 +0100 (MET)
Message-ID: <12981.1110372010@www41.gmx.net>
References: <25661.1110101727@www58.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received: from mail.gmx.net ([213.165.64.20]:31169 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262348AbVCIMkM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Mar 2005 07:40:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello!

This is my final note about this - this is not a Debian bug, because Debian
uses 2.6.8 for their AMD64 Sarge install media. But plain vanilla Linux only
recognizes the SATA controller only starting from 2.6.11 - not even vanilla
2.6.10 with matching config will work.

So: With the ATI SB400 chipset use a SATA_SIL driver from > 2.6.11. :)

Thanks and with kind regards,
Oliver Korpilla

-- 
DSL Komplett von GMX +++ Supergünstig und stressfrei einsteigen!
AKTION "Kein Einrichtungspreis" nutzen: http://www.gmx.net/de/go/dsl
