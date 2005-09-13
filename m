From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] fix kernel oops, when IDE-Device (CF-Card) is removed while mounted.
Date: Tue, 13 Sep 2005 10:36:42 +0200
Message-ID: <58cb370e050913013677fec525@mail.gmail.com>
References: <431DE5E8.8000703@maintech.de>
	 <58cb370e05091207435b91206f@mail.gmail.com>
	 <4325C448.6000303@maintech.de>
Reply-To: bzolnier@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.197]:47824 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751145AbVIMIgp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Sep 2005 04:36:45 -0400
Received: by nproxy.gmail.com with SMTP id x37so914492nfc
        for <linux-ide@vger.kernel.org>; Tue, 13 Sep 2005 01:36:42 -0700 (PDT)
In-Reply-To: <4325C448.6000303@maintech.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Kleffel <tk@maintech.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 9/12/05, Thomas Kleffel <tk@maintech.de> wrote:
> Hi,
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >> [...]
> >>1b) When a disk is released by disk_release(), its queue's reference
> >>count shall be decremented by calling blk_cleanup_queue().
> >
> >
> > Which conflicts with IDE layer reference counting  & locking scheme
> > as IDE layer can send (special) requests to the device without any
> > device driver loaded.
> 
> But the IDE layer won't do that anymore after ide_unregister() was
> called, while a device driver doesn't know that the device doesn't exist
> anymore, so it may still access the queue until it releases the disk.

The point is that you have added blk_cleanup_queue() to the ide-disk
driver release function and it is perfectly fine for IDE layer to send requests
after unloading ide-disk driver.

> >>2a) When a physical drive is released by drive_release_dev(), the
> >>corresponding queue is marked dead, so that no further calls to the
> >>physical device's queue-handler are made.
> >>
> >>2b) When a request is submitted to a dead queue using
> >>generic_make_request(), the request shall be failed immedaiately with
> >>-ENXIO which causes the caller to recive a "Bus error". This is the same
> >>beaviour as when a USB-Storage device gets pulled while in use.
> >
> >
> > The fix would be to fail the previous requests during removal of the
> > device [ somebody already posted a patch to do that but I didn't have
> > time to give it proper thought ] or alternatively to add the offline state to
> > the device [ so processing of the requests would be resumed after device
> > is online again ].
> 
> I don't think it'd be wise to resume request processing on the same
> device as the CF Card inserted again might not be the same one as the
> user pulled out before. Performing old, cached writes on the new card
> could destroy innocent data.

Yes, that is why failing old requests is a preferred solution.

>  From your responses I read that the correct solution would be to keep
> the old pysical device as long as the ide layer still has references to
> it and to fail all requests in the meantime.
> 
> Is that correct?

Yes, we should just fail all the requests if the device is not present.
[ What do you mean by the old physical device, old 'ide_drive_t *'? ]

Regards,
Bartlomiej

> Best regards,
> 
> Thomas
> 
> 
> 
>
