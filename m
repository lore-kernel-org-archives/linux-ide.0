From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/2] libata: hotplug link speed
Date: Sat, 21 Oct 2017 09:53:31 -0700
Message-ID: <20171021165331.GX1302522@devbig577.frc2.facebook.com>
References: <1508437836-31649-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:55038 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbdJUQxe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 21 Oct 2017 12:53:34 -0400
Received: by mail-qk0-f173.google.com with SMTP id n5so17633591qke.11
        for <linux-ide@vger.kernel.org>; Sat, 21 Oct 2017 09:53:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1508437836-31649-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org

Hello, David.

On Thu, Oct 19, 2017 at 01:30:34PM -0500, David Milburn wrote:
> During hotplug, it is possible for 6Gbps link speed to
> be limited all the way down to 1.5 Gbps which may lead
> to a slower link speed when drive is re-connected.
> 
> This behavior has been seen on a Intel Lewisburg SATA
> controller (8086:a1d2) with HGST HUH728080ALE600 drive
> where SATA link speed was limited to 1.5 Gbps and
> when re-connected the link came up 3.0 Gbps. ata_dev_init
> initializes link->spd to 0, but, the 0001 patch will
> reset it once the link comes online. The 0002 patch will
> allow the error handler to reset link->spd only if the
> link is online; otherwise, it will always get set to 0.
> 
> This patch set was retested on above configuration and
> showed the hotplugged link to come back online at max
> speed (6Gbps). I did not see the downgrade when testing
> on Intel C600/X79, but retested patched linux-4.14-rc5
> kernel and didn't see any side effects from these
> changes. Also, successfully retested hotplug on port
> multiplier 3Gbps link. 

While the problem seems valid, I'm not sure the patches are in the
right direction.  Isn't the root cause the decision we're making in
sata_down_spd_limit() where the code is explicitly choosing 1.5Gbps if
spd information isn't available?  It'd make more sense to make better
decisions there rather than faking the information going into them.

Thanks.

-- 
tejun
