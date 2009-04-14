From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_hpt37x: fix HPT370 DMA timeouts
Date: Tue, 14 Apr 2009 20:45:50 +0400
Message-ID: <49E4BDBE.7070903@ru.mvista.com>
References: <200904141839.14755.sshtylyov@ru.mvista.com> <20090414173507.136ac439@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:51294 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755196AbZDNQpF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Apr 2009 12:45:05 -0400
In-Reply-To: <20090414173507.136ac439@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

Alan Cox wrote:


>>The libata driver has copied the code from the IDE driver which caused a post
>>2.4.18 regression on many HPT370[A] chips -- DMA stopped to work completely,
>>only causing timeouts.  Now remove hpt370_bmdma_start() for good...

> Do we need to move it rather than remove it though. I need to look at
> that a bit with my HPT370 and see what happens. I suspect that if we get
> a failed transfer we need to do the reset somewhere -

    Well, the driver does the reset in hpt370_bmdma_stop(), and even twice.

> perhaps qc_issue before anything hits the chip for the command ?

    No idea. I think it's just not needed.

MBR, Sergei
