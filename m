From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch][0/9] ide: sanitize PIO code
Date: Wed, 8 Sep 2004 21:26:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200409082126.24556.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269317AbUIHT1m@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56257 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S12564AbUIHTZd (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Wed, 8 Sep 2004 21:25:33 +0200
Content-Disposition: inline
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

This patchkit:

- converts PIO code to use scatterlists instead of directly walking bios
- fixes longstanding 'data integrity on error' issue in non-taskfile PIO code
- unifies single/multiple PIO handling
- unifies taskfile/non-taskfile PIO handling
- removes bio walking code

Bartlomiej
