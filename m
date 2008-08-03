From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Sun, 3 Aug 2008 14:05:36 +0100
Message-ID: <20080803140536.062c2ef1@lxorguk.ukuu.org.uk>
References: <87prp1kvyy.fsf@denkblock.local>
	<20080726062142.29070.10413.stgit@denkblock.local>
	<4892B8FE.1070400@gmail.com>
	<20080801233459.11e9b254@lxorguk.ukuu.org.uk>
	<489523DC.2090903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51108 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757434AbYHCNX1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 09:23:27 -0400
In-Reply-To: <489523DC.2090903@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Elias Oltmanns <eo@nebensachen.de>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Was that something intentional or was it a happy accident?  There can be
> bus ownership problem on PATA and on SATA this is much more state logic

IDLE IMMEDIATE is part of the "historic" specification rather than modern
ATA standards. Older drives support it happily newer ones tended to get
quite cross.

> on both sides of the cable and I think things like that would be more
> difficult to work accidentally.

We'd have to query the drive vendors to see what they expected.

