From: Jeff Garzik <jeff@garzik.org>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Wed, 31 Oct 2007 08:20:06 -0400
Message-ID: <472872F6.70802@garzik.org>
References: <47274A5F.6070409@gentoo.org> <20071030153417.59b9182c@the-village.bc.nu> <47276DCA.1000808@gentoo.org> <20071030190153.373c9347@the-village.bc.nu> <47278439.4030801@gentoo.org> <20071031114958.210bd7cc@the-village.bc.nu> <20071031115754.GK5059@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54386 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235AbXJaMUS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Oct 2007 08:20:18 -0400
In-Reply-To: <20071031115754.GK5059@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Drake <dsd@gentoo.org>, linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Wed, Oct 31 2007, Alan Cox wrote:
>> On Tue, 30 Oct 2007 19:21:29 +0000
>> Daniel Drake <dsd@gentoo.org> wrote:
>>
>>> Alan Cox wrote:
>>>> I would guess Brasero is issuing a command with the length of data
>>>> wrongly set. In the old code that might well just produce errors of the
>>>> "Umm wtf is this data left over for ?", with the new code the drive is
>>>> likely to change state as it knows the transfer size and that will
>>>> *correctly* cause an HSM error and what follows.
>>>>
>>>> Now the question is who gets the length wrong - Brasero or the ata
>>>> translation code in libata
>>> Brasero does exactly the same as my test app which I attached to my last 
>>> mail. Is my test app wrong?
>> Would need to double check the SCSI specificatons to be sure but I think
>> you are asking for less data than the drive wishes to provide. You
>> aren't allowed to do that with ATA.
> 
> ide-cd handles this by throwing the excess away, which I think is the
> sane way to do this.

That's easy for the PIO case.  But CD writing is normally DMA, which 
means you will get a DMA engine exception if the device wants to give 
you more data than the scatter/gather entries permit.

	Jeff



