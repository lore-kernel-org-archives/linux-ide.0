From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Date: Wed, 11 May 2016 12:01:44 +0100
Message-ID: <yw1xlh3ghn8n.fsf@unicorn.mansr.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
	<20160508200008.GM4775@htj.duckdns.org>
	<20160509010952.GN4775@htj.duckdns.org>
	<CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
	<yw1xmvnziofc.fsf@unicorn.mansr.com>
	<20160509190536.GK7110@mtj.duckdns.org>
	<CAHp75Vf6kivRBd+9nMUU-sLPrA3ctiwvXnqrAFHX3XJWPeNO1Q@mail.gmail.com>
	<20160510060440.GF2274@localhost>
	<20160510163022.GL7110@mtj.duckdns.org> <5732EA75.4070002@free.fr>
	<5732FE8E.9000605@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:33635 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbcEKLBu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2016 07:01:50 -0400
In-Reply-To: <5732FE8E.9000605@free.fr> (Mason's message of "Wed, 11 May 2016
	11:42:38 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sebastian Frias <sf84@laposte.net>, linux-ide@vger.kernel.org

Mason <slash.tmp@free.fr> writes:

> On 11/05/2016 10:16, Mason wrote:
>
>> On 10/05/2016 18:30, Tejun Heo wrote:
>>=20
>>> On Tue, May 10, 2016 at 11:34:40AM +0530, Vinod Koul wrote:
>>>
>>>> Please use branch topic/dw. I will not rebase this before sending =
to Linus.
>>>
>>> Okay, pulled topic/dw into libata/for-4.7-dw and applied 1-22 on to=
p.
>>> Please let me know how patch 23 should be routed.
>>=20
>> IIUC, this patch series will be available in 4.7-rc1 ?
>>=20
>> That's great news, because my platform uses the Synopsys IP with
>> a custom DMA engine. Thanks Mans and Andy for your work!
>
> I see the patches have landed in linux-next.
>
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/=
drivers/ata/sata_dwc_460ex.c
>
> Mans, did you intend to upstream your tangox-dma.c DMA driver?

Yes, that's the idea, though I haven't yet updated it to work with
tango4.  This SATA driver also needs a small addition to handle the DMA
glue.  Now that the dust has settled a bit around these fixes, I can ge=
t
back to that.

--=20
M=E5ns Rullg=E5rd
