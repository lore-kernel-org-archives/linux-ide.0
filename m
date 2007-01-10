From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hwif->rw_disk() method
Date: Wed, 10 Jan 2007 20:05:46 +0300
Message-ID: <45A51CEA.9040608@ru.mvista.com>
References: <45A514AB.2080605@ru.mvista.com> <20070110171015.5320fa17@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:14892 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S964967AbXAJRFp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jan 2007 12:05:45 -0500
In-Reply-To: <20070110171015.5320fa17@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

Hello.

Alan wrote:

>>    Alan/Bart/anybody, could you enlighten me why hwif->rw_disk() method came 
>>into being at all?

> When you needed to wrap entire disk operations. The ->dma_ methods only
> wrap DMA commands.

    Yeah, good point. But it's not likely that the HighPoint driver actually 
needs this wrapper for PIO or even MW DMA commands...

> For the current support hardware it can probably go, no idea if anyone
> embedded uses it any more and can't be bothered to check 8)

    Nobody does, as far I can see, except this wretched driver... :-)

MBR, Sergei
