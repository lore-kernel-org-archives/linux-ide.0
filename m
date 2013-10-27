From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Fix display of sata speed
Date: Sun, 27 Oct 2013 07:44:12 -0400
Message-ID: <20131027114412.GG14934@mtj.dyndns.org>
References: <1382743737-3516-1-git-send-email-gwendal@google.com>
 <1382743737-3516-2-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:37853 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab3J0LoQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Oct 2013 07:44:16 -0400
Received: by mail-qa0-f43.google.com with SMTP id i13so1520548qae.2
        for <linux-ide@vger.kernel.org>; Sun, 27 Oct 2013 04:44:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1382743737-3516-2-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: linux-ide@vger.kernel.org

On Fri, Oct 25, 2013 at 04:28:57PM -0700, Gwendal Grignou wrote:
> 6.0 Gbps link speed was not decoded properly:
> speed was reported at 3.0 Gbps only.
> 
> Tested: On a machine where libata reports 6.0 Gbps in
>         /var/log/messages:
>     ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 
>     Before:
>     	cat /sys/class/ata_link/link1/sata_spd
>     	3.0 Gbps
>     After:
>     	cat /sys/class/ata_link/link1/sata_spd
>     	6.0 Gbps
> 
> Signed-off-by: Gwendal Grignou <gwendal@google.com>

Applied to libata/for-3.13 with stable cc'd.

Thanks.

-- 
tejun
