From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Sparse warning in sata_nv.c
Date: Wed, 6 Jan 2010 10:54:16 -0800
Message-ID: <20100106105416.4bdc225a@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vyatta.com ([76.74.103.46]:43400 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756097Ab0AFSy6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Jan 2010 13:54:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id BE9C14F42C2
	for <linux-ide@vger.kernel.org>; Wed,  6 Jan 2010 10:54:48 -0800 (PST)
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g5FsKpAwy5J1 for <linux-ide@vger.kernel.org>;
	Wed,  6 Jan 2010 10:54:24 -0800 (PST)
Received: from nehalam (pool-74-107-135-205.ptldor.fios.verizon.net [74.107.135.205])
	by mail.vyatta.com (Postfix) with ESMTP id EB2064F42A7
	for <linux-ide@vger.kernel.org>; Wed,  6 Jan 2010 10:54:23 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Sparse complains about the following, not sure best way to fix it.
Either change ATA_NCQ_SHT() or do manual expansion.

-- 
 CHECK   drivers/ata/sata_nv.c
drivers/ata/sata_nv.c:394:9: warning: Initializer entry defined twice
drivers/ata/sata_nv.c:398:10:   also defined here
drivers/ata/sata_nv.c:402:9: warning: Initializer entry defined twice
drivers/ata/sata_nv.c:406:10:   also defined here
