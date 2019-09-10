Return-Path: <SRS0=DiMu=XF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B6DC49ED8
	for <linux-ide@archiver.kernel.org>; Tue, 10 Sep 2019 15:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D97206A5
	for <linux-ide@archiver.kernel.org>; Tue, 10 Sep 2019 15:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfIJPMu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:12:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfIJPMu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 10 Sep 2019 11:12:50 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3438356DC
        for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2019 15:12:49 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id a125so2230wmh.6
        for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2019 08:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVdexw+mNX1lru4HhWFwIM2/4wrpGim6NSSKfyMWQkI=;
        b=ckyJpjHlapjQvx7kbzmCLIjfYrXYw7CJQlsSrlxpA1vYM/+Cdp0cKlSUheyd9fcKfs
         KyhcYwLpoqoR7BsvAd09tWqdi7Eojh7uE4q2ytjRlQreulwJTT6hb3mpQ6Q4ctH9pXvt
         4qXQPQNWPIY2ftAgEjxzkWbVbVVhXsfvpHwIgrmc11cHEhQdBLvHpvfqWN/9AgbrEv9v
         n/Xkdtpgc6hkAPf37EKMy+ZobeEXSMpnu34+75bUGlqM3EM7GqQgDtXUbIIe7gdeyVLI
         Vo+G9lQgtoCW/Ir6iTn3bPlo/d1TE8KwMpBll7ZY6pKmLPyslQwy0CMjSTVGOckosjWz
         EayA==
X-Gm-Message-State: APjAAAW0Kg1s6muGVNayHk9/wb7A1eqCPF40VsAhm1P6vs2pJFKE42Gh
        v28/5PxZANSMnNDBrfjVhc6NqVJnA/FzncKidh4fOr2K1HCVa/EZJaBIqMv+Tq3aKSxJuZdOgHB
        jXJ9Ay3LgKsb13pSrkEXf3TbpF/+Xrv2pvUX1
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr19449091wrn.62.1568128368265;
        Tue, 10 Sep 2019 08:12:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+qh+2ScDDfyobJywwwEiydSjxE8IpD37vBF6KrZnflJKcOjj4ptHsaGdmEXTIVTTQoNV4O7xP+2607fZZK/U=
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr19449046wrn.62.1568128367825;
 Tue, 10 Sep 2019 08:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR10MB33991CE19828429C676C0296A1C40@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <AM6PR10MB339928C6DF7AF88789F904EFA1B70@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <20190910055333.GA32641@infradead.org> <AM6PR10MB339977CEF9AB4C3726AF3124A1B60@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <CAHhmqcSGK2W0Gz9CM=cKYH6PjtGnOwnWtadG7qOwYmQLjGwNAQ@mail.gmail.com> <AM6PR10MB3399036D93B32666191730D1A1B60@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM6PR10MB3399036D93B32666191730D1A1B60@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
From:   Bryan Gurney <bgurney@redhat.com>
Date:   Tue, 10 Sep 2019 11:12:36 -0400
Message-ID: <CAHhmqcTF1wBq037v2dDrKOs8tNhAMzw4_nY_52KY65NvCqWDXw@mail.gmail.com>
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

On Tue, Sep 10, 2019 at 10:03 AM Jorge Fernandez Monteagudo
<jorgefm@cirsa.com> wrote:
>
> Hi Bryan! Thanks for your detailed answer!
>
> >Notice that logical block 524272 on devices sda3, sda4, and sda5 are
> >cited.  This is a blind guess, but are these partitions 524288 sectors
> >(256 MB) in size?
>
> No, they're 4GB partitions.
>

Oh, okay.  I'm pretty sure that blkid checks regions near the end of a
device (for example, GPT has what looks like a backup of the "EFI
PART" boot record near the end of the device).  Therefore, it may be
worthwhile to double-check the size of the partition, in case they're
not 4 GB, for some strange reason.

> >You can notice that the first few reads are near the "end" of the
> >partition.  In fact, the first two read completions are 128 sectors
> >before the end, and 16 sectors before the end.  I'm guessing that this
> >"-16" read is the one that's failing in these three partitions.
>
> Then, there is an inconsistency in the blkid and kernel communication? Why the kernel
> tries to access to a locked range? It seems that blkid ask for a sector and the kernel try
> to read it back ignoring its locked, reducing speed and trying again with no luck until
> the error is returned. This is consistent with our workaround removing blkid from the
> udev rule to avoid the error.
>
> Maybe the OPAL is not clear enough about locked ranges and kernel thinks is an error,
> or it's an error in the disk's firmware I don't know, but under windows or MacOS X no
> error is displayed.
>
> Is there some way to ask a disk for their locked ranges and patch blkid to avoid accesing them?
>

I don't know about that, but keep in mind that other programs can use
libblkid to check devices for metadata, so implementing the udev rule
may not be enough.

Here's an excerpt of the dmesg lines from the first error:

[    7.740876] ata1.00: exception Emask 0x0 SAct 0x70000083 SErr 0x0 action 0x0
[    7.740914] ata1.00: irq_stat 0x40000008
[    7.740930] ata1.00: failed command: READ FPDMA QUEUED
[    7.740951] ata1.00: cmd 60/08:00:80:27:43/00:00:03:00:00/40 tag 0
ncq dma 4096 in
                        res 41/04:00:80:27:43/00:00:03:00:00/00 Emask
0x401 (device error) <F>
[    7.741003] ata1.00: status: { DRDY ERR }
[    7.741017] ata1.00: error: { ABRT }
[    7.741154] ata1.00: supports DRM functions and may not be fully accessible
[    7.741713] ata1.00: supports DRM functions and may not be fully accessible
[    7.742121] ata1.00: configured for UDMA/133
[    7.742139] sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
[    7.742141] sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
[    7.742144] sd 0:0:0:0: [sda] tag#0 Add. Sense: Unaligned write command
[    7.742147] sd 0:0:0:0: [sda] tag#0 CDB: Read(10) 28 00 03 43 27 80
00 00 08 00
[    7.742149] print_req_error: I/O error, dev sda, sector 54732672
[    7.742201] ata1: EH complete

Why is there an "Illegal Request - Unaligned write command" sense
error from sd, right after the failed ata command "READ FPDMA QUEUED"?
 Is this an expected failure mode for a read to a locked range?  (I'm
not familiar with TCG Opal drives, so unfortunately I don't have
enough context.)


Thanks,

Bryan
