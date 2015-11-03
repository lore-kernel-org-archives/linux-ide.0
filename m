From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] ide: pdc202xx_new: Replace timeval with ktime_t
Date: Tue, 03 Nov 2015 11:51:24 -0500 (EST)
Message-ID: <20151103.115124.718690114491913916.davem@davemloft.net>
References: <20151022124550.GA18694@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:45424 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbbKCQv3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Nov 2015 11:51:29 -0500
In-Reply-To: <20151022124550.GA18694@amitoj-Inspiron-3542>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: amitoj1606@gmail.com
Cc: outreachy-kernel@googlegroups.com, y2038@lists.linaro.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Date: Thu, 22 Oct 2015 18:15:50 +0530

> This driver uses 'struct timeval' which we are trying to remove since
> 32 bit time types will break in the year 2038 by replacing it with
> ktime_t.
> 
> This patch changes do_gettimeofday() to ktime_get() because
> ktime_get() returns a ktime_t while do_gettimeofday() returns struct
> timeval.
> 
> This patch also uses ktime_us_delta() to get the elapsed time.
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
> Changes in v2:
>         -Modified subject of commit message

Applied, thanks.
