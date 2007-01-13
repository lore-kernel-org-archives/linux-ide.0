From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH6-M libata disk timeouts 2.6.18 -> 2.6.19
Date: Sat, 13 Jan 2007 11:23:19 +0900
Message-ID: <45A84297.3020408@gmail.com>
References: <17923.1168404967@mdt.dhcp.pit.laurelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:34715 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161197AbXAMCX0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 21:23:26 -0500
Received: by an-out-0708.google.com with SMTP id b33so621478ana
        for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 18:23:25 -0800 (PST)
In-Reply-To: <17923.1168404967@mdt.dhcp.pit.laurelnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Accetta <maccetta@laurelnetworks.com>
Cc: linux-ide@vger.kernel.org

Mike Accetta wrote:
> Here's a bit more information on these timeouts.  I noticed a mention
> of changing the command queue depth in a recent lkml post and decided
> to give that a whirl.
> 
> This problem seems to be related to the depth of the queue.  When I
> set the value for /sys/block/sdb/device/queue_depth to 4 the raid1
> re-sync completes without incident.  When set to 5 it eventually gives
> the timeout error message (although at well past 50% of the re-sync).
> The problem was originally observed with the default setting (31).

Please post the result of 'hdparm -I /dev/sdb'.  Thanks.

-- 
tejun
