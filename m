From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Fri, 18 Jan 2008 21:03:41 +0300
Message-ID: <4790E9FD.8060506@ru.mvista.com>
References: <200801172150.57059.asalnikov@ru.mvista.com>	<20080117232303.3f34c87a@lxorguk.ukuu.org.uk>	<4790B459.3000407@ru.mvista.com> <20080118150402.16a3a387@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:8428 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752292AbYARSCu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Jan 2008 13:02:50 -0500
In-Reply-To: <20080118150402.16a3a387@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Anton Salnikov <asalnikov@ru.mvista.com>, linux-ide@vger.kernel.org, bzolnier@gmail.com

Alan Cox wrote:

>>    It won't -- we can *not* call ide_setup_dma() which fills them out as this 
>>is not a PCI chip.

> Gak.

    Or maybe we still can -- with hwif->mmio set?
    AFAIR (from the 2006 discussion) Bart said it's *only* for PCI devices...

> Alan

MBR, Sergei
