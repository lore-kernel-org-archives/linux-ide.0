From: Tejun Heo <htejun@gmail.com>
Subject: Re: EH merge
Date: Tue, 04 Apr 2006 19:08:22 +0900
Message-ID: <44324596.9000803@gmail.com>
References: <44324265.806@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:17024 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751337AbWDDKI3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Apr 2006 06:08:29 -0400
Received: by zproxy.gmail.com with SMTP id o37so2129369nzf
        for <linux-ide@vger.kernel.org>; Tue, 04 Apr 2006 03:08:28 -0700 (PDT)
In-Reply-To: <44324265.806@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Due to the merge window closing, the three pending patchsets will be in 
> 2.6.18.
> 
> I'll try to push what's already in #upstream, but it may or may not 
> stick :)
> 

Dang...  Is there any way to push EH thing into 2.6.17?  We're getting 
handful of ATA IO error reports which can be either mitigated or at 
least better reported with new EH.

-- 
tejun
