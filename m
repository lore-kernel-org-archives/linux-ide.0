From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: replace strict_strtol() with kstrtol()
Date: Mon, 22 Jul 2013 16:15:39 -0400
Message-ID: <20130722201539.GC4042@mtj.dyndns.org>
References: <000901ce844d$1fa1aac0$5ee50040$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:50254 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756932Ab3GVUPo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jul 2013 16:15:44 -0400
Received: by mail-qe0-f43.google.com with SMTP id q19so3991084qeb.16
        for <linux-ide@vger.kernel.org>; Mon, 22 Jul 2013 13:15:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <000901ce844d$1fa1aac0$5ee50040$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org

On Fri, Jul 19, 2013 at 03:56:41PM +0900, Jingoo Han wrote:
> The usage of strict_strtol() is not preferred, because
> strict_strtol() is obsolete. Thus, kstrtol() should be
> used.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to libata/for-3.11-fixes.

Thanks!

-- 
tejun
