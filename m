From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ide: revert "ide: fix drive side 80c cable check, take
 2" for now
Date: Wed, 21 Mar 2007 11:15:33 +0900
Message-ID: <46009545.6060908@gmail.com>
References: <200703202154.13211.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:56172 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbXCUCPi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Mar 2007 22:15:38 -0400
Received: by nz-out-0506.google.com with SMTP id s1so64976nze
        for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 19:15:37 -0700 (PDT)
In-Reply-To: <200703202154.13211.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Bartlomiej Zolnierkiewicz wrote:
> [PATCH] ide: revert "ide: fix drive side 80c cable check, take 2" for now
> 
> "ide: fix drive side 80c cable check, take 2" patch from Tejun Heo (commit
> fab59375b9543f84d1714f7dd00f5d11e531bd3e) fixed 80c bit test (bit13 of word93)
> but we also need to fix master/slave IDENTIFY order (slave device should be
> probed first in order to make it release PDIAG- signal) and we should also
> check for pre-ATA3 slave devices (which may not release PDIAG- signal).
> 
> [ Unfortunately the fact that IDE driver doesn't reset devices itself helps
>   only a bit as it seems that some BIOS-es reset ATA devices after programming
>   the chipset, some BIOS-es can be set to not probe/configure selected devices,
>   there may be no BIOS in case of add-on cards etc. ]
> 
> Since we are quite late in the release cycle and the required changes will
> affect a lot of systems just revert the fix for now.
> 
> [ Please also see libata commit f31f0cc2f0b7527072d94d02da332d9bb8d7d94c. ]
> 
> Thanks goes out to Fernando Mitio Yamada for reporting the problem
> and patiently testing patches.
> 
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Ackec-by: Tejun Heo <htejun@gmail.com>

Never suspected it could cause this much problem.  :-(

-- 
tejun
