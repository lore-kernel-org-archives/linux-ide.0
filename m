From: Tejun Heo <htejun@gmail.com>
Subject: Re: Host protected area on suspend/resume
Date: Wed, 13 Jul 2005 00:15:53 +0900
Message-ID: <42D3DEA9.4070405@gmail.com>
References: <20050712113044.GA8744@srcf.ucam.org> <42D3D87F.5040901@gmail.com> <20050712150739.GA9731@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:41607 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261548AbVGLPQC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2005 11:16:02 -0400
Received: by zproxy.gmail.com with SMTP id l1so519552nzf
        for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2005 08:16:00 -0700 (PDT)
In-Reply-To: <20050712150739.GA9731@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

Matthew Garrett wrote:
> On Tue, Jul 12, 2005 at 11:49:35PM +0900, Tejun Heo wrote:
> 
> 
>> This has come up several times now.  One thing I'm curious about is 
>>why we are disabling HPA on boot without consent from the user.  AFAIK, 
>>HPA is mostly used to implement hidden recovery/suspend storage areas 
>>and disabling automatically on boot increases the likeliness of 
>>destroying them.  What do we gain by disabling HPA on boot?  Are there 
>>some dumb machines which unnecessarily sets HPA and reduces the capacity 
>>of drives excessively?  Even in such cases, wouldn't it be better to do 
>>idedisk_check_hpa() only when kernel parameter explicitly says so?
> 
> 
> I'm not sure why we're doing it, but reverting this behaviour is likely 
> to make some systems unbootable (install with kernel which disables HPA, 
> format entire drive, put filesystem on it).

  Yeah... it will immediately make disks unusable.  sad, sad.

-- 
tejun
