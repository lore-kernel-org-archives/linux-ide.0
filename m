From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/2] ata: mediatek: add support for MediaTek SATA
 controller
Date: Sun, 13 Aug 2017 11:38:54 -0700
Message-ID: <20170813183854.GA1438922@devbig577.frc2.facebook.com>
References: <cover.1502501342.git.ryder.lee@mediatek.com>
 <cf04d6bf9cf27911023b962ccd8639f063d32739.1502501342.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34832 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdHMSjA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 13 Aug 2017 14:39:00 -0400
Content-Disposition: inline
In-Reply-To: <cf04d6bf9cf27911023b962ccd8639f063d32739.1502501342.git.ryder.lee@mediatek.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>

On Sat, Aug 12, 2017 at 09:31:03AM +0800, Ryder Lee wrote:
> This adds support the AHCI-compliant Serial ATA controller present
> on MediaTek SoCs.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Looks good to me.

 Acked-by: Tejun Heo <tj@kernel.org>

If others are okay with it, please let me know how the patches should
be routed.  I can push both through libata, both can be routed through
dt tree, or we can handle them separately.

Thanks.

-- 
tejun
