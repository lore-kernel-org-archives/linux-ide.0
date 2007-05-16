From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/3] 2.6.22-rc1: known regressions v2
Date: Wed, 16 May 2007 22:31:39 +0200
Message-ID: <464B6A2B.9020703@googlemail.com>
References: <464B6743.9000607@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:18010 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168AbXEPUbt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 16:31:49 -0400
Received: by ug-out-1314.google.com with SMTP id 44so193365uga
        for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 13:31:48 -0700 (PDT)
In-Reply-To: <464B6743.9000607@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, xfs-masters@oss.sgi.com, David Chinner <dgc@sgi.com>, Jeremy Fitzhardinge <jeremy@goop.org>, "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Christoph Lameter <clameter@sgi.com>, Dave Airlie <airlied@linux.ie>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Oleg Nesterov <oleg@tv-sign.ru>, Alex Dubov <oakad@yahoo.com>, Pierre Ossman <drzeus@drzeus.cx>

Hi all,

Here is a list of some known regressions in 2.6.22-rc1.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



File systems

Subject    : 2.6.21-git10/11: files getting truncated on xfs
References : http://lkml.org/lkml/2007/5/9/410
Submitter  : Jeremy Fitzhardinge <jeremy@goop.org>
Handled-By : David Chinner <dgc@sgi.com>
Patch      : http://lkml.org/lkml/2007/5/12/93
Status     : patch was suggested



Memory management

Subject    : kernel BUG at include/linux/slub_def.h:88 kmalloc_index()
References : http://bugzilla.kernel.org/show_bug.cgi?id=8476
Submitter  : Cherwin R. Nooitmeer <cherwin@gmail.com>
Status     : Unknown



SATA/PATA

Subject    : libata crash on halt
References : http://marc.info/?l=linux-ide&m=117899827710565&w=2
Submitter  : Andrew Morton <akpm@linux-foundation.org>
Caused-By  : Tejun Heo <htejun@gmail.com>
             commit 920a4b1038e442700a1cfac77ea7e20bd615a2c3
Status     : problem is being debugged

Subject    : libata reset-seq merge broke sata_sil on sh
References : http://lkml.org/lkml/2007/5/10/63
Submitter  : Paul Mundt <lethal@linux-sh.org>
Handled-By : Tejun Heo <htejun@gmail.com>
Caused-By  : commit 4750def52cb2c21732dda9aa1d43a07db37b0186
Status     : problem is being debugged



Suspend

Subject    : Broken suspend on SMP with tifm
References : http://lkml.org/lkml/2007/5/13/161
Submitter  : Rafael J. Wysocki <rjw@sisk.pl>
Status     : patch was suggested



Regards,
Michal

--
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
