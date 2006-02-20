From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/7] libata: separate out ata_dev_configure()
Date: Mon, 20 Feb 2006 05:37:58 -0500
Message-ID: <43F99C06.8090306@pobox.com>
References: <1139995449220-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:50129 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964858AbWBTKiE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 05:38:04 -0500
In-Reply-To: <1139995449220-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Separate out ata_dev_configure() from ata_dev_identify() such that
> ata_dev_configure() only configures @dev according to passed in @id.
> The function now does not disable device on failure, it just returns
> appropirate error code.
> 
> As this change leaves ata_dev_identify() with only reading ID, calling
> configure and disabling devices according to the results, this patch
> also kills ata_dev_identify() and inlines the logic into
> ata_bus_probe().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


