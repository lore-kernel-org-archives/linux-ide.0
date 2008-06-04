From: Andrew Henry <adhenry@bredband.net>
Subject: Re: 2.6.25: sata_sil freezes, hard resets port.
Date: Wed, 04 Jun 2008 21:58:34 +0200
Message-ID: <4846F3EA.2050408@bredband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from proxy3.bredband.net ([195.54.101.73]:45553 "EHLO
	proxy3.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbYFDT6h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jun 2008 15:58:37 -0400
Received: from ironport.bredband.com (195.54.101.120) by proxy3.bredband.net (7.3.127)
        id 481183EA00C24C81 for linux-ide@vger.kernel.org; Wed, 4 Jun 2008 21:58:35 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Any news with this?  I start to understand that this really is a missing
function in the sata_sil driver: driver does not work well with power
saving modes/standby on eSATA drives.

I have created a cron script to 'ping' the drives usng sdparm -C start
/dev/sdX every 3 minutes and the drives have been operating with RAID1
and dmcrypt for 4 days non-stop without error.

It does seem that this fault I am experiencing is only caused by
incomplete driver.  Can someone please acknowledge this?


--andrew
