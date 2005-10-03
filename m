From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH 2.6.13] drivers/ide: Enable basic VIA VT6410 IDE functionality
Date: Mon, 03 Oct 2005 14:41:02 -0400
Message-ID: <43417B3E.4020807@tmr.com>
References: <op.sxg2dxd5wc4mme@new.robertk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:6149 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932555AbVJCSkn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Oct 2005 14:40:43 -0400
In-Reply-To: <op.sxg2dxd5wc4mme@new.robertk.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Kesterson <robertk@robertk.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Robert Kesterson wrote:
> This patch enables plain IDE functionality on the VIA VT6410 IDE controller
> (such as used on the Asus P4P800 Deluxe motherboard).  This is not a RAID
> driver, but you can use Linux's software RAID once the drives are visible.
> I did not write the original version of this patch, which I found on the
> internet back in the days of kernel 2.6.2.  I have been unable to identify
> the original author to give him/her proper credit.  I have been maintaining
> and updating this patch since then and have released several updates which
> have been successfully used by others who have downloaded it from my
> website.
> 
> It seems appropriate that this minimal functionality should be in the
> mainstream kernel.

After using this patch (it works), it comes to me that the 2.4 version 
was in a separate driver, so I can control my order of controller 
recognition. Just having access to the devices is useful, but it would 
be more useful in the module version.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
