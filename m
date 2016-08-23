From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v6 1/4] libata: Safely overwrite attached page in WRITE
 SAME xlat
Date: Tue, 23 Aug 2016 01:20:28 -0500
Message-ID: <CAJVOszD8HDqQMxyAnU=Yh6UDA+KE13u7Mq6s248uguRf-uUkYg@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-2-shaun@tancheff.com>
 <CAGnHSEnMS+wYWiwLxoYsTDOoVb9qJ=gZbcQmhsZumiO+wbQi4A@mail.gmail.com>
 <CAJVOszBVXftz9hqmOgWG5DvxW7cQjFPUFaGygWcj_exgNwT4=w@mail.gmail.com>
 <CAGnHSE=t1qg5ukA7btSwD=AaQZB6W6bmF9HMC_K2JsCqoSNGVg@mail.gmail.com>
 <CAJVOszBP_JLgKUsknSmG+AuCVW8VEB4VUuaTNQ-MrE9B0nuXBg@mail.gmail.com> <CAGnHSEmsgp93X85-bgFyV0CdQbvdMHZsWj6e=VNH_7dUDUewHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:32892 "EHLO
        mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756672AbcHWGVV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2016 02:21:21 -0400
Received: from pps.filterd (m0075554.ppops.net [127.0.0.1])
        by mx0a-000cda01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u7N6KSRt032921
        for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2016 02:20:50 -0400
Received: from mail-qk0-f199.google.com (mail-qk0-f199.google.com [209.85.220.199])
        by mx0a-000cda01.pphosted.com with ESMTP id 250dm395c2-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2016 02:20:49 -0400
Received: by mail-qk0-f199.google.com with SMTP id i2so3578424qkc.0
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2016 23:20:49 -0700 (PDT)
In-Reply-To: <CAGnHSEmsgp93X85-bgFyV0CdQbvdMHZsWj6e=VNH_7dUDUewHA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On Tue, Aug 23, 2016 at 12:26 AM, Tom Yan <tom.ty89@gmail.com> wrote:

> It is always 1 merely because we prefer sticking to that. Say we want
> to enable multi-block payload now, it won't be 1 anymore.

Sorry, I though that DSM TRIM is using 512 bytes here because
WRITE_SAME_16 has a payload of a single logical sector.

> Also note that the payload is NOT always fully-filled.

Oh, I was considering filling the remainder of the buffer
with 0's using memset() as you described to be "filly-filled"
in this case. Sorry for the confusion.

-- 
Shaun Tancheff
