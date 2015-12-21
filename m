From: Ming Lei <tom.leiming@gmail.com>
Subject: SATA IO errors after ''block: fix segment split"
Date: Mon, 21 Dec 2015 09:25:47 +0800
Message-ID: <CACVXFVNkpGqd+iPNyZwMaQrfVOK9fqsM+XARK1CRpiY99fsG+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33972 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbbLUBZr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 20:25:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Diethard_Jan=C3=9Fen?= <diethard.janssen@ljapunow.de>, Andre Przywara <andre.przywara@arm.com>, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, Linus Torvalds <torvalds@linux-foundation.org>

Hi,

Both Andre and Diethard reported that the following kind of
SATA write IO errors on 32bit(ARM/i386) with PAE after the
commit 578270bfb(block: fix segment split):

[  103.736982] ata1.00: exception Emask 0x0 SAct 0x3ffff0 SErr 0x0
action 0x6 frozen
[  103.744476] ata1.00: failed command: WRITE FPDMA QUEUED
[  103.749707] ata1.00: cmd 61/00:20:48:6b:41/08:00:0a:00:00/40 tag 4
ncq 1048576 out
[  103.749707]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  103.764659] ata1.00: status: { DRDY }

Unfortunately I can't reproduce the issue on QEMU with i686 plus
PAE after runing kinds of IO loads on the AHCI SATA drive.

But the commit 578270bfb(block: fix segment split) is quite simple and
straight-forward, and I can't see what is wrong with this change.

Looks size of the faulted I/O is always 1Mbytes in Diethard's reports(it
is in private email and I can show that if anyone need the logs), and seems
it is highly possiblly related with the commit b54ffb73cadc ("block:
remove bio_get_nr_vecs()"), which is another similar SATA report by
Linus.


Thanks,
Ming Lei
