From: Randolph Chung <randolph@tausq.org>
Subject: Re: [parisc-linux] [PATCH] asm-parisc/ide.h cleanup (there are no standard ports)
Date: Sat, 27 Mar 2004 16:21:39 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040328002139.GE750@tausq.org>
References: <200403241443.43206.bzolnier@elka.pw.edu.pl> <20040327222810.GB24782@colo.lackof.org> <200403280024.57672.bzolnier@elka.pw.edu.pl> <20040327234926.GC24782@colo.lackof.org>
Reply-To: Randolph Chung <randolph@tausq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gandalf.tausq.org ([64.81.244.94]:13240 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id S261960AbUC0Xwv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Mar 2004 18:52:51 -0500
Content-Disposition: inline
In-Reply-To: <20040327234926.GC24782@colo.lackof.org>
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, parisc-linux@parisc-linux.org

> I was told offline my hypothetical example is in fact hypothetical.
> parisc won't build with IDE unless PCI is defined. I haven't tried.

not exactly. what i meant is, without this patch, if you built pa with
ide enabled but pci disabled you will get a compilation error.

i think this patch looks ok too. will commit to our tree and let willy
propogate upstream :)

thanks,
randolph
-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/
