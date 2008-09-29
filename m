From: Tejun Heo <tj@kernel.org>
Subject: Re: Load/Unload issue: HP NX6325
Date: Mon, 29 Sep 2008 16:32:36 +0900
Message-ID: <48E08494.5020205@kernel.org>
References: <c68c8f1f0809210359o5f0169c7v9d47088517e264ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41807 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbYI2HeT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 03:34:19 -0400
In-Reply-To: <c68c8f1f0809210359o5f0169c7v9d47088517e264ed@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Wolf <wolfchri@gmail.com>
Cc: linux-ide@vger.kernel.org

Christian Wolf wrote:
> Hello,
> 
> pls see attached files for more info on this load/unload issue on the HP NX6325.
> 
> hdparm -B 254 /dev/sda does "fix" it, the drive also does not overheat
> from this value - in opposite to some other drives. 255 does not help,
> in opposite as some fellow user states in the Ubuntu notebook wiki, on
> this drive.
> 
> As far as I can tell from now nearly 1 yr with this parameter, it does
> not harm the drive but helps to stop unloading the heads.
> 
> More about the issue on the HP NX6325 on my blog:
> http://vale.homelinux.net/wordpress/2007/10/24/potential-risk-for-your-nx6325s-harddrive/
> 
> In case you are employed by HP, could you please consider me as your
> future notebook Linux evangelist? ;-)

How much does the load cycle count increase per hour without the
adjustment?  Heh... and I don't work for HP and have been a happy tp
user for about a year now.  :-)

Thanks

-- 
tejun
