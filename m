From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Generic platform device IDE driver
Date: Wed, 04 Oct 2006 15:38:45 +0100
Message-ID: <1159972725.25772.26.camel@localhost.localdomain>
References: <20061004074535.GA7180@localhost.hsdv.com>
	 <1159962084.25772.14.camel@localhost.localdomain>
	 <20061004200501.GB6664@localhost.Internal.Linux-SH.ORG>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16871 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161007AbWJDOOM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Oct 2006 10:14:12 -0400
In-Reply-To: <20061004200501.GB6664@localhost.Internal.Linux-SH.ORG>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rmk@arm.linux.org.uk, gregkh@suse.de, ysato@users.sourceforge.jp

Ar Iau, 2006-10-05 am 05:05 +0900, ysgrifennodd Paul Mundt:
> Ok, I wasn't sure if libata was intended for anything outside of the
> SATA case (especially non-PCI), but if that's the way to go, I'll look
> at hacking something up under libata.

Take a look at 2.6.18-mm or 2.6.19-* and you should see all you need in
that including the pcmcia driver and other users who set up much the
same way a generic platform device driver would.

