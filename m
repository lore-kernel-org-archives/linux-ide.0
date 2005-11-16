From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Date: Wed, 16 Nov 2005 12:04:00 +0900
Message-ID: <437AA1A0.6080409@gmail.com>
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379E5F7.6000107@gmail.com> <4379EC82.1030509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:17475 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965184AbVKPDEI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2005 22:04:08 -0500
Received: by zproxy.gmail.com with SMTP id i1so1681684nzh
        for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2005 19:04:08 -0800 (PST)
In-Reply-To: <4379EC82.1030509@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Jeff Garzik wrote:
> 
> The port stops, when any error occurs.  For device errors, set 
> PORT_CS_INIT bit in PORT_CTRL_STAT, then wait for Port Ready (bit 31, 
> see above).
> 

Yeap, this did the trick.  I'm working on SRST/init stuff and I think I 
can post patches later today.  What workload do you use for testing a 
ATAPI device?  I'm currently thinking of the following...

* mounting & tarr'ing cdrom & unmount
* repeat above with eject/load
* burning a cdrom
* ripping a music cd with cdparanoia

Any other thing I can try?

-- 
tejun
