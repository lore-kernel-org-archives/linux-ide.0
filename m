From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Date: Wed, 11 May 2016 10:16:53 +0200
Message-ID: <5732EA75.4070002@free.fr>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
 <20160508200008.GM4775@htj.duckdns.org>
 <20160509010952.GN4775@htj.duckdns.org>
 <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
 <yw1xmvnziofc.fsf@unicorn.mansr.com> <20160509190536.GK7110@mtj.duckdns.org>
 <CAHp75Vf6kivRBd+9nMUU-sLPrA3ctiwvXnqrAFHX3XJWPeNO1Q@mail.gmail.com>
 <20160510060440.GF2274@localhost> <20160510163022.GL7110@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:9916 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbcEKIRL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 May 2016 04:17:11 -0400
In-Reply-To: <20160510163022.GL7110@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>, linux-ide@vger.kernel.org

On 10/05/2016 18:30, Tejun Heo wrote:

> On Tue, May 10, 2016 at 11:34:40AM +0530, Vinod Koul wrote:
> 
>> Please use branch topic/dw. I will not rebase this before sending to Linus.
> 
> Okay, pulled topic/dw into libata/for-4.7-dw and applied 1-22 on top.
> Please let me know how patch 23 should be routed.

Hello,

IIUC, this patch series will be available in 4.7-rc1 ?

That's great news, because my platform uses the Synopsys IP with
a custom DMA engine. Thanks Mans and Andy for your work!

Regards.
