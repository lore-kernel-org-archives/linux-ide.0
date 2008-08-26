From: "Gwendal Grignou" <gwendal@google.com>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 10:25:13 -0700
Message-ID: <e7510f760808261025j189f6436ra2ec044256549cde@mail.gmail.com>
References: <20080826072841.GS20055@kernel.dk>
	 <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk>
	 <20080826101713.GW20055@kernel.dk> <48B3DE5B.1020607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:56021 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbYHZRZY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 13:25:24 -0400
Received: from spaceape8.eur.corp.google.com (spaceape8.eur.corp.google.com [172.28.16.142])
	by smtp-out3.google.com with ESMTP id m7QHPFP4024077
	for <linux-ide@vger.kernel.org>; Tue, 26 Aug 2008 18:25:15 +0100
Received: from py-out-1112.google.com (pyia25.prod.google.com [10.34.253.25])
	by spaceape8.eur.corp.google.com with ESMTP id m7QHPD0M013784
	for <linux-ide@vger.kernel.org>; Tue, 26 Aug 2008 10:25:14 -0700
Received: by py-out-1112.google.com with SMTP id a25so1442903pyi.3
        for <linux-ide@vger.kernel.org>; Tue, 26 Aug 2008 10:25:13 -0700 (PDT)
In-Reply-To: <48B3DE5B.1020607@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Kay Sievers <kay.sievers@vrfy.org>

The current patch  to implement libata-sysfs floating in the mailing
list is read-only.
For write we must currently go through SCSI midlayer ioctls and use
sat. To send commands directly within libata[-sysfs] - for instance
writing SControl register of a SATA PM - I need to either implement a
queue mechanism over ata_exec_internal() or schedule eh and piggy back
on it.

Once implemented, we could definitely use it in conjunction with udev
to tune ATA devices.

Gwendal.

On Tue, Aug 26, 2008 at 3:43 AM, Tejun Heo <tj@kernel.org> wrote:
> (cc'ing Mark Lord, Kay Sievers and Gwendal Grignou)
>
> Jens Axboe wrote:
>>> d) Assume the bridge is ok but teach the SATA error handling code that if
>>> there is a timeout immediately with such a bridge then to flip down to
>>> UDMA5 and knobble the transfer length.
>>
>> That would be nice, assuming that we can rely on safe behaviour (eg not
>> data corrupting badness).
>
> Obstacles to such approaches are...
>
> * The current IO timeouts are too long.  It's not like reducing this is
> difficult.  The only reason why we haven't reduced it yet is because we
> haven't been able to agree on what's the proper timeout value.
> According to Mark, 8 secs should be fine (Windows uses it) for
> read/writes but there seem to be some corner cases.
>
> * Some rare controllers fail miserably after a timeout but this is
> pretty rare and getting rarer.  I don't think we need to consider this
> the main deciding factor.
>
> * Currently, the transfer speed setting reached by EH actions is not
> persistent.  On the next boot, the device would have to go through the
> same thing all over again, which isn't too pleasant.  It would be great
> if we can make this setting persistent.  Maybe this can be done libata
> sysfs and udev?
>
> Thanks.
>
> --
> tejun
>
