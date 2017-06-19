From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: do not initialise statics to 0 ERROR fix.
Date: Mon, 19 Jun 2017 13:38:35 -0400
Message-ID: <20170619173835.GA12062@htj.duckdns.org>
References: <1497682984-5554-1-git-send-email-dn3108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:35339 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdFSRii (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jun 2017 13:38:38 -0400
Received: by mail-yb0-f176.google.com with SMTP id f192so30200224yba.2
        for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2017 10:38:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1497682984-5554-1-git-send-email-dn3108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Minwoo Im <dn3108@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Sat, Jun 17, 2017 at 04:03:04PM +0900, Minwoo Im wrote:
> ERROR: do not initialise statics to 0 in four lines in libata-core.c.
> Signed-off-by: Minwoo Im <dn3108@gmail.com>

I don't think there's much value in sweeping the code base with
checkpatch.  We can fix them when changing code around them or there's
a meaningful gain from it (e.g. doc updates which improve doc
processing) but otherwise I think it's churns for churns' sake.

Thanks.

-- 
tejun
