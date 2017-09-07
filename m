From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] [RESEND] ata: avoid gcc-7 warning in ata_timing_quantize
Date: Thu, 7 Sep 2017 13:34:17 -0700
Message-ID: <20170907203417.GT1774378@devbig577.frc2.facebook.com>
References: <20170906214552.2111904-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33617 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756007AbdIGUeW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 7 Sep 2017 16:34:22 -0400
Content-Disposition: inline
In-Reply-To: <20170906214552.2111904-1-arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 06, 2017 at 11:45:34PM +0200, Arnd Bergmann wrote:
> gcc-7 warns about the result of a constant multiplication used as
> a boolean:
> 
> drivers/ata/libata-core.c: In function 'ata_timing_quantize':
> drivers/ata/libata-core.c:3164:30: warning: '*' in boolean context, suggest '&&' instead [-Wint-in-bool-context]
> 
> This slightly rearranges the macro to simplify the code and avoid
> the warning at the same time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Hi Tejun,
> 
> I just noticed this patch among others I had previously sent
> but that were not applied. It seems I forgot to reply to your
> Ack after it had become clear that the serious would not
> get merged in one chunk. Please apply this for 4.14.

My bad. I'm sorry. Applied to libata/for-4.14-fixes.

Thanks.

-- 
tejun
