From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_octeon_cf: use of_property_read_{bool|u32}()
Date: Mon, 28 Aug 2017 10:45:03 -0700
Message-ID: <20170828174502.GX491396@devbig577.frc2.facebook.com>
References: <20170827195613.904715064@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37343 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdH1RpH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2017 13:45:07 -0400
Received: by mail-qt0-f194.google.com with SMTP id g13so1021961qta.4
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2017 10:45:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170827195613.904715064@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "\"open list:LIBATA PATA DRIVERS\"" <linux-ide@vger.kernel.org>, linux-mips@linux-mips.org

On Sun, Aug 27, 2017 at 10:55:09PM +0300, Sergei Shtylyov wrote:
> The Octeon CF driver basically  open-codes of_property_read_{bool|u32}()
> using  of_{find|get}_property() calls in its  probe() method.  Using the
> modern DT APIs saves 2 LoCs and 16 bytes of object code (MIPS gcc 3.4.3).
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to libata/for-4.14.

Thanks.

-- 
tejun
