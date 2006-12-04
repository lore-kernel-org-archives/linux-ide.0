From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: sata_via or libata regression in 2.6.19? Synchronizing SCSI cache
 for disk sdX FAILED
Date: Mon, 04 Dec 2006 13:39:14 +0100
Message-ID: <457416F2.7090404@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:46028 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP id S936372AbWLDMjn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 07:39:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail2.syneticon.net (Postfix) with ESMTP id DC4C64D572
	for <linux-ide@vger.kernel.org>; Mon,  4 Dec 2006 13:39:41 +0100 (CET)
Received: from mail2.syneticon.net ([127.0.0.1])
 by localhost (linux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23818-06 for <linux-ide@vger.kernel.org>;
 Mon,  4 Dec 2006 13:39:21 +0100 (CET)
Received: from postfix1.syneticon.net (postfix1.syneticon.net [192.168.112.6])
	by mail2.syneticon.net (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Mon,  4 Dec 2006 13:39:21 +0100 (CET)
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by postfix1.syneticon.net (Postfix) with ESMTP id 06E6E94F0
	for <linux-ide@vger.kernel.org>; Mon,  4 Dec 2006 13:39:21 +0100 (CET)
Received: from postfix1.syneticon.net ([192.168.113.4])
	by localhost (192.168.113.3 [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id 1TkcLHnXDvsa for <linux-ide@vger.kernel.org>;
	Mon,  4 Dec 2006 13:39:18 +0100 (CET)
Received: from [192.168.10.145] (xdsl-81-173-141-125.netcologne.de [81.173.141.125])
	by postfix1.syneticon.net (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Mon,  4 Dec 2006 13:39:18 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

When I remove sata_via module, kernel disables ata first, and after 
that, it wants to synchronize SCSI cache:

# rmmod sata_via
ata3.00: disabled
Synchronizing SCSI cache for disk sdb:
FAILED
   status = 0, message = 00, host = 4, driver = 00

This happens both on VT6420 and VT6421 chipsets.

In 2.6.18, I didn't have this warning.

sata_via didn't change much between 2.6.18 and 2.6.19, so should I look 
for the cause in libata?


-- 
Tomasz Chmielewski
http://wpkg.org
