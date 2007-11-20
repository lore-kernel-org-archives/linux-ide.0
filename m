From: Jeremy Jackson <jerj@coplanar.net>
Subject: SATA port multiplier Identify/Fail LEDs: driver support
Date: Tue, 20 Nov 2007 14:40:06 -0500
Message-ID: <1195587606.9402.43.camel@ragnarok.coplanar.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from narf.coplanar.net ([206.248.171.30]:45369 "EHLO
	narf.coplanar.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190AbXKTT5H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Nov 2007 14:57:07 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi,

I have Addonics.com port multiplier which has SiI3726 chip.  I'm pretty
sure it has LED outputs that are software controllable, to use with RAID
enclosures for Identifying drives (that have failed for example).

I wonder if anyone has chipset docs that can be used to write Linux
drivers for this function?  A brief email to Silicon Images a while back
wasn't very helpful, IIRC.

Thanks,

Jeremy

-- 
Jeremy Jackson
Coplanar Networks
(519)489-4903

