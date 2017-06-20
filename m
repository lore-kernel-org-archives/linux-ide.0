From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: make function name in comment be matched with
 its own.
Date: Tue, 20 Jun 2017 13:37:02 -0400
Message-ID: <20170620173702.GC21326@htj.duckdns.org>
References: <1497954090-8130-1-git-send-email-dn3108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f172.google.com ([209.85.213.172]:36557 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbdFTRhE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2017 13:37:04 -0400
Received: by mail-yb0-f172.google.com with SMTP id t7so39416830yba.3
        for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2017 10:37:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1497954090-8130-1-git-send-email-dn3108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Minwoo Im <dn3108@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, Jun 20, 2017 at 07:21:30PM +0900, Minwoo Im wrote:
> the function name in comment used to be ata_scsiop_mode_select() for
> ata_scsi_mode_select_xlat(). function comment has been updated.
> 
> Signed-off-by: Minwoo Im <dn3108@gmail.com>

Applied to libata/for-4.13.

Thanks.

-- 
tejun
