From: Mark Lord <mlord@pobox.com>
Subject: Re: hdparm write cache settings
Date: Tue, 19 Oct 2004 17:47:31 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41758B73.60506@pobox.com>
References: <200410151948.i9FJmKMR019895@falcon30.maxeymade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:38020 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267301AbUJSVtW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Oct 2004 17:49:22 -0400
In-Reply-To: <200410151948.i9FJmKMR019895@falcon30.maxeymade.com>
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@maxeymade.com>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>

Hi,

Sure, I can update hdparm to first attempt HDIO_SET_WCACHE.
If that call is nak'd (usually due to lack of kernel support for it),
then hdparm will use HDIO_DRIVE_CMD as a fallback.

This is a VERY popular setting among end-users of Linux.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

Doug Maxey wrote:
> Mark,
> 
> I have been tweaking the idedisk_setup() and write_cache() to handle
> drives with write cache disabled by default and the barrier settings on
> changes between WC enabled and disabled.
> 
> Bart has pointed out in offline mail, and testing has confirmed, that 
> HDIO_DRIVE_CMD is used, which bypasses the settings parameter lookup 
> in generic_ide_ioctl() of the drive settings enabled in ide_add_settings().  
> 
> Is it reasonable that a change could be made to enable the use of
> HDIO_SET_WCACHE in hdparm?
> 
> Or should I be looking to intercept the call and do The Right Thing
> (TM:) in the ide driver?
> 
> 
> ++doug
> 
> 
> 
> 
> 


