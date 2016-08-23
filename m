From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH] ata: do not hard code limit in ata_set_lba_range_entries()
Date: Tue, 23 Aug 2016 04:18:06 -0500
Message-ID: <CAJVOszB7cyUcE+A_EUw0OnvdO3iGFW9sG45R2Ng1Ea_Q7YxaQA@mail.gmail.com>
References: <e35afc461c9a79f568f2bcd4ef2cd1e07fb50082.1471890326.git.tom.ty89@gmail.com>
 <CAJ48U8UsFFD=fb6WQEVAam9-9RajVjLNrgiKmXCXvkCFOg2JnQ@mail.gmail.com>
 <CAGnHSE=Laj5kpFNJ-EqdN-NTUQJyOmwYtjWM7iLqGxDRqMSoxA@mail.gmail.com>
 <CAJVOszC2sp0=GA02ZB00s46F84XfU7DvzNSravyhbjxY651ozQ@mail.gmail.com>
 <CAGnHSEm18o-8ZRhyFnyQ22rUm+gJLWwJyxoA-iSJnkM3k4oHHQ@mail.gmail.com>
 <CAJ48U8XDb7S2WPSDBtn+VUoRb70u6SmgbPFhm-NC2jx6CmE2mw@mail.gmail.com> <CAGnHSEn470B0ecDdMSY29W4Or3jD_NPoUAku_09o=X9Tn6vSpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:51555 "EHLO
        mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752999AbcHWKP6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2016 06:15:58 -0400
Received: from pps.filterd (m0075552.ppops.net [127.0.0.1])
        by mx0a-00003501.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u7N9ArRO042690
        for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2016 05:18:27 -0400
Received: from mail-qk0-f200.google.com (mail-qk0-f200.google.com [209.85.220.200])
        by mx0a-00003501.pphosted.com with ESMTP id 250kaxg46t-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2016 05:18:27 -0400
Received: by mail-qk0-f200.google.com with SMTP id i2so9884620qkc.0
        for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2016 02:18:26 -0700 (PDT)
In-Reply-To: <CAGnHSEn470B0ecDdMSY29W4Or3jD_NPoUAku_09o=X9Tn6vSpw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, Tejun Heo <tj@kernel.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On Tue, Aug 23, 2016 at 3:37 AM, Tom Yan <tom.ty89@gmail.com> wrote:
> On 23 August 2016 at 07:30, Shaun Tancheff <shaun@tancheff.com> wrote:

> If we really want/need to avoid hitting some real buffer limit (e.g.
> maximum length of scatter/gather list?), then we should in some way
> check n_block against that. If it is too large we then return
> used_bytes = 0 (optionally with some follow-up to add a response to
> such return value or so).

Yes there is a real buffer limit, I can think of these two options:
1- Assume the setups from sd_setup_discard_cmnd() and/
   or sd_setup_write_same_cmnd() are providing an sglist of
   sdp->sector_size via scsi_init_io()

2- Find (or write) a suitable sg_get_size(sgl, nents) to walk the
    sglist and calculate the available buffer size.

#2 sounds like more fun but I'm not sure it's what people would prefer to see.

--
Shaun
