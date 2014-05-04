From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 0/2] ahci: imx: software workaround for phy reset issue
Date: Sun, 4 May 2014 15:05:30 -0400
Message-ID: <20140504190530.GA26279@htj.dyndns.org>
References: <1399211286-8624-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:53080 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbaEDTFe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 May 2014 15:05:34 -0400
Received: by mail-qg0-f41.google.com with SMTP id j107so6903627qga.28
        for <linux-ide@vger.kernel.org>; Sun, 04 May 2014 12:05:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1399211286-8624-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, May 04, 2014 at 09:48:04PM +0800, Shawn Guo wrote:
> Changes since v2:
>  - Have comment for register definition
>  - Use IMX_ instead of IMX_SATA_ for prefix to make it a bit shorter
> 
> Shawn Guo (2):
>   ahci: imx: add namespace for register enums
>   ahci: imx: software workaround for phy reset issue in resume

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
