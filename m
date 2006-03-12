From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/6] libata: improve xfer mask constants and update ata_mode_string()
Date: Sat, 11 Mar 2006 19:03:58 -0500
Message-ID: <4413656E.1040008@pobox.com>
References: <11415871161551-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:62390 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751311AbWCLAEG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 19:04:06 -0500
In-Reply-To: <11415871161551-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add ATA_BITS_*, ATA_MASK_* macros and reorder xfer_mask fields such
> that higher transfer mode is placed at higher order bit.  As thie
> reordering breaks ata_mode_string(), this patch also rewrites
> ata_mode_string().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-6, please send follow-up patch per comments on patch #2


