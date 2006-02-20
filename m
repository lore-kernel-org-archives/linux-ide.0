From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/7] libata: update ata_dev_init_params()
Date: Mon, 20 Feb 2006 05:13:59 -0500
Message-ID: <43F99667.4090405@pobox.com>
References: <11399954491573-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:51408 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964830AbWBTKOJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 05:14:09 -0500
In-Reply-To: <11399954491573-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Update ata_dev_init_params() such that it doesn't disable port
> directly but return with appropriate error mask on failure.  This is
> preparation for splitting ata_dev_identify().  Note that this patch
> changes behavior of dev_init_params failure such that only failing
> devices are taken offline not the whole port.  This change is
> intended.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


