From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA port multiplier(Marvell 6121 with ahci) and Marvell 4140,
 simg 3726
Date: Sun, 03 Aug 2008 14:08:18 +0900
Message-ID: <48953D42.1010408@kernel.org>
References: <788014650807302022j30cea641wcfe4105ac8702b8c@mail.gmail.com>	 <48918D52.3010404@gmail.com> <48918DD9.9050603@kernel.org>	 <788014650807310612x70347f8dt56ed650dc6b8c5ca@mail.gmail.com>	 <48926F7E.1020807@kernel.org> <48930B2E.9060604@pobox.com>	 <489336E0.7020409@kernel.org> <788014650808021053y5b5a8e01y62099464cc96d8a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36610 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbYHCFI7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 01:08:59 -0400
In-Reply-To: <788014650808021053y5b5a8e01y62099464cc96d8a4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khchen@synology.com
Cc: jgarzik@pobox.com, Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org

KueiHuan Chen wrote:
> 2008/8/2 Tejun Heo <tj@kernel.org>:
>> Mark Lord wrote:
>>> I have exactly zero documentation on those chips,
>>> but they are supposedly AHCI compliant.
>>>
>>> Looking in drivers/ata/ahci.c, one can see that the chips are indeed
>>> supported,
>>> and there the AHCI_HFLAG_NO_PMP is *not* set, so one might expect them
>>> to work
>>> with a port-multiplier already.  ?
>> I bet it's more like nobody tried yet.  :-P
> 
> 
>  Thanks for your explaining, i had tried it already.
> 
>  Port multiplier of Silicon image 3726 is not supported from 2.6.24 to
> 2.6.26 with 6121 and 6145 which using ahci.c  : (
> 
>  Here is the test envirement:
> 
>   Port Multipiler : Silicon image 3726. (Marvell 4140 is not fully
> tested, so i don't listed, but it is the same in arm arch.)
> 
>  arch/kernel   2.6.24        2.6.25       2.6.26
> 
>   arm            Not Work   Not tested   Not tested
> 
>   powerpc     Not Work   Not tested   Not tested
> 
>   x86_64       Not Work   Not Work     Not Work
> 
> 
>  Should we need disable 6121/6145 pmp support in ahci.c until it is
> fully supported?

I'd like to find out why it's failing before disabling it.  Can you
please post the failing log from 2.6.26?

-- 
tejun
