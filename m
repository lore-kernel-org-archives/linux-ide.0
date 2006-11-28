From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: do not powerdown during initialization
Date: Tue, 28 Nov 2006 04:15:28 -0500
Message-ID: <456BFE30.2010602@pobox.com>
References: <20061120064236.GM2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29827 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935744AbWK1JPd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:15:33 -0500
In-Reply-To: <20061120064236.GM2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, flyboy@gmail.com

Tejun Heo wrote:
> ahci_init_controller() calls ahci_deinit_port() to make sure the
> controller is stopped before initializing the controller.  In turn,
> ahci_deinit_port() invokes ahci_power_down() to power down the port.
> If the controller supports slumber mode, the link is put into it.

I would rather just pass a 'dont suspend port' flag to 
ahci_deinit_port().  That leaves ahci_port_stop() behavior unchanged.


