From: Simos Xenitellis <simos.lists@googlemail.com>
Subject: Adding SATA disk with broken NCQ
Date: Tue, 06 Nov 2007 01:50:43 +0000
Message-ID: <1194313843.6277.8.camel@user-computer>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:29427 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbXKFBus (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 20:50:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1027778ugc
        for <linux-ide@vger.kernel.org>; Mon, 05 Nov 2007 17:50:46 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,
I'ld like to add another disk in the blacklist regarding NCQ
(libata-core.c).

It is the disk model "HITACHI HTS541616J9SA00" with rev "SB4IC7UP".

Currently there is a similar description,
         { "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
Notice the difference between SB4IC7UP and SB4OC70P.

I have verified that the model name and rev are "HITACHI
HTS541616J9SA00" and "SB4IC7UP" by adding printks in the kernel. The
word HITACHI is all caps.
Blacklisting does eliminate NCQ-related disk errors.

Simos


