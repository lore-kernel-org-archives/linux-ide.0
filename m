From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] ide-taskfile.c fixups/cleanups part #2 [0/9]
Date: Wed, 30 Jun 2004 17:23:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200406301723.37659.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S266735AbUF3Pc7@vger.kernel.org>
Content-Disposition: inline
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

Unification of CONFIG_IDE_TASKFILE_IO=y|n and "flagged"
PIO handlers with a lot of fixes in the process.

Bartlomiej
