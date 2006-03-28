From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Tue, 28 Mar 2006 20:26:46 +0100
Message-ID: <1143574006.17522.31.camel@localhost.localdomain>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net>
	 <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>
	 <4427C467.5030300@ru.mvista.com> <4427CE99.6000004@ru.mvista.com>
	 <44293628.3030103@ru.mvista.com>
	 <58cb370e0603280611l78e5742fs44f761ecba485696@mail.gmail.com>
	 <4429463F.8060604@ru.mvista.com>  <4429629C.6060505@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:32919 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751219AbWC1TTi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Mar 2006 14:19:38 -0500
In-Reply-To: <4429629C.6060505@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Maw, 2006-03-28 at 20:21 +0400, Sergei Shtylylov wrote:
>     OTOH, it's handy in ide-dma.c itself. And hwif->extra_base is surely more 
> efficient than pci_resource_start(hwif->dev, 4).

Its just more memory use so I doubt it. pci_resource_foo is just
derefencing internal structures not going to the bus.

