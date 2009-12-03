From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 03 Dec 2009 16:51:09 -0500
Message-ID: <4B1832CD.5040809@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200912032045.48728.bzolnier@gmail.com> <4B182A9F.5090708@garzik.org> <200912032242.05785.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:57990 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZLCVvE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 16:51:04 -0500
In-Reply-To: <200912032242.05785.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/03/2009 04:42 PM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 03 December 2009 10:16:15 pm Jeff Garzik wrote:
>
>>>         pata_efar: MWDMA0 is unsupported
>>
>> skipped, pending discussion (just sent email)
>
> The discussion was there, you were not especially interested
> (http://lkml.org/lkml/2009/11/26/343).

I reviewed the discussion before adding an email to that thread.


>>>         pata_hpt3x2n: fix overclocked MWDMA0 timing
>>
>> skipped, pending discussion (just sent email)
>
> ditto (http://lkml.org/lkml/2009/11/27/257).

I reviewed the discussion before adding an email to that thread.


> There were no complains so I'm pretty sure Sergei was fine with it.

It was unclear, hence I sent email for clarification.


>>>         pata_hpt3x3: Power Management fix
>>
>> applied, on a hope and a prayer (did not see this posted to mailing
>> list?).  It looks correct to me.
>
> I prefer sticking to technical facts. ;)
>
> Patch was posted to both mailing lists: http://lkml.org/lkml/2009/11/25/321

Whoops, I indeed missed this one.


>>>         pata_via: clear UDMA transfer mode bit for PIO and MWDMA
>>
>> applied -- even though Alan's comment was correct.  It is standard
>> kernel practice to place cosmetic changes into their own patches,
>> because it is standard kernel practice to break up logically distinct
>> changes.
>
> We are talking about:
>
>   pata_via.c |   19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> patch here (http://lkml.org/lkml/2009/11/25/380) and cosmetic change
> is clearly documented in the patch description.
>
>
> Do people really wonder why I find upstream to be too much hassle to
> deal with?

The thousand other kernel developers seem to be able to split up their 
patches, separating out cosmetic changes from functional ones.  It has 
clear engineering benefits, and has been standard practice for a decade 
or more.

Why is it such an imposition for your patches to look like everyone 
else's?  And by "everyone", I mean all other kernel developers, not just 
other ATA developers.

You seem to consider standard kernel practice a hassle.  Separating out 
cosmetic changes is not only a libata practice, it is the norm for the 
entire kernel.

	Jeff


