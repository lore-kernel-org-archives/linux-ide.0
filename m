From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] irq: better lost/spurious irq handling
Date: Fri, 02 Jul 2010 16:59:54 +0200
Message-ID: <4C2DFEEA.9050704@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56694 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758763Ab0GBPBE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2010 11:01:04 -0400
In-Reply-To: <1276443098-20653-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tglx@linutronix.de
Cc: mingo@elte.hu, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

Hello, Thomas.

Please pull from the following branch to receieve lost-spurious-irq
patchset.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git lost-spurious-irq

The branch contains the patches to implement lost/spurious IRQ
handling (patches 0001-0010) and apply it to USB (0012).  libata part
is being discussed and not included in this pull request.

Thanks.

--
tejun

