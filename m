From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: do not ignore PIO-only devices
Date: Wed, 22 Mar 2006 21:47:25 +0900
Message-ID: <4421475D.4050205@gmail.com>
References: <4420B439.6000608@comcast.net> <20060322114818.GA23515@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:8309 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751131AbWCVMrw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2006 07:47:52 -0500
Received: by pproxy.gmail.com with SMTP id m51so120105pye
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2006 04:47:52 -0800 (PST)
In-Reply-To: <20060322114818.GA23515@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ed Sweetman <safemode@comcast.net>, jgarzik@pobox.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> As libata now can do PIO, don't ignore PIO-only devices.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
> I'm currently away from my machines due to idiotic/useless national
> reserve military training :-(, so I only compile tested it.  Ed, can
> you please try the following patch and report the result?  Jeff,
> please don't apply until Ed confirms.
> 

More info. I've tested PIO only mode with several harddisks and PX716SA 
by nuking dma mask in ata_set_mode() in not-so-distant past (several 
weeks ago) and didn't have any problem.

-- 
tejun
