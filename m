From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_nv times out for BD-ROM iHOS104-08
Date: Thu, 24 Dec 2009 16:25:37 +0900
Message-ID: <4B331771.3090309@kernel.org>
References: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu> 	<4B31C8EE.3030003@kernel.org> <d2d378040912232302u4b550dap687fcadced237935@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59539 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504AbZLXHWF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Dec 2009 02:22:05 -0500
In-Reply-To: <d2d378040912232302u4b550dap687fcadced237935@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?Q2VuZ2l6IEfDvG5heQ==?= <cgunay@emory.edu>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 12/24/2009 04:02 PM, Cengiz G=C3=BCnay wrote:
>=20
> On Wed, Dec 23, 2009 at 2:38 AM, Tejun Heo <tj@kernel.org
> <mailto:tj@kernel.org>> wrote:
>=20
>     Can you please try kernel parameter irqpoll?  Also, does having a
>     readable media in the drive during boot make any difference?
>=20
>=20
> Sorry, neither made any difference.
>=20
> By the way, kernel 2.6.23.9 goes into an infinite loop at bootup with
> ata3 exception messages. I can write them down if it would help.

Hmmm... can you please take a photo?  I don't think the controller has
anything to do with the issue but just in case can you please try it
with a different controller?

Thanks.

--=20
tejun
