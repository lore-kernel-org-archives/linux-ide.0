From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_nv times out for BD-ROM iHOS104-08
Date: Wed, 20 Jan 2010 11:13:08 +0900
Message-ID: <4B5666B4.6000804@kernel.org>
References: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu> 	<4B31C8EE.3030003@kernel.org> <d2d378040912232302u4b550dap687fcadced237935@mail.gmail.com> 	<4B331771.3090309@kernel.org> <d2d378041001161334r6fe3ee65w39cf98a6c2d1d399@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52732 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756102Ab0ATCHG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Jan 2010 21:07:06 -0500
In-Reply-To: <d2d378041001161334r6fe3ee65w39cf98a6c2d1d399@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?Q2VuZ2l6IEfDvG5heQ==?= <cgunay@emory.edu>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>

Hello, Cengiz.

On 01/17/2010 06:34 AM, Cengiz G=C3=BCnay wrote:
> 2009/12/24 Tejun Heo <tj@kernel.org>:
>> I don't think the controller has anything to do with the issue but
>> just in case can you please try it with a different controller?
>=20
> I tried the iHOS BD-ROM with a VIA VT6412 SATA controller today and i=
t worked:

Hmm.... it worked?  Does kernel parameter sata_nv.adma_enabled=3D0 make
any difference?  Can you please attach boot log with the kernel
parameter specified?

Thanks.

--=20
tejun
