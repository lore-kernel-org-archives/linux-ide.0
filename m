From: <florian.werner@netcontrol.de>
Subject: sata dvd burning issue
Date: Thu, 12 May 2005 13:51:45 +0200
Message-ID: <F1F08A2468B3814982D2F4FEBB03DD422E416D@xxl-nt-02.hewis.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from darkgate.equinoxe.de ([217.22.192.6]:14770 "HELO
	darkgate.equinoxe.de") by vger.kernel.org with SMTP id S261505AbVELLvx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 May 2005 07:51:53 -0400
Received: from unknown (HELO mail.netcontrol.de) ([217.91.107.244]) (envelope-sender <florian.werner@netcontrol.de>)
          by darkgate.equinoxe.de (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 12 May 2005 11:36:22 -0000
Content-Class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi

i managed to get my new Plextor PX-712SA DVD-Burner working by changing
/usr/src/linux/include/linux/libata.h

from:
#undef ATA_ENABLE_ATAPI
to
#define ATA_ENABLE_ATAPI

now i can mount dvds and cds but i am not able to burn!

best regards

florian werner



