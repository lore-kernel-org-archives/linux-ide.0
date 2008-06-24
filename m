From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Tue, 24 Jun 2008 16:19:27 +0200
Message-ID: <58cb370e0806240719o4a70537p4a6fb64e9086e2d8@mail.gmail.com>
References: <87k5gmz596.fsf@denkblock.local>
	 <200806240041.42796.bzolnier@gmail.com>
	 <87skv3s3d9.fsf@denkblock.local>
	 <200806241306.42054.bzolnier@gmail.com>
	 <20080624133218.6bccab75@lxorguk.ukuu.org.uk>
	 <58cb370e0806240621g61370f56j660e31790dad89c3@mail.gmail.com>
	 <20080624143548.24dcf511@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:18050 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbYFXOTa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 10:19:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1182286fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 24 Jun 2008 07:19:27 -0700 (PDT)
In-Reply-To: <20080624143548.24dcf511@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

On Tue, Jun 24, 2008 at 3:35 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> > I don't see why you think it's "hard". We have timeout handlers for many
>> > commands and those reset/abort just fine.
>>
>> They are different beasts from user-space initiated abort operation
>
> No they are not. They are the *same* thing in every respect.
>
> You have the drive in an unknown state, you want it back. If your drive
> lost a command due to noise or a firmware flaw you have no idea about the
> state it is actually in (supposed to be is irrelevant)

I generally agree with you w.r.t. to drive side of the operations but
the drive is only part of the equation (the host and the request states
are the others) so 'supposed to be is' is quite relevant.

Also abort request can happen i.e. while the command is being prepared
& issued (it is done without ide_lock being taken and the timeout is not
even armed yet) so there are additional issues to take care of.

IOW while the two operations are very similar on the drive level they
certainly have different needs and requirements at the higher level
(abort operation being especially tricky).

Thanks,
Bart
