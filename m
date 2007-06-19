From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [BUG] ide dma_timer_expiry, then hard lockup
Date: Tue, 19 Jun 2007 18:10:04 +0400
Message-ID: <4677E3BC.3040307@ru.mvista.com>
References: <20070618175713.GD5836@austin.ibm.com>	<20070618212704.394912b8@the-village.bc.nu>	<20070618204601.GF5836@austin.ibm.com> <20070618220441.3a3af8ca@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37645 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751267AbXFSOIV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Jun 2007 10:08:21 -0400
In-Reply-To: <20070618220441.3a3af8ca@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linas Vepstas <linas@austin.ibm.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
>>I can prepare a patch, but only with a lot of guidance. I can test 
>>& debug, I'm highly motivated just right now ... 

> If you've got a nice repeatable problem please try using the libata
> driver. That handles the error paths differently and doesn't try a FIFO
> drain which might matter in this case I guess.

    FIFO drain for DMA commands?

MBR, Sergei
