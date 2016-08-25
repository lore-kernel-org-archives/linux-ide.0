From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 3/4 RESEND] SCT Write Same / DSM Trim
Date: Thu, 25 Aug 2016 17:30:04 +0800
Message-ID: <CAGnHSEmsYSo6prXSoaiVSshAA0ma6+NcDo9CmsEeBqdSTJisaw@mail.gmail.com>
References: <0c9c5a80-813b-31f0-355d-2e08e452dd01@suse.de> <20160824180814.24708-1-shaun@tancheff.com>
 <CAGnHSEmVbpaE6pr2JX=bAH0wpz6U7xnT--2BXoWGeKJZT6TwBQ@mail.gmail.com> <CAJVOszDp6P1Qaw43c1X-mONmqxmBkNjMKSOz+y41B6n+PJas9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34590 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756422AbcHYJaL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2016 05:30:11 -0400
In-Reply-To: <CAJVOszDp6P1Qaw43c1X-mONmqxmBkNjMKSOz+y41B6n+PJas9A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On 25 August 2016 at 16:03, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
> On Thu, Aug 25, 2016 at 2:01 AM, Tom Yan <tom.ty89@gmail.com> wrote:
>> Really please just drop this patch. There is no rational reason for
>> you to associate the maximum payload size to the logical sector size.
>
> Been over this many, many times now. It has to do with the size of
> the buffer setup through WRITE SAME in drivers/scsi/sd.c

Is it because we are re-using the scatter-gather list that the the sd
driver used for issuing write same / unmap commands to our SATL for
issuing ATA commands from our SATL to the AHCI host / ATA device? And
that the scatter-gather list cannot be extended on-demand? (Which
sounds pathetically defected)

>
>> And please stop using the ATA SCSI Response Buffer (ata_scsi_rbuf)
>> that is used for response to the SCSI layer for SCSI commands that
>> won't really interact with the ATA device (i.e. triggers an ATA
>> command), while ata_format_sct_write_same() and
>> ata_scsi_write_same_xlat() are used for constructing payload that is
>> going to be send to the ATA device. Can't you even see that these are
>> of different direction to different layer?
>
> Adding a new global buffer where there is one there already is

I never said global. On the contrary I almost explicitly stated that
you should not use a global buffer for that (and let
ata_format_sct_write_same() and ata_scsi_write_same_xlat() share it).

> kind of silly. The buffer already has a perfectly acceptable
> spinlock and the time spent copying data around is trivially
> small in comparison to the I/O operation so there is not
> likely to be any contention over the buffer.
>
> It is memory. Why do you think ata_scsi_rbuf is so special?

Practically it _might_ work just fine. But your are messing up the
whole layer/logic model by doing that.

But seriously, never mind. It's almost hilarious that:

1. Martin has been insisting on that we should stay at 1-block
payload, while he then conveniently ignore the fact that ACS
specifically instructed vendors to report the payload limit in
IDENTIFY DEVICE data in terms of 512-byte block (in other word, always
the maximum number of ranges the device can handle divided by 64), and
suggested that we should statically advertise 8-block payload (in
512-byte / ACS sense) for 4Kn devices.

2. And then you conveniently convert his idea on the Maximum Write
Same Length to the buffer size limit, without even taking care of the
VPD field.

And this is just _one_ example.

I am really done doing this. I'll just let others conveniently review
it and let the series through. Sorry for all the annoyance.
