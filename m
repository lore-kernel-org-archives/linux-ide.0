From: Tejun Heo <tj@kernel.org>
Subject: Re: [V1] ata: sata_mv:- Handle return value of devm_ioremap.
Date: Fri, 6 Jan 2017 15:46:20 -0500
Message-ID: <20170106204620.GD29909@mtj.duckdns.org>
References: <1481564607-9626-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34783 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbdAFUrA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jan 2017 15:47:00 -0500
Content-Disposition: inline
In-Reply-To: <1481564607-9626-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Dec 12, 2016 at 11:13:27PM +0530, Arvind Yadav wrote:
> Here, If devm_ioremap will fail. It will return NULL.
> Then hpriv->base = NULL - 0x20000; Kernel can run into
> a NULL-pointer dereference. This error check will avoid
> NULL pointer dereference.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to libata/for-4.10-fixes.

Thanks.

-- 
tejun
