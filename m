From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Regression] 2.6.25-rc4-git3: Handling of audio CDs broken on
 pata_ali
Date: Tue, 11 Mar 2008 11:31:50 +0900
Message-ID: <47D5EF16.8080509@gmail.com>
References: <200803082246.47987.rjw@sisk.pl> <47D4E78A.10507@gmail.com> <47D523A1.7070808@gmail.com> <200803102236.30790.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:57954 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbYCKCcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 22:32:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2586535wah.23
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 19:32:05 -0700 (PDT)
In-Reply-To: <200803102236.30790.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Rafael J. Wysocki wrote:
> On Monday, 10 of March 2008, Tejun Heo wrote:
>> Tejun Heo wrote:
>>> Tejun Heo wrote:
>>>> Rafael J. Wysocki wrote:
>>>>>>> where ata1 is:
>>>>>>>
>>>>>>> scsi0 : pata_ali
>>>>>>> scsi1 : pata_ali
>>>>>> Oh, is it only with audio CDs? I am unable to use DVD on pata_ali in DMA at
>>>>>> all. Have you tried to disable ATAPI DMA (libata.dma=1)?
>>>>> Data CDs seem to work fine here.
>>>> * Does booting into runlevel 1, putting in an audio cd and running
>>>> cdparanoia give the same result?
>>>>
>>>> * Does setting module parameter libata.force to "1.00:pio4" make any
>>>> difference?
>>> Oh, never mind.  I have a hunch.  I'll report back in a while.
>>>
>> Does the attached patch fix the problem?
> 
> Yes, it does.  Please push upstream.

Thanks for testing.  Will do.


-- 
tejun
