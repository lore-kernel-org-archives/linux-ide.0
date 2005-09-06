From: Alexander Shaposhnikov <shaposh@isp.nsc.ru>
Subject: RE :sata_sil + UDMA CRC errors
Date: Tue, 06 Sep 2005 18:33:18 +0700
Message-ID: <1126006398.3097.9.camel@m00>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.isp.nsc.ru ([194.226.178.19]:16057 "EHLO ns.isp.nsc.ru")
	by vger.kernel.org with ESMTP id S964815AbVIFLdU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2005 07:33:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "lbattraw@insightbb.com" <lbattraw@insightbb.com>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "Carlos.Pardo@siliconimage.com" <Carlos.Pardo@siliconimage.com>, Yuri Kirsanov <flash@rccb.ru>, Paul Taylor <Paul.Taylor@siliconimage.com>, TeJun Heo <htejun@gmail.com>


Hi again.

Some time ago i reported bugs in sata_sil driver.

It seems that latest kernel 2.6.13-git4 solved all the problems for my Seagate SATA drive.
However, nothing has changed with Samsung drive, i am still getting alot of CRC errors.
There is probably some unknown compatibility issue with Samsung drives and sil3114 controller.

If somebody is interested in this, i can provide more detailed information.


Best Regards,
Alexander Shaposhnikov


