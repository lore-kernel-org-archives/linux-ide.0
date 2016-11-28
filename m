From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: disable port while unloading ATA controller driver
Date: Mon, 28 Nov 2016 13:34:25 -0500
Message-ID: <20161128183425.GA19096@htj.duckdns.org>
References: <20161127231856.11466-1-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34840 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755099AbcK1Se1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Nov 2016 13:34:27 -0500
Received: by mail-qt0-f196.google.com with SMTP id m48so12601731qta.2
        for <linux-ide@vger.kernel.org>; Mon, 28 Nov 2016 10:34:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161127231856.11466-1-vz@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

Hello, Vladimir.

On Mon, Nov 28, 2016 at 01:18:56AM +0200, Vladimir Zapolskiy wrote:
> While removing ATA controller driver ata_port_detach() sets
> ATA_PFLAG_UNLOADING flag and charges the error handler, however actual
> port disabling does not happen due to unset ATA_PFLAG_EH_PENDING flag.
> 
> To take care about clean port removal and ATA_PFLAG_EH_PENDING flag
> setting it is sufficient to replace ata_port_schedule_eh() call with
> ata_port_freeze().

Hmm... this explanation doesn't really make sense to me.
ATA_PFLAG_EH_PENDING is set by at_eh_set_pending() which is the same
for both ata_port_schedule_eh() and ata_port_freeze().  There gotta me
something else going on here.  Any chance you can track down why EH
isn't running?

Thanks.

-- 
tejun
