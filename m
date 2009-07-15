From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/4] ide-tape: misc stuff
Date: Wed, 15 Jul 2009 17:18:16 +0200
Message-ID: <1247671100-8173-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:23289 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbZGOPSZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2009 11:18:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi David,

here is some ide-tape stuff.

* 0001: somehow fell through the cracks, DEBUG build fix

* 0002: mostly code unification

* 0003: this one converts ide-tape to the debugging scheme we use with ide-cd
  and ide-floppy. It adds some debug calls at important places and has proven
  very helpful when working on bug reports with users. No functional change.

* 0004: real bugfix

The patches are also at

	git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git ide-tape-postponed


--
Thanks,
Boris.
