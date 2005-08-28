From: Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: PATCH: ide: ide-disk freeze support for hdaps
Date: Sun, 28 Aug 2005 01:30:12 -0400
Message-ID: <253818670508272230540fa9dd@mail.gmail.com>
References: <253818670508250708a9075a0@mail.gmail.com>
	 <58cb370e0508250859701ea571@mail.gmail.com>
	 <253818670508252204b22e8c2@mail.gmail.com>
	 <20050826065515.GQ4018@suse.de>
	 <20050827123408.GD1109@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.198]:5658 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751110AbVH1FaN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Aug 2005 01:30:13 -0400
Received: by rproxy.gmail.com with SMTP id a41so895377rng
        for <linux-ide@vger.kernel.org>; Sat, 27 Aug 2005 22:30:13 -0700 (PDT)
In-Reply-To: <20050827123408.GD1109@openzaurus.ucw.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Jens Axboe <axboe@suse.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jon Escombe <lists@dresco.co.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alejandro Bonilla Beeche <abonilla@linuxwireless.org>, linux-kernel <linux-kernel@vger.kernel.org>, hdaps devel <hdaps-devel@lists.sourceforge.net>, linux-ide@vger.kernel.org

Hi Pavel,

On 8/27/05, Pavel Machek <pavel@suse.cz> wrote: 
> Well, with my power-managment hat on:
> 
> we probably want "freeze" functionality to be generic; it makes sense
> for other devices, too.
> 
> "My battery is so low I can not use wifi any more" => userspace
> freezes wifi.
> 
> Now, having this kind of timeout in all the cases looks pretty ugly to my eyes.

Thing is the freeze attribute hasn't got much to do with power
management, this is just to freeze the queue, and park the drive head
ASAP (preferably with the unload immediate command supported by new
drives) in order to protect the drive in an impact. Unload immediate
doesn't even stop spinning the drive, so little power is saved.

Maybe a suspend attribute would be a good idea for something along the
lines of what you have in mind? A enable/disable attribute would
definitely make sense for that application.

I suppose renaming the attribute to "ramming_speed" or
"brace_for_impact", might make the purpose more clear ;).

Thanks,
Yani
