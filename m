From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.19-rc6][RESEND] ata_piix: IDE mode SATA patch for
 Intel ICH9
Date: Wed, 22 Nov 2006 10:22:41 +0900
Message-ID: <4563A661.3070908@gmail.com>
References: <200611211653.51596.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:17302 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966996AbWKVBWu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 20:22:50 -0500
Received: by ug-out-1314.google.com with SMTP id e2so38483ugf
        for <linux-ide@vger.kernel.org>; Tue, 21 Nov 2006 17:22:49 -0800 (PST)
In-Reply-To: <200611211653.51596.jason.d.gaston@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jason Gaston wrote:
> This patch adds the Intel ICH9 IDE mode SATA controller DID's.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> --- linux-2.6.19-rc6/drivers/ata/ata_piix.c.orig	2006-11-20 04:58:48.000000000 -0800
> +++ linux-2.6.19-rc6/drivers/ata/ata_piix.c	2006-11-20 06:15:12.000000000 -0800

Yeap, it came through fine this time, but ich8 and ich9 are identical 
from ata_piix's point of view.  Don't add ich9_sata_ahci, just use 
ich8_sata_ahci.

-- 
tejun
