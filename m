From: Sebastian Kuzminsky <seb@highlab.com>
Subject: suggest me a SATA controller
Date: Fri, 13 Jan 2006 11:24:58 -0700
Message-ID: <E1ExTbe-0002dg-99@highlab.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc11.comcast.net ([63.240.77.81]:56236 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1422785AbWAMSYT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jan 2006 13:24:19 -0500
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1ExTbe-0002dg-99
	for linux-ide@vger.kernel.org; Fri, 13 Jan 2006 11:24:58 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I need four or more eSATA ports on one PCI-X controller, stable and
with good performance.  I can use the little SATA-to-eSATA connector
adapters if I have to, but would prefer to have the eSATA ports right
on the board.  I'll be using the disks as components of a software Raid,
so Raid on the HBA is not needed.

What controllers are people having good success with?  Looks like AHCI
and Promise TX[24] are the best ones right now.

I've got a Marvell 6081-based controller now, and it's unstable under
certain conditions...  I'm looking for good hardware with good linux
drivers.  Any suggestions are welcome.


-- 
Sebastian Kuzminsky
