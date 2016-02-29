From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: ahci: don't mark HotPlugCapable Ports as
 external/removable
Date: Mon, 29 Feb 2016 16:20:08 -0500
Message-ID: <20160229212008.GB3965@htj.duckdns.org>
References: <1456585805-897872-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36320 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbcB2VUK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Feb 2016 16:20:10 -0500
Received: by mail-qg0-f44.google.com with SMTP id y9so128149871qgd.3
        for <linux-ide@vger.kernel.org>; Mon, 29 Feb 2016 13:20:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456585805-897872-1-git-send-email-manuel.lauss@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Linux-IDE <linux-ide@vger.kernel.org>, Laura Abbott <labbott@redhat.com>

On Sat, Feb 27, 2016 at 04:10:05PM +0100, Manuel Lauss wrote:
> The HPCP bit is set by bioses for on-board sata ports either because
> they think sata is hotplug capable in general or to allow Windows
> to display a "device eject" icon on ports which are routed to an
> external connector bracket.
> 
> However in Redhat Bugzilla #1310682, users report that with kernel 4.4,
> where this bit test first appeared, a lot of partitions on sata drives
> are now mounted automatically.
> 
> This patch should fix redhat and a lot of other distros which
> unconditionally automount all devices which have the "removable"
> bit set.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Applied to libata/for-4.5-fixes w/ stable cc'd.

Thanks.

-- 
tejun
