From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [3/5] 2.6.22-rc2: known regressions
Date: Sun, 20 May 2007 00:06:13 +0200
Message-ID: <464F74D5.9080204__44709.2246883132$1179612443$gmane$org@googlemail.com>
References: <464F6DC9.80805@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:8179 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762617AbXESWGm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 May 2007 18:06:42 -0400
Received: by ug-out-1314.google.com with SMTP id 44so801114uga
        for <linux-ide@vger.kernel.org>; Sat, 19 May 2007 15:06:41 -0700 (PDT)
In-Reply-To: <464F6DC9.80805@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Francis Russell <francisrussell@btopenworld.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, video4linux@list.redhat.com, Mauro Carvalho Chehab <mchehab@infradead.org>, Hans Verkuil <hverkuil@xs4all.nl>, Robert Fitzsimons <robfitz@273k.net>

Hi all,

Here is a list of some known regressions in 2.6.22-rc2.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



SATA/PATA

Subject    : libata and legacy ide pcmcia failure
References : http://lkml.org/lkml/2007/5/17/305
Submitter  : Robert de Rooy <robert.de.rooy@gmail.com>
Status     : Unknown

Subject    : pata_via appears to incorrectly detects 40-pin cable
References : http://lkml.org/lkml/2007/5/17/273
             http://bugzilla.kernel.org/show_bug.cgi?id=8142
Submitter  : Francis Russell <francisrussell@btopenworld.com>
Status     : Unknown

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



V4L

Subject    : V4L ABI breakage
References : http://lkml.org/lkml/2007/5/14/42
Submitter  : Robert Fitzsimons <robfitz@273k.net>
Caused-By  : Hans Verkuil <hverkuil@xs4all.nl>
             Mauro Carvalho Chehab <mchehab@infradead.org>
             commit 206ebaf32795cf1582b1e2ff2ec6a560c9e986b8
Status     : Unknown



Regards,
Michal

--
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
