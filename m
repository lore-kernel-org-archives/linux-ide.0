From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6.13-rc3] Mod15Write quirk against v2.6.13
Date: Mon, 22 Aug 2005 06:44:45 +0900
Message-ID: <4308F5CD.7060001@gmail.com>
References: <1121894035.4885.15.camel@drevil.aslab.com> <20050728141242.GA10010@htj.dyndns.org> <4308D3D0.50504@pobox.com> <4308E7F4.3000509@gmail.com> <4308EDB5.6060102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:51092 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751195AbVHUVov (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:44:51 -0400
Received: by zproxy.gmail.com with SMTP id r28so632975nza
        for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 14:44:51 -0700 (PDT)
In-Reply-To: <4308EDB5.6060102@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Michael Madore <Michael.Madore@aslab.com>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com


  Hello, Jeff.

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Jeff Garzik wrote:
>>
>>> Tejun Heo wrote:
>>>
>>>> Also, Jeff, I know you're very busy, but what do you think about
>>>> taking m15w workaround into ata tree?  It's been around for a while
>>>> now and I haven't received any complaints (except for this one) yet.
>>>> The workaround is ugly but it surely helps and I'm willing to maintain
>>>> it.
> 
> 
>>> I think your mod15write solution is too messy to deal with long-term. 
>>> Maintenance burden is much lower on us without it.  It's not too 
>>> difficult to simply avoid certain combinations of hardware.
> 
> 
>>  No problem, I'll maintain it out of tree.
> 
> 
> You're welcome to maintain it as an independent branch of 
> libata-dev.git, if you would prefer.
> 

  I think I'll just keep it out of tree.  I don't think many libata 
developers would be interested in m15w workaround.

> 
>>> Note!  As Carlos @ Silicon Image points out, the blacklist should 
>>> only apply to SiI 3112, not 3512/3114/etc.  That's an open FIXME that 
>>> would benefit users.
> 
> 
>>  Cool, I'll submit a patch right away.
> 

  Can you please tell me which are affected and which are not?

	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },

  Thanks.

-- 
tejun
