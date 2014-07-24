From: Crashplan Pro <linux-ide@crashplan.pro>
Subject: Marvell 88SE9130 hardware limited feature: PMP only 5 drives on 1
 port maximum?
Date: Thu, 24 Jul 2014 03:44:52 +0200
Message-ID: <53D06514.7030603@crashplan.pro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57490 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903AbaGXBoz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2014 21:44:55 -0400
Received: from mfilter22-d.gandi.net (mfilter22-d.gandi.net [217.70.178.150])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id C3C98FB89E
	for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2014 03:44:53 +0200 (CEST)
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
	by mfilter22-d.gandi.net (mfilter22-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 7f80-5AtmbR2 for <linux-ide@vger.kernel.org>;
	Thu, 24 Jul 2014 03:44:52 +0200 (CEST)
Received: from mac02.local (82-169-106-120.ip.telfort.nl [82.169.106.120])
	(Authenticated sender: linux-ide@crashplan.pro)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5CA22FB88B
	for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2014 03:44:52 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On https://ata.wiki.kernel.org/index.php/SATA_hardware_features I read 
that HBA's based on Marvell 88SE9130 chip support PMP technology.

The Marvell product brief for 88SE9130 also writes that this controller 
has support port multiplier technology and that this host controller 
supports two 6 Gb/s SATA peripheral interface ports.

Using a SilverStone EC05 (Marvell 88SE9130 chipset) connecting to 2 
Sil3726 based port multipliers each connecting to 5 Hitachi drives, 
results in a maximum of 5 SATA drives being detected by Ubuntu 64-bit 
kernel version 3.13.0-24-generic.

* When attaching PM#1 to EC05 SATA port#1, and PM#2 to EC05 SATA port
   #2, the 5 drives on PM#1 are detected by the kernel.
* When attaching PM#1 to EC05 SATA port#2, and PM#2 to EC05 SATA port
   #1, the 5 drives on PM#1 are detected by the kernel.
* When attaching PM#2 to EC05 SATA port#2, and disconnecting EC05 SATA
   port #1, the 5 drives on PM#2 are detected by the kernel.
   (so PM#2 is not defect)

Is this 5 drive limit more likely:
a.) a limitation in Marvell 88SE9130 hardware
or
b.) a Linux kernel with room for improvement

Thanks for ideas,
