From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fix revalidation issuing after configuration
 commands
Date: Thu, 11 Oct 2007 12:23:27 +0900
Message-ID: <470D972F.6040601@gmail.com>
References: <20071010065744.GO12186@htj.dyndns.org> <18189.37005.959133.650409@kitty1.shrimp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:24720 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756154AbXJKDXg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 23:23:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so461178wah
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2007 20:23:36 -0700 (PDT)
In-Reply-To: <18189.37005.959133.650409@kitty1.shrimp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: idurdanovic@comcast.net
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Igor Durdanovic wrote:
> Hi,
> 
> The patch works fine! Reset happens only once per disk and works also
> when disks are missing, which would result in infinite loop before.
> Setting the parameters of a hard-drive works too.
> 
> The only thing that is puzzling to me is that I am unable to send more
> than 80MB/s through one Express-Card sata port. I am not sure what the
> problem is, the bus ought to sustain 300MB/s without the problem, is
> this PM limitation (does not seem so from the PR material), or the
> sata card? This makes it impossible to create high-speed RAID.

There are some performance issues with 3124/3132 family controllers.
I'm not sure whether you're hitting it or 3132 is actually affected by
the problem tho.  linux-ide ML archive should have some related messages.

-- 
tejun
