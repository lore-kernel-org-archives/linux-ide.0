From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/6] libata: seperate out ata_class_present()
Date: Fri, 03 Mar 2006 15:40:48 -0500
Message-ID: <4408A9D0.4090200@pobox.com>
References: <11411439381562-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:21906 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932250AbWCCUk4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 15:40:56 -0500
In-Reply-To: <11411439381562-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Seperate out ata_class_present() from ata_dev_present().  This is
> useful because new reset mechanism deals with classes[] directly.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-5


