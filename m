From: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v4 1/2] ata: mediatek: add support for MediaTek SATA
 controller
Date: Tue, 29 Aug 2017 08:59:51 +0800
Message-ID: <1503968391.27007.1.camel@mtkswgap22>
References: <cover.1503018631.git.ryder.lee@mediatek.com>
         <ab78899bd7fa99a12497b5b16ffb7acfeac1f42c.1503018631.git.ryder.lee@mediatek.com>
         <20170828175528.GY491396@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:58570 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750812AbdH2A77 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2017 20:59:59 -0400
In-Reply-To: <20170828175528.GY491396@devbig577.frc2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>

On Mon, 2017-08-28 at 10:55 -0700, Tejun Heo wrote:
> On Fri, Aug 18, 2017 at 09:13:07AM +0800, Ryder Lee wrote:
> > This adds support the AHCI-compliant Serial ATA controller present
> > on MediaTek SoCs.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Acked-by: Tejun Heo <tj@kernel.org>
> 
> Applied to libata/for-4.14.  If you want me to take the dt patch too,
> please let me know.
> 
> Thanks.
> 

Yes, please take the dt patch through your tree as well.

Thanks,
Ryder

