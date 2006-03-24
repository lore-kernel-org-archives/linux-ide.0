From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil did not like multiple LUNs...
Date: Fri, 24 Mar 2006 13:16:40 +0900
Message-ID: <20060324041640.GB5288@htj.dyndns.org>
References: <20060321190410.GA2761@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.193]:50288 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932637AbWCXEQr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2006 23:16:47 -0500
Received: by xproxy.gmail.com with SMTP id t10so439205wxc
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 20:16:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20060321190410.GA2761@mea-ext.zmailer.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-ide@vger.kernel.org

On Tue, Mar 21, 2006 at 09:04:10PM +0200, Matti Aarnio wrote:
> I need multiple LUNs on FC Fabric, and machine where these
> are on does boot from   sata_sil  mirror disks.
> 
> During todays boots (after lengthy uptime), sata_sil driver
> was rather upset about some NULL pointer referrals.
> 
> I had following extra boot line parameters:
>          max_luns=4 max_report_luns=4
> 
> Taking off those two let kernel boot just fine.
> 
> 
> The kernels in question were Fedora Core development 
> models from recent 2-3 weeks, including up to current
> date.
> 

Hello, Matti.

I can't reproduce your problem with #upstream.  Can you try libata-dev
#upstream or the latest vanialla kernel and report the result
including the oops message?

-- 
tejun
