From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/2] two ide fixes for -rc4
Date: Wed, 7 Oct 2009 00:27:30 +0200
Message-ID: <200910070027.30377.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933602AbZJFW2W@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>, Joao Ramos <joao.ramos@inov.pt>, David Fries <david@fries.net>, d.stussy@yahoo.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


patch #1 fixes old bug in sis5513 (uncovered by 2.6.30 device probing
changes but it could be also triggered in earlier kernels on warm-plug
operation)

patch #2 reverts the recent incorrect revert
