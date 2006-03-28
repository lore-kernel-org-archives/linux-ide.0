From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Tue, 28 Mar 2006 17:12:08 +0400
Message-ID: <44293628.3030103@ru.mvista.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net> <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com> <4427C467.5030300@ru.mvista.com> <4427CE99.6000004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:19104 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751138AbWC1NOG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Mar 2006 08:14:06 -0500
In-Reply-To: <4427CE99.6000004@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Hello.

Sergei Shtylylov wrote:

>> Bartlomiej Zolnierkiewicz wrote:

[skipped]

>>>> - release the channel's secondary DMA I/O ports for real

>>> NAK, looking and the code - secondary DMA base is only used
>>> by siimage.c and sgiioc4.c (both use ->mmio == 2, for siimage 
>>> ->dma_base2
>>> is unused, for sgiioc4 it is used for some weird DMA transfer ending 
>>> stuff)

    Hm, concerning the other field of ide_hwif_t, dma_master: I currently see 
no users to it but pdc202xx_old.c. The way it's computed makes it dependent on 
what channels are enabled (though all channels are forced present in that 
driver by the most recent patch) which makes it invalid if the primary channel 
happens to be disabled. I'd like to replace it with extra_base fields which 
would point to the extra DMA ports regardless of the channels present/enabled, 
is this OK?

WBR, Sergei

