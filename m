From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6 fix queue] aec62xx: kill speedproc() method wrapper
Date: Wed, 16 May 2007 18:20:00 +0400
Message-ID: <464B1310.2080808@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com> <200705120122.34384.sshtylyov@ru.mvista.com> <200705152343.12956.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:16495 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754604AbXEPOS1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 May 2007 10:18:27 -0400
In-Reply-To: <200705152343.12956.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>There's no reason to have the speedproc() method wrapper for the two quite
>>different chip families, so just get rid of it.

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied

    I forgot to notice/mention the side effect: there would be no speedproc() 
method installed if hwif->dma_base happens to be 0.

MBR, Sergei
