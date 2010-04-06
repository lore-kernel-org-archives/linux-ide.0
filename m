From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] fix BUG with IDE taskfile ioctl and cfq
Date: Tue, 06 Apr 2010 16:36:35 -0700 (PDT)
Message-ID: <20100406.163635.122075784.davem@davemloft.net>
References: <Pine.LNX.4.64.1004061924430.27367@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:52871
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757655Ab0DFXgd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 19:36:33 -0400
In-Reply-To: <Pine.LNX.4.64.1004061924430.27367@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mpatocka@redhat.com
Cc: linux-ide@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 6 Apr 2010 19:29:57 -0400 (EDT)

> This fixes a crash when using hdparm --security-* on IDE devices with CFQ 
> scheduler.

Thanks I'll take a look at a this.

> BTW. I found out that it's impossible to use these security commands on 
> sparc64 because of 64-bit kernel, 32-bit userspace and a lack of ioctl 
> emulation (I succeeded when I recompiled hdparm on my own in 64-bit mode). 
> What do you think is the best fix for it? Put it to fs/compat_ioctl.c 
> (like SG_IO)? Or make a compat_ioctl method in IDE? Or don't fix it and 
> persuade distros to compile hdparm as 64-bit?

The general pattern is to move the ioctl compat handlers into
the drivers themselves, so putting in a compat handler in the
IDE layer is the way to go.
