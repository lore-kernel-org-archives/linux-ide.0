From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Cleanup ata_read_log_page()
Date: Mon, 10 Jul 2017 13:38:19 -0400
Message-ID: <20170710173818.GB1305447@devbig577.frc2.facebook.com>
References: <20170710054520.24213-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35246 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754602AbdGJRif (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jul 2017 13:38:35 -0400
Received: by mail-qk0-f174.google.com with SMTP id 16so80069739qkg.2
        for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2017 10:38:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170710054520.24213-1-damien.lemoal@wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Hello,

On Mon, Jul 10, 2017 at 02:45:20PM +0900, Damien Le Moal wrote:
> The warning message "READ LOG DMA EXT failed, trying unqueued" in
> ata_read_log_page() as well as the macro name ATA_HORKAGE_NO_NCQ_LOG
> are confusing: the command READ LOG DMA EXT is not an queued NCQ command
> unless it is encapsulated in a RECEIVE FPDMA QUEUED command.
> From ACS-4 READ LOG DMA EXT description:
> 
> "The device processes the READ LOG DMA EXT command in the NCQ feature
> set environment (see 4.13.6) if the READ LOG DMA EXT command is
> encapsulated in a RECEIVE FPDMA QUEUED command (see 7.30) with the
> inputs encapsulated as shown in 7.23.6."
> 
> To avoid confusion, fix the warning messsage to mention switching to PIO and
> not "unqueued" and rename the macro ATA_HORKAGE_NO_NCQ_LOG to
> ATA_HORKAGE_NO_DMA_LOG.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Applied to libata/for-4.13-fixes.

Thanks.

-- 
tejun
