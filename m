From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/2] cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
Date: Fri, 31 Oct 2008 10:36:21 -0400
Message-ID: <490B17E5.1090109@rtr.ca>
References: <200810272058.54522.bzolnier@gmail.com> <200810300010.06303.bzolnier@gmail.com> <4908F240.2020606@ru.mvista.com> <200810300042.29405.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:49984 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbYJaOfs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Oct 2008 10:35:48 -0400
In-Reply-To: <200810300042.29405.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Thursday 30 October 2008, Sergei Shtylyov wrote:
>> Hello.
>>
>> Bartlomiej Zolnierkiewicz wrote:
.. 
>>    Ah, got it at last. But I doubt that 646 *really* needs serialization...
> 
> I remember getting bugreport which supposedly was fixed by commit
> deffca117b90dadec395c0cf3ee816de27dfe2fd (but it could also be that
> it was something else in reality or that it just hide some other
> bug that we fixed in the meantime).
> 
> We would need somebody with the hardware to verify it.
..

Apple B&W PowerMac G3 boxes originally shipped with CMD646 chips inside,
so if anyone has one of those, then it could be used for testing this.

The early CMD646 chips have issues with UDMA modes, but later ones work fine.
I really don't remember if the old CMD640 serialization issues persist
with the "newer" CMD646 chips, though.

Cheers
