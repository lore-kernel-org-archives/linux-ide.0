From: "Joshua Newton" <posts@standingduck.net>
Subject: Problems with SATA Plextor PX-716SA
Date: Thu, 10 Mar 2005 20:21:05 -0500
Message-ID: <1110504065.22739.218065703@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54157 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S263274AbVCKBVV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Mar 2005 20:21:21 -0500
Received: from web2.messagingengine.com (web2.internal [10.202.2.211])
	by frontend1.messagingengine.com (Postfix) with ESMTP id 291F1C60A2F
	for <linux-ide@vger.kernel.org>; Thu, 10 Mar 2005 20:21:15 -0500 (EST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, I've just installed a Plextor PX-716SA in my server, and I'm having
trouble with it.  I can do eject/load with the eject utility, and I can
mount DVDs and list the contents, but burning doesn't work at all. 
Instead of burning start, the drive locks, and I get:

Mar 10 17:15:37 [kernel] SCSI error : <1 0 0 0> return code = 0x2
Mar 10 17:17:02 [kernel] ata2: command 0xa0 timeout, stat 0xd0 host_stat
0x20

To make the drive available again, I have to reboot.  This behavior is
consistent.  I've confirmed it both with vanilla 2.6.11 (libata.h edited
to enable ATAPI support) and the latest patch set against 2.6.11
available from
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/

The motherboard is an Intel D865GBF with ICH5.  I've got a Seagate
ST3200822AS attached to the first SATA channel, and the Plextor (fw
1.04) attached to the second.  I have two Seagate ST3200822As attached
to the primary and secondary PATA channels, one each.

If there's any other useful information I can provide, please let me
know.


TIA
