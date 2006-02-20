From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] libata: re-initialize parameters before configuring
Date: Mon, 20 Feb 2006 05:49:00 -0500
Message-ID: <43F99E9C.2000208@pobox.com>
References: <11399977653668-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:16338 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964867AbWBTKtD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 05:49:03 -0500
In-Reply-To: <11399977653668-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> In ata_dev_configure(), reinitialize parameters before configuring.
> This change is for revalidation and hotplug.  As ata_dev_configure()
> can be entered multiple times, parameters need to be reinitialized.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


