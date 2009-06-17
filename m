From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.30-rc6: Problem with an SSD disk on Freescale PowerPC  mpc8315e-rdb, works fine on x86
Date: Wed, 17 Jun 2009 12:53:15 -0500
Message-ID: <71FC3E27-40A6-4212-A4BE-428732D6A624@kernel.crashing.org>
References: <c384c5ea0906080759n24a66d21ob9076518cec41755@mail.gmail.com> <c384c5ea0906170907u5a4af524m65e23b32446dd79f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38541 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbZFQRxU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Jun 2009 13:53:20 -0400
In-Reply-To: <c384c5ea0906170907u5a4af524m65e23b32446dd79f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, linux-ide@vger.kernel.org


On Jun 17, 2009, at 11:07 AM, Leon Woestenberg wrote:

> Hello Kumar, all,
>
> On Mon, Jun 8, 2009 at 4:59 PM, Leon
> Woestenberg<leon.woestenberg@gmail.com> wrote:
>> using 2.6.30-rc6, I get the following problems when I read from a SSD
>> disk, connected to the
>> 3.0 Gb SATA controller of the MPC8315E SoC rev 1.0 running Linux  
>> 2.6.30-rc6.
>>
> Result on a first batch of bisects. I decided to go with the kernel
> releases rather than git-bisect (still too scary for me).
>
> All kernel releases 2.6.25 through -30 kernel gave the same error.
> 2.6.25 crashed on it, whereas 2.6.26+ recovered after each "dd" run.
>
> The BSP 2.6.24.3-rt3 kernel did not give the error.
>
> So on my todo is diff between 2.6.25 and .2.6.24.3-rt3 from the BSP.

Does kernel.org 2.6.24 work ok?

- k
