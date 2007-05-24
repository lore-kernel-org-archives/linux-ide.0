From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: 2.6.22-rc2: known regressions with patches
Date: Thu, 24 May 2007 16:04:18 +0200
Message-ID: <46559B62.5040903@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:34799 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbXEXOEi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 10:04:38 -0400
Received: by ug-out-1314.google.com with SMTP id j3so884131ugf
        for <linux-ide@vger.kernel.org>; Thu, 24 May 2007 07:04:37 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, viro@zeniv.linux.org.uk, Uwe Bugla <uwe.bugla@gmx.de>, Ken Chen <kenchen@google.com>, xfs-masters@oss.sgi.com, Jeremy Fitzhardinge <jeremy@goop.org>, David Chinner <dgc@sgi.com>, Andrea Righi <righiandr@users.sourceforge.net>, Christoph Lameter <clameter@sgi.com>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Francis Russell <francisrussell@btopenworld.com>, Alan Cox <alan@redhat.com>, Andi Kleen <ak@suse.de>, discuss@x86-64.org, Ben Collins <ben.collins@ubuntu.com>

Hi all,

Here is a list of some known regressions in 2.6.22-rc2
with patches available.

=46eel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Block devices

Subject    : loop devices limited to one single device
References : http://lkml.org/lkml/2007/5/16/229
Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
Handled-By : Ken Chen <kenchen@google.com>
Patch      : http://lkml.org/lkml/2007/5/21/483
Status     : patch available



=46ile systems

Subject    : 2.6.21-git10/11: files getting truncated on xfs
References : http://lkml.org/lkml/2007/5/9/410
Submitter  : Jeremy Fitzhardinge <jeremy@goop.org>
Handled-By : David Chinner <dgc@sgi.com>
Patch      : http://lkml.org/lkml/2007/5/12/93
Status     : patch available



Memory management

Subject    : bug in i386 MTRR initialization
References : http://lkml.org/lkml/2007/5/19/93
Submitter  : Andrea Righi <righiandr@users.sourceforge.net>
Status     : patch available



SATA/PATA

Subject    : pata_via appears to incorrectly detects 40-pin cable
References : http://lkml.org/lkml/2007/5/17/273
             http://bugzilla.kernel.org/show_bug.cgi?id=3D8142
Submitter  : Francis Russell <francisrussell@btopenworld.com>
Status     : Not really a regression. Alan seems to have a general fix.
             (Tejun Heo)

Subject    : libata reset-seq merge broke sata_sil on sh
References : http://lkml.org/lkml/2007/5/10/63
Submitter  : Paul Mundt <lethal@linux-sh.org>
Handled-By : Tejun Heo <htejun@gmail.com>
Caused-By  : commit 4750def52cb2c21732dda9aa1d43a07db37b0186
Patch      : http://lkml.org/lkml/2007/5/19/161
Status     : patch available



x86-64

Subject    : BUG: at mm/slab.c:777 __find_general_cachep()
References : http://lkml.org/lkml/2007/5/18/17
Submitter  : Jeff Garzik <jeff@garzik.org>
Handled-By : Ben Collins <ben.collins@ubuntu.com>
Patch      : http://lkml.org/lkml/2007/5/18/19
Status     : patch available



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"

