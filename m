From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/4] pata_platform: Remove useless irq_flags field
Date: Sat, 23 Aug 2014 13:06:43 -0400
Message-ID: <20140823170643.GD13540@mtj.dyndns.org>
References: <1408790747-30251-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34670 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbaHWRGr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2014 13:06:47 -0400
Received: by mail-qg0-f44.google.com with SMTP id e89so11542191qgf.17
        for <linux-ide@vger.kernel.org>; Sat, 23 Aug 2014 10:06:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408790747-30251-1-git-send-email-shc_work@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-ide@vger.kernel.org, Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net

On Sat, Aug 23, 2014 at 02:45:47PM +0400, Alexander Shiyan wrote:
> IRQ flags can be obtained from resource structure, there are no need
> to use additional field in the platform_data to store these values.
> This patch removes this field and convert existing users of this driver
> to use IRQ flags from the resources.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied to libata/for-3.18.

Thanks.

-- 
tejun
