From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/4] libata: make per-dev transfer mode limits per-dev
Date: Mon, 13 Mar 2006 03:30:41 -0500
Message-ID: <44152DB1.1020502@pobox.com>
References: <11421469561848-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:29665 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932364AbWCMIar (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 03:30:47 -0500
In-Reply-To: <11421469561848-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Now that each ata_device has xfer masks, per-dev limits can be made
> per-dev instead of per-port.  Make per-dev limits per-dev.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Doesn't this patch break stuff?  As you said in a previous patch, the 
per-dev masks aren't used yet?

	Jeff



