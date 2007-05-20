From: Tejun Heo <htejun@gmail.com>
Subject: Re: [3/5] 2.6.22-rc2: known regressions
Date: Sun, 20 May 2007 12:51:51 +0200
Message-ID: <46502847.40204@gmail.com>
References: <464F6DC9.80805@googlemail.com> <464F74D5.9080204@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:10932 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865AbXETKwK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 May 2007 06:52:10 -0400
Received: by nz-out-0506.google.com with SMTP id z3so31106nzf
        for <linux-ide@vger.kernel.org>; Sun, 20 May 2007 03:52:10 -0700 (PDT)
In-Reply-To: <464F74D5.9080204@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Jeff Garzik <jeff@garzik.org>, Francis Russell <francisrussell@btopenworld.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, video4linux@list.redhat.com, Mauro Carvalho Chehab <mchehab@infradead.org>, Hans Verkuil <hverkuil@xs4all.nl>, Robert Fitzsimons <robfitz@273k.net>

Hello,

Michal Piotrowski wrote:
> SATA/PATA
> 
> Subject    : libata and legacy ide pcmcia failure
> References : http://lkml.org/lkml/2007/5/17/305
> Submitter  : Robert de Rooy <robert.de.rooy@gmail.com>
> Status     : Unknown

Doesn't look like a regression to me.  Doubled timeout looks like a
problem with timer.  I'll follow up on the original thread.

> Subject    : pata_via appears to incorrectly detects 40-pin cable
> References : http://lkml.org/lkml/2007/5/17/273
>              http://bugzilla.kernel.org/show_bug.cgi?id=8142
> Submitter  : Francis Russell <francisrussell@btopenworld.com>
> Status     : Unknown

Not really a regression.  Alan seems to have a general fix and I think
we can also quirk the specific case.

> Subject    : libata crash on halt
> References : http://marc.info/?l=linux-ide&m=117899827710565&w=2
> Submitter  : Andrew Morton <akpm@linux-foundation.org>
> Caused-By  : Tejun Heo <htejun@gmail.com>
>              commit 920a4b1038e442700a1cfac77ea7e20bd615a2c3
> Status     : problem is being debugged

This was fixed by the following commit.

commit da071b42f73dabbd0daf7ea4c3ff157d53b00648
Author: Tejun Heo <htejun@gmail.com>
Date:   Mon May 14 17:26:18 2007 +0200

    libata: fix shutdown warning message printing

> Subject    : libata reset-seq merge broke sata_sil on sh
> References : http://lkml.org/lkml/2007/5/10/63
> Submitter  : Paul Mundt <lethal@linux-sh.org>
> Handled-By : Tejun Heo <htejun@gmail.com>
> Caused-By  : commit 4750def52cb2c21732dda9aa1d43a07db37b0186
> Status     : problem is being debugged

Possible fix proposed.

  http://lkml.org/lkml/2007/5/19/161

I'll push the fix once Paul verifies it.

Thanks.

-- 
tejun
