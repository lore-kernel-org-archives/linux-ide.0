From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 0/5] sata_mv cleanups
Date: Mon, 31 Mar 2008 19:27:43 -0400
Message-ID: <47F1736F.8020104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1560 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbYCaX1p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 19:27:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Here are five new patches for sata_mv.
These serve to clean things up in preparation
for the PMP patches which will follow.

Hopefully nothing controversial here.

01_sata_mv_cosmetics.patch
02_sata_mv_clean_up_stop_edma.patch
03_sata_mv_fix_ifcfg_handling.patch
04_sata_mv_new_hardreset_handler.patch
05_sata_mv_remove_phy_reset_and_postreset.patch

I generated these against Jeff's upstream branch as of today.

Please let me know ASAP of any issues, as there's a bunch of
PMP patches for sata_mv hot on the heels of these ones.

Thanks
