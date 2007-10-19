From: Martin Rogge <marogge@onlinehome.de>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Fri, 19 Oct 2007 21:58:03 +0200
Message-ID: <200710192158.03836.marogge@onlinehome.de>
References: <200710142211.03382.marogge@onlinehome.de> <200710172115.13068.marogge@onlinehome.de> <47167335.1020903@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57134 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935898AbXJST6H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 15:58:07 -0400
In-Reply-To: <47167335.1020903@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Wednesday 17 October 2007 22:40:21 Sergei Shtylyov wrote:
>     BTW, can you try adding #define DEBUG to the driver meanwhile?..

Yoda said: Try not. Do or do not. There is no try.

So I did it. To be precise, I #defined both DEBUG and CMD_DEBUG. However, I am 
not sure the result is conclusive.

On a good kernel I get a lot of lines of the type

hda: dma_stat: 0x24 irq_stat: 0x44 mask: 0x04
hdc: dma_stat: 0x24 irq_stat: 0x5c mask: 0x10

and variations thereof. On a broken kernel the middle part changes to

hda: dma_stat: 0x24 mrdmode: 0x00 mask: 0x04

Hope this is of any help,

cu Martin

