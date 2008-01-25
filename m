From: Thomas Evans <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Fri, 25 Jan 2008 12:59:16 -0500
Message-ID: <479A2374.6080100@gmail.com>
References: <4794459C.3090200@gmail.com> <4796DC44.6010100@gmail.com>	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>	 <4797ECF3.5000306@gmail.com>	 <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>	 <4797F8D0.6060302@gmail.com>	 <864c1e490801231939k6008bc95tf40565a8ef6f430d@mail.gmail.com>	 <47980B71.3000408@gmail.com>	 <864c1e490801240707x31ff53b1s3d72032968e1bcbc@mail.gmail.com>	 <4798AA88.5080107@gmail.com> <864c1e490801240840q5423a1beuf9b4b3a43416db2b@mail.gmail.com> <4798C617.10601@gmail.com> <4798CA71.20707@gmail.com> <4798CC90.4040707@gmail.com> <4798CCDF.9070305@gmail.com> <4798CE10.2050005@gmail.com> <4798D4A2.7030303@gmail.com> <47991AD9.6050804@gmail.com> <47993686.5040405@gmail.com> <479939E3.4020307@gmail.com> <47997BD3.2060100@gmail.com> <479A1C48.1
 070209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:41485 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365AbYAYR7Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 12:59:24 -0500
Received: by wr-out-0506.google.com with SMTP id c49so476456wra.1
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2008 09:59:22 -0800 (PST)
In-Reply-To: <479A1C48.1070209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jay.Estabrook@hp.com

Saw something that caught my attention might be nothing ...

When initialized, the port address is a 64 bit address:
sil24_init_one init_one: port:FFFFFD00:09AA0000
sil24_init_one init_one: port:FFFFFD00:09AA2000
sil24_init_one init_one: port:FFFFFD00:09AA4000
sil24_init_one init_one: port:FFFFFD00:09AA6000

When the description from ata_port_pbar_desc comes out, it shows:
ata13: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
ata14: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
ata15: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
ata16: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31

I don't think the output is being truncated?

Is there some issue with the address?

...tom


Thomas Evans wrote:
> added some more printk's based on what I saw -
> maybe some issue with the dma port?
>
> ...tom
>
