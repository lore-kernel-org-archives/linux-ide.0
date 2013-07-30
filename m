From: 'Tejun Heo' <tj@kernel.org>
Subject: Re: [PATCH 26/35] ata: use dev_get_platdata()
Date: Tue, 30 Jul 2013 08:59:54 -0400
Message-ID: <20130730125954.GB12016@htj.dyndns.org>
References: <005501ce8cfd$09c47e90$1d4d7bb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:60112 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab3G3M75 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jul 2013 08:59:57 -0400
Received: by mail-qa0-f42.google.com with SMTP id bv4so2320420qab.1
        for <linux-ide@vger.kernel.org>; Tue, 30 Jul 2013 05:59:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <005501ce8cfd$09c47e90$1d4d7bb0$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org

On Tue, Jul 30, 2013 at 05:16:05PM +0900, Jingoo Han wrote:
> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to libata/for-3.12.

Thanks.

-- 
tejun
