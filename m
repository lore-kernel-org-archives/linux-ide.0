From: Tejun Heo <htejun@gmail.com>
Subject: Re: Issuing a vendor specific ATA cmd on SATA Disk via ATA Pass Thru
Date: Fri, 30 Nov 2007 17:22:29 +0900
Message-ID: <474FC845.7050308@gmail.com>
References: <004d01c83273$68ded140$6539a8c0@usish.com.cn> <474F64F5.9070205@gmail.com> <006101c83301$bf79bef0$6539a8c0@usish.com.cn> <474FA9B6.105@gmail.com> <008f01c8331a$50efacb0$6539a8c0@usish.com.cn> <474FAECC.6070303@gmail.com> <009901c8331c$30d2c780$6539a8c0@usish.com.cn> <474FB1FB.9050904@gmail.com> <009b01c8331e$e8f40200$6539a8c0@usish.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.183]:32997 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbXK3IWi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 03:22:38 -0500
Received: by ro-out-1112.google.com with SMTP id p4so3462708roc
        for <linux-ide@vger.kernel.org>; Fri, 30 Nov 2007 00:22:37 -0800 (PST)
In-Reply-To: <009b01c8331e$e8f40200$6539a8c0@usish.com.cn>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sam song <sam_song@usish.com>
Cc: linux-ide@vger.kernel.org

sam song wrote:
>> Tejun Heo wrote:
>> Yeah, that's SLE10 so no wonder ATA passthrough is broken.  Please try
>> with the vanilla kernel.
> 
> Still one point to consultant with you. I have no successful experience with
> vanilla kernel upgrade. So after getting the kernel 2.6.23.9, is it OK for
> me to use the default configure file of SLE10 for the vanilla kernel
> compiling?

That probably won't work.  You'll need to configure the kernel yourself.
 Alternatively, you can just install newer distribution.

-- 
tejun
