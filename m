From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Date: Mon, 09 May 2016 10:13:59 +0100
Message-ID: <yw1xmvnziofc.fsf@unicorn.mansr.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
	<20160508200008.GM4775@htj.duckdns.org>
	<20160509010952.GN4775@htj.duckdns.org>
	<CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:51083 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbcEIJOF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 May 2016 05:14:05 -0400
In-Reply-To: <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
	(Andy Shevchenko's message of "Mon, 9 May 2016 12:07:39 +0300")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Lamparter <chunkeey@googlemail.com>, Julian Margetson <runaway@candw.ms>, Vinod Koul <vinod.koul@intel.com>

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Mon, May 9, 2016 at 4:09 AM, Tejun Heo <tj@kernel.org> wrote:
>> On Sun, May 08, 2016 at 04:00:08PM -0400, Tejun Heo wrote:
>>> Hello, Andy.
>>>
>>> On Wed, May 04, 2016 at 03:22:51PM +0300, Andy Shevchenko wrote:
>>> > Tejun, since Vinod applied all necessary patches into his tree, t=
he
>>> > series now has just a dependency to whatever branch / tag he mark=
s for
>>> > it.
>>> > Do we have a chance to see the SATA series be applied in your tre=
e?
>>>
>>> Applied 1-22 to libata/for-4.7.  There was a couple trivial conflic=
ts
>>> which I resolved while applying but it'd be great if you can check
>>> whether everything looks okay.
>>>
>>>  https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=3D=
for-4.7
>>
>> Oops, build failure.  Reverted for now.
>
> I suppose you have to pull material from Vinod.

The failure the build bot reported is due to the DMA patches not being
in the tree.

--=20
M=E5ns Rullg=E5rd
