From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 0/2] ide: ide_do_drive_cmd cleanups
Date: Thu, 15 May 2008 09:05:56 +0900
Message-ID: <1210809958-13881-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:55529 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbYEOAGX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 20:06:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This is a sequel to the patchset "removing the on-stack struct request":

http://marc.info/?l=linux-ide&m=120964501711519&w=2

The patchset makes some stuff unnecessary anymore but I forgot to
remove them. This patchset removes them.

This is against Bart's latest quilt tree.



