From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.22-rc2: known regressions with patches
Date: Thu, 24 May 2007 16:11:16 +0100
Message-ID: <20070524161116.047c55e9@the-village.bc.nu>
References: <46559B62.5040903@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:59077 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751782AbXEXPIU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 11:08:20 -0400
In-Reply-To: <46559B62.5040903@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, viro@zeniv.linux.org.uk, Uwe Bugla <uwe.bugla@gmx.de>, Ken Chen <kenchen@google.com>, xfs-masters@oss.sgi.com, Jeremy Fitzhardinge <jeremy@goop.org>, David Chinner <dgc@sgi.com>, Andrea Righi <righiandr@users.sourceforge.net>, Christoph Lameter <clameter@sgi.com>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Francis Russell <francisrussell@btopenworld.com>, Alan Cox <alan@redhat.com>, Andi Kleen <ak@suse.de>, discuss@x86-64.org, Ben Collins <ben.collins@ubuntu.com>

> Subject    : pata_via appears to incorrectly detects 40-pin cable
> References : http://lkml.org/lkml/2007/5/17/273
>              http://bugzilla.kernel.org/show_bug.cgi?id=8142
> Submitter  : Francis Russell <francisrussell@btopenworld.com>
> Status     : Not really a regression. Alan seems to have a general fix.
>              (Tejun Heo)

The laptop one has been resolved, tested and fired at Andrew.

Note btw that the bugzilla and email refer to two differing bugs. The
SATA one (bugzilla ref) has gone to Jeff and is a different fix.

Alan
