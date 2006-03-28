From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Tue, 28 Mar 2006 23:19:49 +0400
Message-ID: <44298C55.7030504@ru.mvista.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net>	 <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>	 <4427C467.5030300@ru.mvista.com> <4427CE99.6000004@ru.mvista.com>	 <44293628.3030103@ru.mvista.com>	 <58cb370e0603280611l78e5742fs44f761ecba485696@mail.gmail.com>	 <4429463F.8060604@ru.mvista.com>  <4429629C.6060505@ru.mvista.com> <1143574006.17522.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:31138 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751275AbWC1TVh
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Mar 2006 14:21:37 -0500
In-Reply-To: <1143574006.17522.31.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

>>    OTOH, it's handy in ide-dma.c itself. And hwif->extra_base is surely more 
>>efficient than pci_resource_start(hwif->dev, 4).
> 
> 
> Its just more memory use so I doubt it.

    dma_master and dma_base2 fields are taking up the memory anyway. I'm going 
to remove them both.

> pci_resource_foo is just
> derefencing internal structures not going to the bus.

    Note the double dereference vs single one.

WBR, Sergei
