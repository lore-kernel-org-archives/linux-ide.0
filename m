From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] ide-taskfile.c fixups/cleanups [0/11]
Date: Sat, 19 Jun 2004 18:15:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406191806.48048.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7076 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264228AbUFSQP7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Jun 2004 12:15:59 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Hi,

This patchkit prepares ide-taskfile.c for unification
of CONFIG_IDE_TASKFILE_IO=y, CONFIG_IDE_TASKFILE_IO=n
and flagged_* PIO handlers which should happen soon
- lets deal with "easier" changes first.

Bartlomiej

