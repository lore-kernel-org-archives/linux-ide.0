From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 5 Jan 2009 17:19:35 +0000
Message-ID: <20090105171935.4e0c077e@lxorguk.ukuu.org.uk>
References: <49615667.9020408@iwl.com>
	<200901051736.18026.bzolnier@gmail.com>
	<20090105165238.616e5186@lxorguk.ukuu.org.uk>
	<200901051815.24847.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33837 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751870AbZAERTo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 12:19:44 -0500
In-Reply-To: <200901051815.24847.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com, "Martin K. Petersen" <mkp@mkp.net>

> Both are done by block layer.  The former is controlled by the user-space
> while the latter is controlled by the block driver.

And in the old IDE case erroneously set for any device reporting CFA via
the kernel. Queue flag management belongs in user space because its far
more complex than you seem to think to get it right.

Alan
