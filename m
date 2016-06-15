From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: fix return value check in
 ahci_seattle_get_port_info()
Date: Wed, 15 Jun 2016 14:31:21 -0400
Message-ID: <20160615182752.GK24102@mtj.duckdns.org>
References: <1465864009-26774-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34180 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161084AbcFOScD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2016 14:32:03 -0400
Received: by mail-yw0-f181.google.com with SMTP id c72so21452247ywb.1
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2016 11:32:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1465864009-26774-1-git-send-email-weiyj_lk@163.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: weiyj_lk@163.com
Cc: Brijesh Singh <brijesh.singh@amd.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-ide@vger.kernel.org

On Tue, Jun 14, 2016 at 12:26:49AM +0000, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_kzalloc() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied to libata/for-4.7-fixes.

Thanks.

-- 
tejun
