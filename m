From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/4] pata: imx: set timings for PIO modes up to PIO4
Date: Wed, 9 Nov 2016 11:49:51 -0500
Message-ID: <20161109164951.GB14630@htj.duckdns.org>
References: <20161109005638.17691-1-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33842 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbcKIQty (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Nov 2016 11:49:54 -0500
Received: by mail-yw0-f171.google.com with SMTP id t125so211170234ywc.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Nov 2016 08:49:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161109005638.17691-1-vz@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

On Wed, Nov 09, 2016 at 02:56:34AM +0200, Vladimir Zapolskiy wrote:
> The changeset adds support of PIO modes up to PIO4 by setting
> necessary timings in the driver, before the change it is assumed
> that the timings are always set by a bootloader once and thus
> only one possible PIO mode has been supported (PIO0). With
> this change the driver can be used on boards without ATA controller
> configuration done by a bootloader.
> 
> The change is tested on a legacy i.MX31 board with an HDD connected
> by a 40-pin flat cable.

Applied to libata/for-4.10.

Thanks.

-- 
tejun
