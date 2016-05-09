From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Date: Mon, 9 May 2016 22:59:32 +0300
Message-ID: <CAHp75Vf6kivRBd+9nMUU-sLPrA3ctiwvXnqrAFHX3XJWPeNO1Q@mail.gmail.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
	<20160508200008.GM4775@htj.duckdns.org>
	<20160509010952.GN4775@htj.duckdns.org>
	<CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
	<yw1xmvnziofc.fsf@unicorn.mansr.com>
	<20160509190536.GK7110@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36237 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbcEIT7d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 May 2016 15:59:33 -0400
In-Reply-To: <20160509190536.GK7110@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Lamparter <chunkeey@googlemail.com>, Julian Margetson <runaway@candw.ms>, Vinod Koul <vinod.koul@intel.com>

On Mon, May 9, 2016 at 10:05 PM, Tejun Heo <tj@kernel.org> wrote:
> On Mon, May 09, 2016 at 10:13:59AM +0100, M=C3=A5ns Rullg=C3=A5rd wro=
te:
>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>
>> > On Mon, May 9, 2016 at 4:09 AM, Tejun Heo <tj@kernel.org> wrote:
>> >> On Sun, May 08, 2016 at 04:00:08PM -0400, Tejun Heo wrote:
>> >>> Hello, Andy.
>> >>>
>> >>> On Wed, May 04, 2016 at 03:22:51PM +0300, Andy Shevchenko wrote:
>> >>> > Tejun, since Vinod applied all necessary patches into his tree=
, the
>> >>> > series now has just a dependency to whatever branch / tag he m=
arks for
>> >>> > it.
>> >>> > Do we have a chance to see the SATA series be applied in your =
tree?
>> >>>
>> >>> Applied 1-22 to libata/for-4.7.  There was a couple trivial conf=
licts
>> >>> which I resolved while applying but it'd be great if you can che=
ck
>> >>> whether everything looks okay.
>> >>>
>> >>>  https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/=
?h=3Dfor-4.7
>> >>
>> >> Oops, build failure.  Reverted for now.
>> >
>> > I suppose you have to pull material from Vinod.
>>
>> The failure the build bot reported is due to the DMA patches not bei=
ng
>> in the tree.
>
> Which tree should I pull?

slave-dma [1], branch topic/dw. But I think Vinod can tell us which
tag/branch will be immutable. Vinod?

[1] http://git.infradead.org/users/vkoul/slave-dma.git

--=20
With Best Regards,
Andy Shevchenko
