From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch][0/6] ide: sanitize PIO code, take 2
Date: Sat, 11 Sep 2004 00:26:20 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409110026.20064.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:20426 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268004AbUIJW1p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Sep 2004 18:27:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58657 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S52626AbUIJWZw (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Sat, 11 Sep 2004 00:25:52 +0200
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

This patchkit:

- converts PIO code to use scatterlists instead of directly walking bios
- fixes longstanding 'data integrity on error' issue in non-taskfile PIO code
- unifies single/multiple PIO handling
- unifies taskfile/non-taskfile PIO handling

Changes:
- resync with -bk (first two patches are now merged)
- ide_sg_init() become generic init_sg_one() helper (linux/scatterlist.h)
  (thanks to Jeff and Jens for suggestions)
- use init_sg_one() in Etrax IDE driver
- bugfix: use sg->length instead of sg_dma_len(sg)
  (found thanks to rmk's concerns)
- uninline ide_pio_multi()
- make ide_pio_sector() and task_error() static
- drop removal of bio walking for now

Testing (esp. on non x86) and comments are welcomed.

BTW 'sanitize DMA' patchkit should be ready soon.

Bartlomiej
