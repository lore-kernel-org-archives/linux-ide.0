From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to devm_ioremap_resource()"
Date: Wed, 24 May 2017 11:07:21 -0400
Message-ID: <20170524150721.GB24798@htj.duckdns.org>
References: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f171.google.com ([209.85.213.171]:35571 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968341AbdEXPHZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 May 2017 11:07:25 -0400
Received: by mail-yb0-f171.google.com with SMTP id p143so46149880yba.2
        for <linux-ide@vger.kernel.org>; Wed, 24 May 2017 08:07:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

On Wed, May 24, 2017 at 01:39:35AM +0200, Andrew Lunn wrote:
> This reverts commit 368e5fbdfc60732643f34f538823ed4bc8829827.
> 
> devm_ioremap_resource() enforces that there are no overlapping
> resources, where as devm_ioremap() does not. The sata phy driver needs
> a subset of the sata IO address space, so maps some of the sata
> address space. As a result, sata_mv now fails to probe, reporting it
> cannot get its resources, and so we don't have any SATA disks.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied to libata/v4.12-fixes.

Thanks.

-- 
tejun
