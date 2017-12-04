From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: sata_down_spd_limit should return if driver has
 not recorded sstatus speed
Date: Mon, 4 Dec 2017 13:57:36 -0800
Message-ID: <20171204215736.GO2421075@devbig577.frc2.facebook.com>
References: <1510697845-58071-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38179 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbdLDV5j (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Dec 2017 16:57:39 -0500
Received: by mail-qt0-f195.google.com with SMTP id d4so24635347qtj.5
        for <linux-ide@vger.kernel.org>; Mon, 04 Dec 2017 13:57:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1510697845-58071-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org

On Tue, Nov 14, 2017 at 04:17:25PM -0600, David Milburn wrote:
> During hotplug, it is possible for 6Gbps link speed to
> be limited all the way down to 1.5 Gbps which may lead
> to a slower link speed when drive is re-connected.
> 
> This behavior has been seen on a Intel Lewisburg SATA
> controller (8086:a1d2) with HGST HUH728080ALE600 drive
> where SATA link speed was limited to 1.5 Gbps and
> when re-connected the link came up 3.0 Gbps.
> 
> This patch was retested on above configuration and
> showed the hotplugged link to come back online at max
> speed (6Gbps). I did not see the downgrade when testing
> on Intel C600/X79, but retested patched linux-4.14-rc5
> kernel and didn't see any side effects from this
> change. Also, successfully retested hotplug on port
> multiplier 3Gbps link.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>

Applied to libata/for-4.15-fixes.

Thanks.

-- 
tejun
