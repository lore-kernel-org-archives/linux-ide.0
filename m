From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [PATCH] remove dead drivers/ide/ppc/swarm.c
Date: Tue, 4 May 2004 16:27:50 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.55.0405041621370.32082@jurand.ds.pg.gda.pl>
References: <200405040134.22092.bzolnier@elka.pw.edu.pl>
 <200405041428.50592.bzolnier@elka.pw.edu.pl> <20040504124349.GA15664@linux-mips.org>
 <200405041510.41731.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:61605 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264379AbUEDO1v
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 May 2004 10:27:51 -0400
In-Reply-To: <200405041510.41731.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 4 May 2004, Bartlomiej Zolnierkiewicz wrote:

> > Simply a result of the way the IDE bus is hooked up to the generic bus of
> > the Sibyte chip.  I'd have to research details if you're interested ...
> 
> The basic question is whether disk used on SiByte can be read i.e. on x86.
> If not than we may have serious problems with some special commands with
> current implementation (similar problem as on Atari Q40/Q60).

 I can check the GPIO attachment with 2.4 (which should behave the same
way here).  I don't have a PCI IDE board.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
