From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v6 1/4] libata: Safely overwrite attached page in WRITE
 SAME xlat
Date: Tue, 23 Aug 2016 03:42:13 -0500
Message-ID: <CAJVOszDu8WfoSysar=a5vvKb8ADtGb2faR=dGJm9vtvC_OSeUQ@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-2-shaun@tancheff.com>
 <CAGnHSEnMS+wYWiwLxoYsTDOoVb9qJ=gZbcQmhsZumiO+wbQi4A@mail.gmail.com>
 <CAJVOszBVXftz9hqmOgWG5DvxW7cQjFPUFaGygWcj_exgNwT4=w@mail.gmail.com>
 <CAGnHSE=t1qg5ukA7btSwD=AaQZB6W6bmF9HMC_K2JsCqoSNGVg@mail.gmail.com>
 <CAJVOszBP_JLgKUsknSmG+AuCVW8VEB4VUuaTNQ-MrE9B0nuXBg@mail.gmail.com>
 <CAGnHSEmsgp93X85-bgFyV0CdQbvdMHZsWj6e=VNH_7dUDUewHA@mail.gmail.com>
 <CAJVOszD8HDqQMxyAnU=Yh6UDA+KE13u7Mq6s248uguRf-uUkYg@mail.gmail.com> <CAGnHSEn7M9Kmse+_JFFCgvZY5TqZt1TDzXGhKaqimog4OKiktg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:37893 "EHLO
        mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756868AbcHWIvM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2016 04:51:12 -0400
Received: from pps.filterd (m0075555.ppops.net [127.0.0.1])
        by mx0a-00003501.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u7N8eT0R024833
        for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2016 04:42:34 -0400
Received: from mail-qt0-f198.google.com (mail-qt0-f198.google.com [209.85.216.198])
        by mx0a-00003501.pphosted.com with ESMTP id 250fmf9d0h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2016 04:42:34 -0400
Received: by mail-qt0-f198.google.com with SMTP id n6so227360430qtn.2
        for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2016 01:42:33 -0700 (PDT)
In-Reply-To: <CAGnHSEn7M9Kmse+_JFFCgvZY5TqZt1TDzXGhKaqimog4OKiktg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On Tue, Aug 23, 2016 at 2:53 AM, Tom Yan <tom.ty89@gmail.com> wrote:
> On 23 August 2016 at 06:20, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>> On Tue, Aug 23, 2016 at 12:26 AM, Tom Yan <tom.ty89@gmail.com> wrote:
>>
>>> It is always 1 merely because we prefer sticking to that. Say we want
>>> to enable multi-block payload now, it won't be 1 anymore.
>>
>> Sorry, I though that DSM TRIM is using 512 bytes here because
>> WRITE_SAME_16 has a payload of a single logical sector.
>
> Nope, SCSI Write Same commands does not have payload (or in SCSI
> terms, parameter list / data-out buffer).

Hmm. Not sure about T10, but that's not how I read
sd_setup_write_same_cmnd(), it always setups up a transfer of
sector_size for scsi_init_io().

As I understand things, this is how the cmd's sglist is populated and why
this should be using sg_copy_from_buffer() rather than open coding
to the page.
-- 
Shaun Tancheff
