From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: fix a couple of doc build warnings
Date: Mon, 31 Jul 2017 08:03:54 -0700
Message-ID: <20170731150354.GA447614@devbig577.frc2.facebook.com>
References: <20170730161604.16e00c29@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37396 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbdGaPD7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2017 11:03:59 -0400
Received: by mail-qt0-f196.google.com with SMTP id d10so17203816qtb.4
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2017 08:03:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170730161604.16e00c29@lwn.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-ide@vger.kernel.org

On Sun, Jul 30, 2017 at 04:16:04PM -0600, Jonathan Corbet wrote:
> The kerneldoc comments for a couple of functions in drivers/ata/libata-eh.c
> had fallen behind the current implementation, resulting in these doc build
> warnings:
> 
>   ./drivers/ata/libata-eh.c:1449: warning: No description found for parameter 'link'
>   ./drivers/ata/libata-eh.c:1449: warning: Excess function parameter 'ap' description in 'ata_eh_done'
>   ./drivers/ata/libata-eh.c:1590: warning: No description found for parameter 'qc'
>   ./drivers/ata/libata-eh.c:1590: warning: Excess function parameter 'dev' description in 'ata_eh_request_sense'
> 
> Update the comments and make the warnings go away.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Applied to for-4.13-fixes.

Thanks.

-- 
tejun
