From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Mon, 27 Mar 2006 16:21:51 +0400
Message-ID: <4427D8DF.5000905@ru.mvista.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net>	 <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>	 <4427C467.5030300@ru.mvista.com> <58cb370e0603270407v3329fa74n8148638a331b8419@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:36230 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750954AbWC0MXi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Mar 2006 07:23:38 -0500
In-Reply-To: <58cb370e0603270407v3329fa74n8148638a331b8419@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> On 3/27/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:

[skipped]

>>>please fix siimage.c and core code instead
>>>(please see libata-core.c and ata_host_stop() etc.)

>>>>- release the same number of DMA I/O ports that was requested by a driver

>>>please fix trm290.c to use ->mmio == 2 instead

>>    It's a _really_ old chipset (pre SFF-8038i) and has _no_ memory mapped
>>regs AFAIK...

> ->mmio == 2 means _only_ that host driver is responsible
> for reserving/releasing resources - it doesn't mean that host driver
> is using MMIO (a bit confusing but this is what the current code does)

    So, your point is that ide_setup_dma() should _never_ do anything for the 
(mmio == 2) case? Maybe it shouldn't even be called? I guess we surely need 
some driver cleanup hook to call ftom ide_release_dma()...

[skipped]

> Thanks,
> Bartlomiej

WBR, Sergei
