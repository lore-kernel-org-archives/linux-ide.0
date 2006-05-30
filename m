From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/13] sata_sil: convert to new probing mechanism and
 add hotplug support
Date: Tue, 30 May 2006 00:26:17 -0400
Message-ID: <447BC969.3060301@pobox.com>
References: <11488847363047-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38628 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751485AbWE3E0f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:26:35 -0400
In-Reply-To: <11488847363047-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert to new probing mechanism and add hotplug support by enabling
> SATA IRQ for SError.N, marking ehi for hotplug and scheduling EH on
> SATA IRQs.
> 
> Sil3112/3512/3114 family of controllers use COMRESET as TF clearing
> point and can reliably wait for FIS34 after COMRESET whether the FIS
> is the first FIS34 after POR or in response to the COMRESET.  Thus,
> setting ATA_FLAG_HRST_TO_RESUME is enough for device detection after
> hotplug.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

What is FIS34?  I've never heard of that...   :)

ACK patch 8, and the content of this patch (#9)

