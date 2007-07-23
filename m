From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide patches
Date: Tue, 24 Jul 2007 08:08:14 +1000
Message-ID: <1185228494.5439.147.camel@localhost.localdomain>
References: <200707222019.03684.bzolnier@gmail.com>
	 <1185148506.5439.80.camel@localhost.localdomain>
	 <1185153674.5439.83.camel@localhost.localdomain>
	 <1185155835.5439.91.camel@localhost.localdomain>
	 <46A4AA39.3030401@ru.mvista.com>
	 <1185227295.5439.131.camel@localhost.localdomain>
	 <46A52652.2040509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54206 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbXGWWIX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jul 2007 18:08:23 -0400
In-Reply-To: <46A52652.2040509@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Tue, 2007-07-24 at 02:06 +0400, Sergei Shtylyov wrote:
> > Ugh ? It re-enables DMA in the sense that if called to configure a
> DMA
> > speed, it re-enables dma on the host, thus effectively leaving with
> DMA
> > enabled.
> 
>     No. DMA is still diabled for the IDE core at this point. You need
> a real 
> ide_dma_on() method call to do it. 

Ah right... even worse :-)

Ben.


