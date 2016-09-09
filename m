From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: patch "libata: Add support for SCT Write Same" breaks system
Date: Fri, 9 Sep 2016 12:17:38 -0500
Message-ID: <CAJVOszAfyH1epduB1Ehu7VcEr_oMfTcqgAb+-_1nNg+x2a-Xww@mail.gmail.com>
References: <20160908192736.GA4356@gmail.com> <20160909151607.GA19609@htj.duckdns.org>
 <CAJVOszB39NfK=z-rHVWuLyz909pSVwTMRFDPFcY50Uaoj6STEQ@mail.gmail.com> <20160909153613.GB19609@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:59276 "EHLO
        mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751008AbcIIRSC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Sep 2016 13:18:02 -0400
Received: from pps.filterd (m0075551.ppops.net [127.0.0.1])
        by mx0a-000cda01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u89HFb4U008367
        for <linux-ide@vger.kernel.org>; Fri, 9 Sep 2016 13:18:02 -0400
Received: from mail-qt0-f197.google.com (mail-qt0-f197.google.com [209.85.216.197])
        by mx0a-000cda01.pphosted.com with ESMTP id 25c18102c3-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-ide@vger.kernel.org>; Fri, 09 Sep 2016 13:17:59 -0400
Received: by mail-qt0-f197.google.com with SMTP id v24so171539036qtv.2
        for <linux-ide@vger.kernel.org>; Fri, 09 Sep 2016 10:17:59 -0700 (PDT)
In-Reply-To: <20160909153613.GB19609@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mike Krinkin <krinkin.m.u@gmail.com>, Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>

On Fri, Sep 9, 2016 at 10:36 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Shaun.
>
> On Fri, Sep 09, 2016 at 10:26:44AM -0500, Shaun Tancheff wrote:
>> I'm looking into it now. Let me see if I can reproduce this on any of my
>> hardware.
>>
>> If not there are a couple of options ... one is to only enable for ZBC
>> devices
>> where this explicitly required by the spec.
>>
>> Or disable for devices that report support trim?
>
> I'd much prefer enabling this only on ZBC devices.  There isn't any
> real benefits to !ZBC devices, right?  Using non-essential features on
> ATA never goes well.

I've posted a patch for !ZBC.

Mike, can you confirm if this works for you?

>
> Thanks.
>
> --
> tejun

Thanks!

(Apologies for the html reply earlier)
-- 
Shaun Tancheff
