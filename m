From: Shaun Tancheff <shaun@tancheff.com>
Subject: Re: patch "libata: Add support for SCT Write Same" breaks system
Date: Fri, 9 Sep 2016 10:55:10 -0500
Message-ID: <CAJ48U8VJDSzQWuNgG1mnBG_6FvSx5Arc=n6YsH-vxKrt=skWqw@mail.gmail.com>
References: <20160908192736.GA4356@gmail.com> <20160909151607.GA19609@htj.duckdns.org>
 <CAJVOszB39NfK=z-rHVWuLyz909pSVwTMRFDPFcY50Uaoj6STEQ@mail.gmail.com> <20160909153613.GB19609@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35948 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbcIIPzM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Sep 2016 11:55:12 -0400
In-Reply-To: <20160909153613.GB19609@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Shaun Tancheff <shaun.tancheff@seagate.com>, Mike Krinkin <krinkin.m.u@gmail.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>

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

Sure I'm fine with that.

I'll move the WRITE SAME support to be conditional on ZBC.
Sending a patch as soon as it's tested.

> Thanks.
>
> --
> tejun

Thanks
--
Shaun
