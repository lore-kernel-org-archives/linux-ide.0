From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 03 Dec 2009 17:10:51 -0500
Message-ID: <4B18376B.3080404@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200912032256.39790.bzolnier@gmail.com> <4B18357C.8070807@garzik.org> <200912032306.52022.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:56765 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZLCWKq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 17:10:46 -0500
In-Reply-To: <200912032306.52022.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/03/2009 05:06 PM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 03 December 2009 11:02:36 pm Jeff Garzik wrote:
>> On 12/03/2009 04:56 PM, Bartlomiej Zolnierkiewicz wrote:
>>> On Thursday 03 December 2009 10:51:09 pm Jeff Garzik wrote:
>>>
>>>>>>>           pata_via: clear UDMA transfer mode bit for PIO and MWDMA
>>>>>>
>>>>>> applied -- even though Alan's comment was correct.  It is standard
>>>>>> kernel practice to place cosmetic changes into their own patches,
>>>>>> because it is standard kernel practice to break up logically distinct
>>>>>> changes.
>>>>>
>>>>> We are talking about:
>>>>>
>>>>>     pata_via.c |   19 +++++++++++++------
>>>>>     1 file changed, 13 insertions(+), 6 deletions(-)
>>>>>
>>>>> patch here (http://lkml.org/lkml/2009/11/25/380) and cosmetic change
>>>>> is clearly documented in the patch description.
>>>>>
>>>>>
>>>>> Do people really wonder why I find upstream to be too much hassle to
>>>>> deal with?
>>>>
>>>> The thousand other kernel developers seem to be able to split up their
>>>> patches, separating out cosmetic changes from functional ones.  It has
>>>> clear engineering benefits, and has been standard practice for a decade
>>>> or more.
>>>>
>>>> Why is it such an imposition for your patches to look like everyone
>>>> else's?  And by "everyone", I mean all other kernel developers, not just
>>>> other ATA developers.
>>>>
>>>> You seem to consider standard kernel practice a hassle.  Separating out
>>>> cosmetic changes is not only a libata practice, it is the norm for the
>>>> entire kernel.
>>>
>>> Indeed.
>>>
>>>   From 94be9a58d7e683ac3c1df1858a17f09ebade8da0 Mon Sep 17 00:00:00 2001
>>> From: Jeff Garzik<jeff@garzik.org>
>>> Date: Fri, 16 Jan 2009 10:17:09 -0500
>>> Subject: [PATCH] [libata] get-identity ioctl: Fix use of invalid memory pointer
>>>    for SAS drivers.
>>>
>>> Caught by Ke Wei (and team?) at Marvell.
>>>
>>> Also, move the ata_scsi_ioctl export to libata-scsi.c, as that seems to be the
>>> general trend.
>>>
>>> Acked-by: James Bottomley<James.Bottomley@HansenPartnership.com>
>>> Signed-off-by: Jeff Garzik<jgarzik@redhat.com>
>>
>> If your point, by posting this patch, is that it includes a ton of
>> gratuitous cosmetic changes, you misread the patch.
>>
>> ata_scsi_ioctl() remains in existence; only the callers need to use the
>> new SAS-related ioctl function were updated.  The remainder continued to
>> use ata_scsi_ioctl().
>
> Moving kernel exports around is completely unrelated to a bug fix.

Did the patch contain -cosmetic- changes intermingled with code changes, 
in the same code lines?  No.

Is it good kernel practice to intermingle cosmetic changes with 
functional ones, in the same code lines?  Also, no.

	Jeff



