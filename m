From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL v2] libata maintainership update
Date: Tue, 7 May 2013 10:40:55 -0700
Message-ID: <20130507174055.GD5531@mtj.dyndns.org>
References: <20130507171921.GB5531@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:62025 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab3EGRlB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 May 2013 13:41:01 -0400
Content-Disposition: inline
In-Reply-To: <20130507171921.GB5531@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus, Jeff, linux-ide folks.

As discussed earlier, Jeff is leaving for something more fun and I'm
inheriting the maintainership of libata.  Please pull from the
following branch to receive MAINTAINERS update.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-3.10

I'll manage it similarly to other trees I'm maintaining.  When X-rc1
drops, for-X-fixes and for-X+1 are created on top of it and for-next
will be pulling in both branches.

v2: Sergei noticed that I forgot to update the tree field.  Updated
    it in place.  Thanks.

--
tejun

----------------------------------------------------------------
Tejun Heo (1):
      libata: change maintainer

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1f5fac..eeae5a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7140,9 +7140,9 @@ F:	drivers/misc/phantom.c
 F:	include/uapi/linux/phantom.h
 
 SERIAL ATA (SATA) SUBSYSTEM
-M:	Jeff Garzik <jgarzik@pobox.com>
+M:	Tejun Heo <tj@kernel.org>
 L:	linux-ide@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
 S:	Supported
 F:	drivers/ata/
 F:	include/linux/ata.h
