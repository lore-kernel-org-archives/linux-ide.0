From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch][0/0] ide: sanitize DMA
Date: Mon, 13 Sep 2004 01:33:04 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409130133.04246.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:3817 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S264113AbUILXhD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Sep 2004 19:37:03 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62979 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S27893AbUILXdu (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 3 others); Mon, 13 Sep 2004 01:33:50 +0200
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mikael Starvik <mikael.starvik@axis.com>, Erik Jacobson <erikj@subway.americas.sgi.com>


Hi,

This patchkit simplifies IDE DMA handling and fixes few bugs in
a process. It requires "sanitize PIO" patchkit to be applied first.

Mikeal, please check changes to Etrax ide.c.

Erik, could you take a look at sgiioc4.c changes
(disk DMA fix in particular)?

Thanks,
Bartlomiej
