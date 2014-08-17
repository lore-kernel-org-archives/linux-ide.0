From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: propagate return value of scc_wait_after_reset
Date: Sun, 17 Aug 2014 09:07:27 -0400
Message-ID: <20140817130727.GA7679@mtj.dyndns.org>
References: <53ef6157.qX8Csumbm2zNx/EI%fengguang.wu@intel.com>
 <1408198684-2258-1-git-send-email-arjun024@gmail.com>
 <20140817111042.GN9305@htj.dyndns.org>
 <20140817112705.GO9305@htj.dyndns.org>
 <CAJFMrCEdrqWvktexp5nFooz1UdSE4yZ+F15NnaZ5E9p7_z_iqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33527 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaHQNHc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2014 09:07:32 -0400
Received: by mail-qg0-f41.google.com with SMTP id z107so205206qgd.0
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2014 06:07:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJFMrCEdrqWvktexp5nFooz1UdSE4yZ+F15NnaZ5E9p7_z_iqQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjun Sreedharan <arjun024@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, Aug 17, 2014 at 05:31:53PM +0530, Arjun Sreedharan wrote:
> Also now i feel @err_mask is better.
> I rest my case further. Thanks.

The thing is err_mask is used in libata to carry AC_ERR_* values not
0/-errno's, so it's confusing to use it for that.  Can you please
refresh the patch w/ variable rename?

Thanks.

-- 
tejun
