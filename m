From: Tejun Heo <htejun@gmail.com>
Subject: Re: FW: Kernel driver for Sil 3112 (sata_sil.c) problems
Date: Wed, 08 Mar 2006 10:59:00 +0900
Message-ID: <440E3A64.9090303@gmail.com>
References: <20060307140437.C18DB37B09@relay.netbox.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:34767 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964873AbWCHB7P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2006 20:59:15 -0500
Received: by pproxy.gmail.com with SMTP id i75so1122719pye
        for <linux-ide@vger.kernel.org>; Tue, 07 Mar 2006 17:59:14 -0800 (PST)
In-Reply-To: <20060307140437.C18DB37B09@relay.netbox.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kacer <kacerxy@seznam.cz>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

kacer wrote:
>  Hi Tejun, have you received my email? Any suggestion? Are you working on
> it?
> 

Hello, Kacer.

Yeap, I did received your message and forgot to reply. :-p Anyways, 
currently there isn't any sil3112 errata applicable to your case. 
Hardware problem (cabling, power fluctation, whatever) is also a 
possibility.

The problem is that currently libata EH doesn't do whole lot of recovery 
actions. libata is likely to fail to recover device after a transitional 
transmission error. EH work is in progress and hopefully it will see the 
light of day soon.

One way to confirm that your machine is experiencing transitional 
transmission errors is to test your drive under Windows. Put drives 
under heavy IO in Windows and watch the transfer rate (Windows has 
system monitoring utility which shows disk activities as graph. I don't 
remember what it was though.) and if your machine suffers the same 
problem under Windows driver, it will show occasional drops (transfer 
rate stalls to zero for quite some seconds) when such problems occur.

Hope it helped.

-- 
tejun
