From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] libata: straighten out ATA_ID_* constants
Date: Tue, 09 Jan 2007 05:42:34 -0500
Message-ID: <45A3719A.1060609@pobox.com>
References: <20070102111849.GD10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33635 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbXAIKmh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Jan 2007 05:42:37 -0500
In-Reply-To: <20070102111849.GD10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> * Kill _OFS suffixes in ATA_ID_{SERNO|FW_REV|PROD}_OFS for consistency
>   with other ATA_ID_* constants.
> 
> * Kill ATA_SERNO_LEN
> 
> * Add and use ATA_ID_SERNO_LEN, ATA_ID_FW_REV_LEN and ATA_ID_PROD_LEN.
>   This change also makes ata_device_blacklisted() use proper length
>   for fwrev.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied patches 1-2 of 3.

patch #3 dropped by your request


