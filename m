From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/3] ide-tape: misc stuff
Date: Sat, 18 Jul 2009 11:55:14 +0200
Message-ID: <1247910917-5237-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:55470 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbZGRJzX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Jul 2009 05:55:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi David,

here's a re-spun version with patch 2 dropped.

* 0001: somehow fell through the cracks, DEBUG build fix

* 0002: this one converts ide-tape to the debugging scheme we use with ide-cd
  and ide-floppy. It adds some debug calls at important places and has proven
  very helpful when working on bug reports with users. No functional change.

* 0003: real bugfix

The patches are also at

	git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git ide-tape-postponed


--
Thanks,
Boris.
