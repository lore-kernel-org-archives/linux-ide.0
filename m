From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH] ata: do not hard code limit in ata_set_lba_range_entries()
Date: Mon, 22 Aug 2016 15:32:45 -0500
Message-ID: <CAJVOszC2sp0=GA02ZB00s46F84XfU7DvzNSravyhbjxY651ozQ@mail.gmail.com>
References: <e35afc461c9a79f568f2bcd4ef2cd1e07fb50082.1471890326.git.tom.ty89@gmail.com>
 <CAJ48U8UsFFD=fb6WQEVAam9-9RajVjLNrgiKmXCXvkCFOg2JnQ@mail.gmail.com> <CAGnHSE=Laj5kpFNJ-EqdN-NTUQJyOmwYtjWM7iLqGxDRqMSoxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:19391 "EHLO
        mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752089AbcHVUdH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2016 16:33:07 -0400
Received: from pps.filterd (m0075028.ppops.net [127.0.0.1])
        by mx0b-00003501.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u7MKPIY3044512
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2016 16:33:06 -0400
Received: from mail-ua0-f198.google.com (mail-ua0-f198.google.com [209.85.217.198])
        by mx0b-00003501.pphosted.com with ESMTP id 2502g7hs7n-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2016 16:33:05 -0400
Received: by mail-ua0-f198.google.com with SMTP id 65so259896368uay.1
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2016 13:33:05 -0700 (PDT)
In-Reply-To: <CAGnHSE=Laj5kpFNJ-EqdN-NTUQJyOmwYtjWM7iLqGxDRqMSoxA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, Tejun Heo <tj@kernel.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On Mon, Aug 22, 2016 at 3:07 PM, Tom Yan <tom.ty89@gmail.com> wrote:
> I don't see how that's possible. count / n_block will always be
> smaller than 65535 * ATA_MAX_TRIM_RNUM(64) = 4194240. Not to mention
> that isn't even a "buffer limit" anyway. By SG_IO do you mean like
> SCSI Write Same commands that issued with sg_write_same or so? If
> that's the case, that's what exactly commit 5c79097a28c2
> ("libata-scsi: reject WRITE SAME (16) with n_block that exceeds
> limit") is for.

Ah, I see. You are guarding the only user of ata_set_lba_range_entries().
Still if you are going to do that you have to alert any new user that they
must have an appropriately sized buffer to be overwriting.

Better to move it out of ata.h then the limit the scope of accidental
misuse?

Regards,
Shaun
