From: Mark Lord <liml@rtr.ca>
Subject: atapi_dmadir:  why do we not (also) auto-detect it from IDENTIFY
 PACKET ??
Date: Mon, 18 Feb 2008 14:02:36 -0500
Message-ID: <47B9D64C.3000705@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4364 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbYBRTCi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Feb 2008 14:02:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>

Albert / Jeff,

Way back in 2.6.17-rc2, you guys signed-off on 95de719adc94392a95c3c4d0a2d6b8b1ea39d236,
which added a libata module parameter for atapi_dmadir.

That's nice, but many modern drives (or bridge chips) flag this in
their IDENTIFY PACKET response, as bit-15 of word-62 of the returned data.

So for those at lease, we should be automatically setting atapi_dmadir=1.
But on a per-device basis, not globally as done now.

Albert: do you want to cook up a bug fix for this?

Cheers
