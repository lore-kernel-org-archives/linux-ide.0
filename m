From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Kernel 2.6.18 and above
Date: Sat, 21 Apr 2007 10:15:32 +1000
Message-ID: <1177114532.6080.13.camel@localhost.localdomain>
References: <4626AEF7.9010804@users.sourceforge.net>
	 <46286D36.5090609@users.sourceforge.net>
	 <1177057830.17978.13.camel@localhost.localdomain>
	 <200704202241.13223.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45042 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736AbXDUATv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Apr 2007 20:19:51 -0400
In-Reply-To: <200704202241.13223.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mike <michael_six@users.sourceforge.net>, B.Zolnierkiewicz@elka.pw.edu.pl, list linux-ide <linux-ide@vger.kernel.org>


> Since this is a 2.6.17->2.6.18 regression narrowing the problem down to
> the specific changeset (or at least -git or even -rc) seems like a most
> promising way in discovering the source of the issue.

Dunno... unless I missed something in the logs, both 2.6.17 and .18 seem
to report initially the wrong size (2GB), but the kernel seems to ignore
the size from the IDE layer and use the one in the partition map in .17
and not in .18 ...

To me at least, it looks like it's not a regression per-se but a latent
bug made visible.

Cheers,
Ben.


