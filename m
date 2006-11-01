From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream-fixes] ahci: fix status register check in ahci_softreset
Date: Wed, 01 Nov 2006 04:21:06 -0500
Message-ID: <45486702.5080704@pobox.com>
References: <20061101081918.GO13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:27109 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946721AbWKAJVK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 04:21:10 -0500
In-Reply-To: <20061101081918.GO13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ahci_softreset() used to use ahci_tf_read() which reads D2H_REG area
> to check for the Status register.  However, this area is zeroed on
> initialization and not set by initial signature FIS.  Replace it with
> ahci_check_status().
> 
> This bug prevented CLO code from being activated whenever BSY and/or
> DRQ is set prior to softreset.  This fix makes
> AHCI_FLAG_RESET_NEEDS_CLO flag redundant.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


