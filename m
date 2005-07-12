From: Tejun Heo <htejun@gmail.com>
Subject: Re: Host protected area on suspend/resume
Date: Tue, 12 Jul 2005 23:49:35 +0900
Message-ID: <42D3D87F.5040901@gmail.com>
References: <20050712113044.GA8744@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:49364 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261504AbVGLOto (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2005 10:49:44 -0400
Received: by zproxy.gmail.com with SMTP id m7so531214nzf
        for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2005 07:49:42 -0700 (PDT)
In-Reply-To: <20050712113044.GA8744@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

Matthew Garrett wrote:
> On boot, Linux will attempt to disable the host protected area on a 
> disk. After a suspend/resume cycle, the BIOS may reenable it (seen on a 
> Thinkpad T40 and R40). As a result, the kernel is now unable to access 
> the HPA.
> 
> Is there any issue with just adding a call to idedisk_check_hpa() in the 
> IDE resume code?

  This has come up several times now.  One thing I'm curious about is 
why we are disabling HPA on boot without consent from the user.  AFAIK, 
HPA is mostly used to implement hidden recovery/suspend storage areas 
and disabling automatically on boot increases the likeliness of 
destroying them.  What do we gain by disabling HPA on boot?  Are there 
some dumb machines which unnecessarily sets HPA and reduces the capacity 
of drives excessively?  Even in such cases, wouldn't it be better to do 
idedisk_check_hpa() only when kernel parameter explicitly says so?

-- 
tejun
