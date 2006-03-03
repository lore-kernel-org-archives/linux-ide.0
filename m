From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 6/6] ata_piix: don't scan non-existent device
Date: Fri, 03 Mar 2006 15:43:00 -0500
Message-ID: <4408AA54.7080509@pobox.com>
References: <11411439392891-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:27538 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932347AbWCCUnG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 15:43:06 -0500
In-Reply-To: <11411439392891-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_std_softreset() sometimes reports presence of dev 1 even when it
> doesn't exist (PCS-wise).  This usually happens reading dev 1's
> signature returns that of dev 0 (e.g. on ICH6M).  This patch turns off
> non-existent device on such cases.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

I'm going to NAK this one for now.  This doesn't smell like a 
piix-specific behavior.  Perhaps there is a device selection bug in 
libata core.

	Jeff



