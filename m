From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: mark expected switch fall-throughs
Date: Sat, 21 Oct 2017 09:29:53 -0700
Message-ID: <20171021162953.GT1302522@devbig577.frc2.facebook.com>
References: <20171012191916.GA2974@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46888 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932173AbdJUQ34 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 21 Oct 2017 12:29:56 -0400
Content-Disposition: inline
In-Reply-To: <20171012191916.GA2974@embeddedor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 12, 2017 at 02:19:16PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> In cases where a "drop through" comment was already in place, I replaced
> it  with a proper "fall through" comment, which is what GCC is expecting
> to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Applied to libata/for-4.15.

Thanks.

-- 
tejun
