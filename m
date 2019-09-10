Return-Path: <SRS0=DiMu=XF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A57C3A5A2
	for <linux-ide@archiver.kernel.org>; Tue, 10 Sep 2019 13:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3F520872
	for <linux-ide@archiver.kernel.org>; Tue, 10 Sep 2019 13:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfIJNI3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:08:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfIJNI2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 10 Sep 2019 09:08:28 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D644188305
        for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2019 13:08:27 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id t185so1333375wmg.4
        for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2019 06:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxePtkckH/AUUbkLGnZFkRkMUM3ZrhbITaeniXzoqV4=;
        b=glRAHKbtvOLkrguuFO21pcoisjR8yHbMaiK7VSqAYLt9lU2wdxFozdwMPTPk8T48Vr
         0dcDLCOLo+I6+o7+k2X8POItcb0DRr4EtZ9P8NNN5/YIb1M7057wJHXzNJJ2bUm+CwFg
         8CBQ9Tz6qBYXUbFTAnv7xzny+NBA2GfpJJhBMPPzYI+5uTM64t+zxL5p+S+lQOELme9Z
         CzADqmaXndcqvmvURGL9PqOzU/Hc+yxzRjVxf+TVir7tZEk9Not3rNH5W8apEvUmxlUv
         C1JSwm/qcyI4AWYEdenWbdlzQSCM4ToYFU53cr0dwXabro3UtuXseNs6IhmR1G/szjLR
         C/GQ==
X-Gm-Message-State: APjAAAVhav3Wg1rKJiWo6v1a9aCdr3K9pykH2DhyPFt5K1fLnydhD9D2
        W94DcfgDeHUhdEOFWxZe7zB1Ao8FjSCkA+SBlLMFODVan6M2acuT+GOG+KnM1gbkk8mEOGnXmST
        mNnNGzY/GOjtAeqmiYUZNsAf3xecHV9UXwbze
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr25096466wrs.268.1568120906486;
        Tue, 10 Sep 2019 06:08:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx9GmF+QHqPOMRfo2vZqb626ptdxPEJZPMTeAlEAanrmctEuyq6OqZnCiHdDFjP/ZOjkGTHG6JJMMlnYe9d15U=
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr25096436wrs.268.1568120906178;
 Tue, 10 Sep 2019 06:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR10MB33991CE19828429C676C0296A1C40@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <AM6PR10MB339928C6DF7AF88789F904EFA1B70@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <20190910055333.GA32641@infradead.org> <AM6PR10MB339977CEF9AB4C3726AF3124A1B60@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM6PR10MB339977CEF9AB4C3726AF3124A1B60@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
From:   Bryan Gurney <bgurney@redhat.com>
Date:   Tue, 10 Sep 2019 09:08:14 -0400
Message-ID: <CAHhmqcSGK2W0Gz9CM=cKYH6PjtGnOwnWtadG7qOwYmQLjGwNAQ@mail.gmail.com>
Subject: Re: SATA errors accessing hidden partitions
To:     Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Sep 10, 2019 at 4:03 AM Jorge Fernandez Monteagudo
<jorgefm@cirsa.com> wrote:
>
> >> Hi all,
> >>
> >> I have a SSD disk from transcend with 6 partitions, where partitions 3, 4 and 5 are locked. This disk implements the OPAL specifications and transcend supplies some tools to hide/unhide a partition.
> >
> >OPAL does not have a concept to hide a partition, it supports locking
> >ranges.  In doubt you want to use the kernel opal support to unlock all
> >ranges and should be fine, otherwise there isn't too much we can do.
>
> You're right. We are  using locking ranges and these partitions are mapped onto these ranges.
> We're try too with a locked range without any partition inside an the system tries to access the
> locked range. We're wondering why kernel? blkid? is trying to get info from a locked range??
> The outcome is a SATA link in 1.5Gbps after a long time boot. In windows or MacOSx works in
> other way.
>
> Thanks!
> Jorge

Here's a quick grep of the dmesg you sent earlier (apologies if
there's any line wrapping):

$ egrep 'blocks|Buffer|print_req_error|Gbps'
20190910_linux-ide-jfernandez_deb_syserror_opaldrive.txt
[    1.506617] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 2 ports 6
Gbps 0x3 impl SATA mode
[    1.984614] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.988604] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    7.664613] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    7.694638] sd 0:0:0:0: [sda] 62533296 512-byte logical blocks:
(32.0 GB/29.8 GiB)
[    7.694674] sd 1:0:0:0: [sdb] 125045424 512-byte logical blocks:
(64.0 GB/59.6 GiB)
[    7.742149] print_req_error: I/O error, dev sda, sector 54732672
[    7.774167] print_req_error: I/O error, dev sda, sector 46344064
[    7.841977] print_req_error: I/O error, dev sda, sector 50538368
[    7.964634] ata1: limiting SATA link speed to 3.0 Gbps
[    8.444612] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    8.584387] print_req_error: I/O error, dev sda, sector 46344064
[    8.585346] Buffer I/O error on dev sda3, logical block 524272,
async page read
[    8.624635] ata1: limiting SATA link speed to 1.5 Gbps
[    9.104613] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    9.152565] print_req_error: I/O error, dev sda, sector 54732672
[    9.153517] Buffer I/O error on dev sda5, logical block 524272,
async page read
[    9.184662] print_req_error: I/O error, dev sda, sector 50538368
[    9.185625] Buffer I/O error on dev sda4, logical block 524272,
async page read
[   10.545916] print_req_error: I/O error, dev sda, sector 46344064
[   10.595852] print_req_error: I/O error, dev sda, sector 54732672
[   10.666024] print_req_error: I/O error, dev sda, sector 50538368
[   11.197218] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   11.694090] print_req_error: I/O error, dev sda, sector 46344064
[   11.694098] Buffer I/O error on dev sda3, logical block 524272,
async page read
[   11.721959] Buffer I/O error on dev sda4, logical block 524272,
async page read
[   11.750000] Buffer I/O error on dev sda5, logical block 524272,
async page read

Notice that logical block 524272 on devices sda3, sda4, and sda5 are
cited.  This is a blind guess, but are these partitions 524288 sectors
(256 MB) in size?

When blkid reads a device or a partition, there's a certain sequence
of reads that it performs, at various offsets in the device.  Via
blktrace / blkparse, you can see this activity.

For an example device with a partition that starts at sector 2048, and
ends at sector 3019900928:
# blktrace -d /dev/nvme0n1p1
(Ctrl+C)
...
# blkparse -i nvme0n1p1.blktrace.0 | grep C\ *
259,1    9        7     0.000096020     0  C   R 3019900800 + 8 [0]
259,1    9       14     0.000193530     0  C   R 3019900912 + 8 [0]
259,1    9       21     0.000260749     0  C   R 2048 + 8 [0]
259,1    9       28     0.000327329     0  C   R 2056 + 8 [0]
259,1    9       35     0.000416985     0  C   R 3019900920 + 8 [0]
259,1    9       42     0.000516949     0  C   R 3019900664 + 8 [0]
259,1    9       49     0.000662515     0  C   R 2080 + 8 [0]
259,1    9       56     0.000755225     0  C   R 2112 + 8 [0]
259,1    9       63     0.000845546     0  C   R 2176 + 8 [0]
259,1    9       70     0.000936905     0  C   R 2304 + 8 [0]

...and so on.  (The device major,minor says "259,1", which would be
/dev/nvme0n1p1, but the offset shown in the block trace is relative to
/dev/nvme0n1.)

You can notice that the first few reads are near the "end" of the
partition.  In fact, the first two read completions are 128 sectors
before the end, and 16 sectors before the end.  I'm guessing that this
"-16" read is the one that's failing in these three partitions.


Thanks,

Bryan
