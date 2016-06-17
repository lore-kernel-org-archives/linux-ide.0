From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: sata_mv: fix mis-conversion in mv_write_cached_reg()
Date: Fri, 17 Jun 2016 12:15:52 -0400
Message-ID: <20160617161552.GM3262@mtj.duckdns.org>
References: <1465318149-21029-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35325 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbcFQQPz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jun 2016 12:15:55 -0400
Received: by mail-yw0-f196.google.com with SMTP id g20so1586ywb.2
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2016 09:15:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1465318149-21029-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jun 07, 2016 at 05:49:09PM +0100, Ben Dooks wrote:
> Fix the signed issue in mv_write_cached_reg() where the laddr
> is assigned from a (long)addr instead of (unsigned long)addr.
> 
> Fixes the following warnings:
> 
> drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression
> drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression
> drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression
> drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied to libata/for-4.7-fixes.

Thanks.

-- 
tejun
