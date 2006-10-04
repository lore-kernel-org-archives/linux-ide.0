From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Generic platform device IDE driver
Date: Wed, 04 Oct 2006 12:41:24 +0100
Message-ID: <1159962084.25772.14.camel@localhost.localdomain>
References: <20061004074535.GA7180@localhost.hsdv.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10215 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030791AbWJDLQc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Oct 2006 07:16:32 -0400
In-Reply-To: <20061004074535.GA7180@localhost.hsdv.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rmk@arm.linux.org.uk, gregkh@suse.de, ysato@users.sourceforge.jp

Ar Mer, 2006-10-04 am 16:45 +0900, ysgrifennodd Paul Mundt:
> This is intended purely for the simple NO_DMA ide_generic case.. nothing
> complicated.
> 
> What do people think about this, is there a better way to do this?

drivers/ide is going away over time. I think the concept is nice and
it's sort of reflected in the libata VLB drivers. I think it would be a
very good way to get good platform drivers for libata for the embedded
platforms.

Moving the existing drivers/ide stuff to a new drivers/ide variant is
wasted work however.


