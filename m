From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libahci: wrong comments in ahci_do_softreset()
Date: Mon, 12 Jun 2017 14:08:15 -0400
Message-ID: <20170612180815.GF19206@htj.duckdns.org>
References: <1497192780-7772-1-git-send-email-dn3108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f178.google.com ([209.85.213.178]:36212 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdFLSIR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2017 14:08:17 -0400
Received: by mail-yb0-f178.google.com with SMTP id t7so546407yba.3
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2017 11:08:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1497192780-7772-1-git-send-email-dn3108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Minwoo Im <dn3108@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, Jun 11, 2017 at 11:53:00PM +0900, Minwoo Im wrote:
> AHCI 1.3.1 Spec says that software shall build two H2D register
> FISes in the command list to send a software reset.
> The comments in ahci_do_softreset() is currently D2H instead of H2D.
> 
> Signed-off-by: Minwoo Im <dn3108@gmail.com>

Applied to libata/for-4.13.

Thanks.

-- 
tejun
