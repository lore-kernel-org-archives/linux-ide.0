From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Tue, 22 Jan 2008 01:39:28 +0000
Message-ID: <20080122013928.554b52f8@lxorguk.ukuu.org.uk>
References: <200801140019.20668.g.chulkov@jacobs-university.de>
	<20080121164744.2f7d0ed1@lxorguk.ukuu.org.uk>
	<4794D020.4060204@gmail.com>
	<200801220231.22609.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33247 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752384AbYAVBnD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 20:43:03 -0500
In-Reply-To: <200801220231.22609.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

> Could you point me to some bugreports?
> 
> I would like to know more about hosts/conditions for which it happens.

The timer reset path races the I/O path races the interrupt path. That
was the vomitously foul race that persuaded me to go libata instead. I
seem to remember explaining this all some time ago.

The root cause is that we drop the lock on some error paths.
Unfortunately its almost impossible to fix that without having an
infrastructure for quiescing the driver and running a separate error
handling context (the way scsi does).

