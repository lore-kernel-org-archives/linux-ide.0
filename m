From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH 2.6.13] drivers/ide: Enable basic VIA VT6410 IDE functionality
Date: Thu, 22 Sep 2005 14:41:28 -0400
Message-ID: <4332FAD8.50800@tmr.com>
References: <op.sxg2dxd5wc4mme@new.robertk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:22020 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751044AbVIVSmI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Sep 2005 14:42:08 -0400
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

Thank you, I have been running with a similar patch for 2.4 series, but 
have been running unpatched kernels for testing and have not had access 
to my other drives. Hopefully this can get into the mainstream without 
too much delay.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
