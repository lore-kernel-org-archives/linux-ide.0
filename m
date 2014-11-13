From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH resend regression?] AHCI: Fix threaded interrupt setup
Date: Thu, 13 Nov 2014 17:31:48 -0500
Message-ID: <20141113223148.GJ2598@htj.dyndns.org>
References: <1415871882-634-1-git-send-email-hdegoede@redhat.com>
 <546482A9.20803@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:61580 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934378AbaKMWbv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Nov 2014 17:31:51 -0500
Received: by mail-qg0-f53.google.com with SMTP id z107so11385415qgd.12
        for <linux-ide@vger.kernel.org>; Thu, 13 Nov 2014 14:31:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <546482A9.20803@arm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Thu, Nov 13, 2014 at 10:06:33AM +0000, Marc Zyngier wrote:
> I think the real fix should be to revert the whole threaded interrupt
> thing. Adding the IRQF_ONESHOT breaks some Intel platforms in a rather
> bad way in case of a shared interrupt (for gory details, see
> http://www.gossamer-threads.com/lists/linux/kernel/2043506).
> 
> Tejun did prepare a set of patches to revert this, but I haven't seen it
> being pulled in yet. It would be good to get something into 3.18.

Yeap, they're sitting in libata/for-3.18-fixes.  I'll push it out
shortly.  Sorry about the delay.

Thanks.

-- 
tejun
