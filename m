From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: propagate return value of scc_wait_after_reset
Date: Sun, 17 Aug 2014 07:10:42 -0400
Message-ID: <20140817111042.GN9305@htj.dyndns.org>
References: <53ef6157.qX8Csumbm2zNx/EI%fengguang.wu@intel.com>
 <1408198684-2258-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:45653 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbaHQLKq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2014 07:10:46 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so3411687qap.23
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2014 04:10:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408198684-2258-1-git-send-email-arjun024@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjun Sreedharan <arjun024@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, Aug 16, 2014 at 07:48:04PM +0530, Arjun Sreedharan wrote:
> scc_bus_softreset not necessarily should return zero.
> Propagate the error code.
> 
> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>

I reverted the change yesterday but didn't have time to reply.  Don't
send patches you haven't even compile tested.  This is the most basic
of your responsibilities when sending out patches.  Okay?

Applying the updated version to libata/for-3.17-fixes.

-- 
tejun
