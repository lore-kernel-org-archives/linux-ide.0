From: Doug Maxey <dwm@maxeymade.com>
Subject: hdparm write cache settings
Date: Fri, 15 Oct 2004 14:48:20 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410151948.i9FJmKMR019895@falcon30.maxeymade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from falcon30.maxeymade.com ([24.173.215.190]:12006 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S268342AbUJOTsX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Oct 2004 15:48:23 -0400
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>


Mark,

I have been tweaking the idedisk_setup() and write_cache() to handle
drives with write cache disabled by default and the barrier settings on
changes between WC enabled and disabled.

Bart has pointed out in offline mail, and testing has confirmed, that 
HDIO_DRIVE_CMD is used, which bypasses the settings parameter lookup 
in generic_ide_ioctl() of the drive settings enabled in ide_add_settings().  

Is it reasonable that a change could be made to enable the use of
HDIO_SET_WCACHE in hdparm?

Or should I be looking to intercept the call and do The Right Thing
(TM:) in the ide driver?


++doug




