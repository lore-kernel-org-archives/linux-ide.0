From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add DMA blacklist to libata
Date: Fri, 07 Jan 2005 01:55:06 +0000
Message-ID: <1105062573.17176.316.camel@localhost.localdomain>
References: <41DDE79F.8090601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:55743 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261194AbVAGC7a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jan 2005 21:59:30 -0500
In-Reply-To: <41DDE79F.8090601@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

On Gwe, 2005-01-07 at 01:36, Jeff Garzik wrote:
> For review.  I checked this into libata-dev just now.
> 
> Design decisions:
> * no whitelist.  Worst case is a few more devices will use PIO.
> * no firmware rev checking.  Worst case is a few more models (2) will 
> use PIO.

Seems reasonable for now although its so trivial to do. Expect the DMA
list for CD devices to shrink over time as well (Bart already zapped a
few).

Alan

