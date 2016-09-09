From: Tejun Heo <tj@kernel.org>
Subject: Re: patch "libata: Add support for SCT Write Same" breaks system
Date: Fri, 9 Sep 2016 11:36:13 -0400
Message-ID: <20160909153613.GB19609@htj.duckdns.org>
References: <20160908192736.GA4356@gmail.com>
 <20160909151607.GA19609@htj.duckdns.org>
 <CAJVOszB39NfK=z-rHVWuLyz909pSVwTMRFDPFcY50Uaoj6STEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34993 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbcIIPgb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Sep 2016 11:36:31 -0400
Content-Disposition: inline
In-Reply-To: <CAJVOszB39NfK=z-rHVWuLyz909pSVwTMRFDPFcY50Uaoj6STEQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Mike Krinkin <krinkin.m.u@gmail.com>, Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>

Hello, Shaun.

On Fri, Sep 09, 2016 at 10:26:44AM -0500, Shaun Tancheff wrote:
> I'm looking into it now. Let me see if I can reproduce this on any of my
> hardware.
> 
> If not there are a couple of options ... one is to only enable for ZBC
> devices
> where this explicitly required by the spec.
> 
> Or disable for devices that report support trim?

I'd much prefer enabling this only on ZBC devices.  There isn't any
real benefits to !ZBC devices, right?  Using non-essential features on
ATA never goes well.

Thanks.

-- 
tejun
