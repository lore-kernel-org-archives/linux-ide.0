From: Dmitry-T <dmitry-t@yandex.ru>
Subject: sata_sil, how i test my ST3160023AS for remove from sil_blacklist
Date: Mon, 20 Jun 2005 20:12:34 +0500
Message-ID: <20050620201234.3eb4b151.dmitry-t@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:42423 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261313AbVFTPMu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2005 11:12:50 -0400
Received: from mail.samtel.ru (mail.samtel.ru [62.213.0.11])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j5KFCjI0031169
	for <linux-ide@vger.kernel.org>; Mon, 20 Jun 2005 08:12:46 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi!

I have two ST3160023AS and

/dev/sda:
 Timing buffered disk reads:   44 MB in  3.01 seconds =  14.61 MB/sec

I read comments in file
/usr/src/kernel-source-2.6.8/drivers/scsi/sata_sil.c (Debian Sarge)

and how i may test my ST3160023AS for remove from sil_blacklist?

What problems can appear after the removal ST3160023AS from the list?
