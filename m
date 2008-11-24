From: "Dongjun Shin" <djshin90@gmail.com>
Subject: Re: about TRIM/DISCARD support and barriers
Date: Mon, 24 Nov 2008 14:40:29 +0900
Message-ID: <7fe698080811232140ie896cc8m735a25261f447c47@mail.gmail.com>
References: <4928E010.4090801@kernel.org> <4929023C.2060302@suse.de>
	 <49290CEB.7070509@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:5787 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYKXFka (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 00:40:30 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1894923rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 23 Nov 2008 21:40:29 -0800 (PST)
In-Reply-To: <49290CEB.7070509@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <teheo@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dwmw2@infradead.org, Nick Piggin <npiggin@suse.de>, Jens Axboe <jens.axboe@oracle.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, chris.mason@oracle.com, Matthew Wilcox <matthew@wil.cx>

On Sun, Nov 23, 2008 at 4:57 PM, Tejun Heo <teheo@suse.de> wrote:
> Tejun Heo wrote:
>> Dongjun, the only doc I can find about ATA TRIM is the following one.
>>
>>  http://t13.org/Documents/UploadedDocuments/docs2007/e07154r3-Data_Set_Management_Proposal_for_ATA-ACS2.pdf
>>
>> And AFAICS this hasn't made into ACS yet.  Is this what you guys are
>> gonna implement and Windows7 is gonna use?
>

Sorry, I thought the trim spec has got into the final ACS, but it's not yet.
Microsoft can collaborate with SSD vendors for their internal evaluation &
feedback for Win7(with NDA between them, of course).

> Just went over it.  Matthew, if ATA trim is gonna be implemented as
> described in the above document, it will support multiple ranges per
> command.
>
> Dongjun, the above document strikes out all the latency/performance
> related stuff, which looks like the right move to me.  Most of those
> information can be extracted from access pattern by the device itself
> and exposing such optimization parameters to outside seldom works well.
>  I'm fairly sure such over complexity will end up being
> counter-optimization due to different interpretations and executions by
> different parties (be it harddrive vendors or different filesystems).
>
> So, can you please confirm that, what we eventually get is simple TRIM
> w/ multiple ranges?  Which, BTW, makes sense as it's something the
> device can't infer from the access pattern.  Also, if there still is
> wiggle room, what would be a worthy optimization is to allow TRIM
> commands to be sent together with other NCQ commands as otherwise the
> drive will have to drain all other commands to process a TRIM command
> which will be inefficient.
>

AFAIK, only the trim feature of data set management command will be included
and a single trim may contain multiple ranges. But, it's not possible to send
non-read/write command during NCQ as specified by the t13(1).

-- 
Dongjun

(1) In 4.15 of ATA8-ACS,
"If the device receives a command that is not an NCQ command while NCQ commands
are in the queue, then the device shall return command aborted for the
new command
and for all of the NCQ commands that are in thequeue."
