From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_atiixp: Fix IDE detection on SB7xx
Date: Tue, 28 Mar 2017 13:00:48 -0400
Message-ID: <20170328170048.GD28157@htj.duckdns.org>
References: <49ce56dc322.70129c23@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36421 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdC1RA5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Mar 2017 13:00:57 -0400
Received: by mail-yw0-f196.google.com with SMTP id i203so10018932ywc.3
        for <linux-ide@vger.kernel.org>; Tue, 28 Mar 2017 10:00:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49ce56dc322.70129c23@auth.smtp.1and1.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Stevens <darren@stevens-zone.net>
Cc: tourula@gmail.com, linux-ide@vger.kernel.org

Hello,

On Tue, Mar 28, 2017 at 04:57:16PM +0100, Darren Stevens wrote:
> Commit: 5946fdaee4ba(pata_atiixp: Don't use unconnected secondary port on
> SB600/SB700) disabled the check for secondary ports on AMD SB700/710/750
> 
> While these chips have only 1 IDE port, it can be reconfigured on SB7xx
> to appear as a secondary channel, especially when 'Legacy IDE emulation'
> is enabled, breaking IDE detection on some boards with this chipset.
> 
> Fix by removing the check for SB7xx.
> 
> Fixes: 5946fdaee4ba(pata_atiixp: Don't use unconnected secondary port
> on SB600/SB700)
> Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

Hmmm... I can replace the revert with this but can you please explain
why we want this in the commit message?  Also, it'd be nice to cc
Markku and link to his report.

Thanks.

-- 
tejun
