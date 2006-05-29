From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Mon, 29 May 2006 18:46:52 +0900
Message-ID: <447AC30C.4010703@gmail.com>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com>	 <44779A05.4010209@garzik.org>  <447AB9FB.6020706@gmail.com> <1148894288.3466.32.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:27316 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750791AbWE2JrA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 05:47:00 -0400
Received: by py-out-1112.google.com with SMTP id e30so343791pya
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 02:46:59 -0700 (PDT)
In-Reply-To: <1148894288.3466.32.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, liml@rtr.ca, linux-ide@vger.kernel.org

zhao, forrest wrote:
>> * There's a race window between ATA revalidation and SCSI rescan.  We 
>> can plug this hole by deferring commands till rescan is complete.  But I 
>> doubt it would be worth the trouble.
>>
> This is really a problem. But the race condition is not so critical that
> we need to bother to do some sync between libata and SCSI layer, right?

I guess/hope so.  The only thing which can make any difference seems to
be the cache type setting.  I don't think small race window would cause
too much trouble there.

-- 
tejun
