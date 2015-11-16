From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Ordered SATA device IDs codename Lewisburg
Date: Mon, 16 Nov 2015 11:25:53 -0500
Message-ID: <20151116162553.GG18894@mtj.duckdns.org>
References: <1446854976-9936-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33959 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbbKPQZ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Nov 2015 11:25:56 -0500
Received: by ykfs79 with SMTP id s79so248414613ykf.1
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2015 08:25:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1446854976-9936-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On Fri, Nov 06, 2015 at 04:09:36PM -0800, Alexandra Yates wrote:
> This change was to preserve the ascending order of device IDs.
> There was an exception with the first two Lewisburg device IDs to
> keep all device IDs of the same kind grouped by code name.
> 
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>

Applied to libata/for-4.4-fixes.

Thanks.

-- 
tejun
