From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v6 3/4 RESEND] SCT Write Same / DSM Trim
Date: Thu, 25 Aug 2016 03:03:13 -0500
Message-ID: <CAJVOszDp6P1Qaw43c1X-mONmqxmBkNjMKSOz+y41B6n+PJas9A@mail.gmail.com>
References: <0c9c5a80-813b-31f0-355d-2e08e452dd01@suse.de> <20160824180814.24708-1-shaun@tancheff.com>
 <CAGnHSEmVbpaE6pr2JX=bAH0wpz6U7xnT--2BXoWGeKJZT6TwBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:43899 "EHLO
        mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757918AbcHYIKW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2016 04:10:22 -0400
Received: from pps.filterd (m0075551.ppops.net [127.0.0.1])
        by mx0a-000cda01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u7P8AL78018808
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2016 04:10:21 -0400
Received: from mail-qt0-f197.google.com (mail-qt0-f197.google.com [209.85.216.197])
        by mx0a-000cda01.pphosted.com with ESMTP id 251teaguty-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2016 04:10:21 -0400
Received: by mail-qt0-f197.google.com with SMTP id n6so77556362qtn.2
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2016 01:10:20 -0700 (PDT)
In-Reply-To: <CAGnHSEmVbpaE6pr2JX=bAH0wpz6U7xnT--2BXoWGeKJZT6TwBQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On Thu, Aug 25, 2016 at 2:01 AM, Tom Yan <tom.ty89@gmail.com> wrote:
> Really please just drop this patch. There is no rational reason for
> you to associate the maximum payload size to the logical sector size.

Been over this many, many times now. It has to do with the size of
the buffer setup through WRITE SAME in drivers/scsi/sd.c

> And please stop using the ATA SCSI Response Buffer (ata_scsi_rbuf)
> that is used for response to the SCSI layer for SCSI commands that
> won't really interact with the ATA device (i.e. triggers an ATA
> command), while ata_format_sct_write_same() and
> ata_scsi_write_same_xlat() are used for constructing payload that is
> going to be send to the ATA device. Can't you even see that these are
> of different direction to different layer?

Adding a new global buffer where there is one there already is
kind of silly. The buffer already has a perfectly acceptable
spinlock and the time spent copying data around is trivially
small in comparison to the I/O operation so there is not
likely to be any contention over the buffer.

It is memory. Why do you think ata_scsi_rbuf is so special?
