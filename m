From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_nv times out for BD-ROM iHOS104-08
Date: Sat, 23 Jan 2010 12:45:41 +0900
Message-ID: <4B5A70E5.6050106@kernel.org>
References: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu> 	<4B31C8EE.3030003@kernel.org> <d2d378040912232302u4b550dap687fcadced237935@mail.gmail.com> 	<4B331771.3090309@kernel.org> <d2d378041001161334r6fe3ee65w39cf98a6c2d1d399@mail.gmail.com> 	<4B5666B4.6000804@kernel.org> <51f3faa71001191859l3c323a8ev6b7c0cced2c59e92@mail.gmail.com> <d2d378041001220611ieb9d715of8d727f8f93ca9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48182 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab0AWIzN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jan 2010 03:55:13 -0500
In-Reply-To: <d2d378041001220611ieb9d715of8d727f8f93ca9f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Cengiz_G=FCnay?= <cgunay@emory.edu>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On 01/22/2010 11:11 PM, Cengiz G=FCnay wrote:
> On Tue, Jan 19, 2010 at 9:59 PM, Robert Hancock <hancockrwd@gmail.com=
> wrote:
>>>> 2009/12/24 Tejun Heo <tj@kernel.org>:
>>> Hmm.... it worked?  Does kernel parameter sata_nv.adma_enabled=3D0 =
make
>>> any difference?  Can you please attach boot log with the kernel
>>> parameter specified?
>>
>> Think you meant maybe sata_nv.swncq=3D0 instead - this is an MCP51
>> controller so it doesn't support ADMA. I don't imagine SWNCQ would
>> make any difference with an ATAPI device, but wouldn't hurt to try.
>=20
> Thanks for following this up. I tried both of your suggested kernel
> parameters (attached). Neither solved my problem, but also it looks
> like I couldn't turn off the SWNCQ mode. Even though I set it to zero=
,
> sata_nv still shows that it uses it. Although the order of my devices
> changed, so I assume it did something.

The parameter isn't being passed to the module loaded by initrd.  You
probably need to edit modules.conf and then regenerate initrd.  :-(

> I hope this helps shed some light! I will also try the kernel patch -=
-
> not sure if that is suited for the problem I'm having?

Yeah, I was about to suggest trying the patch.  It could be that the
timeout used by the new TUR code is too aggressive.

Thanks.

--=20
tejun
