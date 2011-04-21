From: Tejun Heo <tj@kernel.org>
Subject: Re: WARNING at libata-core.c:5015 in 2.6.39-rc3-wl+, then lockup.
 (bisected)
Date: Thu, 21 Apr 2011 15:25:29 +0200
Message-ID: <20110421132529.GC31724@htj.dyndns.org>
References: <4DA5CF81.4070908@candelatech.com>
 <4DA5D5D8.8070301@candelatech.com>
 <4DA5F3BA.3060404@candelatech.com>
 <4DA87A72.50809@candelatech.com>
 <4DA88707.4060704@garzik.org>
 <4DA888D6.40000@candelatech.com>
 <4DAF9066.7090906@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43404 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab1DUNZe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2011 09:25:34 -0400
Content-Disposition: inline
In-Reply-To: <4DAF9066.7090906@candelatech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Greear <greearb@candelatech.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

Hello,

On Wed, Apr 20, 2011 at 07:03:18PM -0700, Ben Greear wrote:
> I tried today's kernel (39-rc4+) and it seems much more stable on my
> system.  So, I think the problem must be fixed.  It appears it was not
> fixed in the plain 39-rc4, for what that's worth.

Hmmm... interesting.  I don't know of any changes which could have
affected that but then again I've been half offline for the last three
weeks.  Can you please try to boot earlier kernel and determine
whether the kernel version difference is actually making the
difference?

Thanks.

-- 
tejun
