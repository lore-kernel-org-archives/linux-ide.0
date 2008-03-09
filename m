From: Tejun Heo <htejun@gmail.com>
Subject: Re: Frequent ATA errors
Date: Sun, 09 Mar 2008 15:46:36 +0900
Message-ID: <47D387CC.20906@gmail.com>
References: <47D19C42.60301@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:14236 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbYCIGqm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 01:46:42 -0500
Received: by rv-out-0910.google.com with SMTP id k20so739439rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 08 Mar 2008 22:46:42 -0800 (PST)
In-Reply-To: <47D19C42.60301@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LCID Fire <lcid-fire@gmx.net>
Cc: linux-ide@vger.kernel.org

LCID Fire wrote:
> Hi.
> I have a big problem. Since 2.6.22 I keep getting ata errors. Most of
> the time my computer (Intel P965 Chipset) ran fine - but then suddenly
> it began to stutter - the mouse was only moving very little and all
> input was lagged like hell. The only chance to get rid of this is to
> restart.
> It has continued to my current 2.6.24. In between there were times
> (kernel revisions) when it was better - meaning the error did only occur
> every few days or so. With the current 2.6.24 I have it almost every
> hour - I restarted my computer 10 times today alone. The errors look
> like the following:

Does "hal-disable-polling /dev/sr0" help?

-- 
tejun
