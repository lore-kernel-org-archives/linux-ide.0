From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 6/7] libata: fold ata_dev_config() into ata_dev_configure()
Date: Mon, 20 Feb 2006 05:41:21 -0500
Message-ID: <43F99CD1.2010105@pobox.com>
References: <11399954492986-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:60369 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964863AbWBTKl0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 05:41:26 -0500
In-Reply-To: <11399954492986-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_dev_config() needs to be done everytime a device is configured.
> Fold it into ata_dev_configure().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


