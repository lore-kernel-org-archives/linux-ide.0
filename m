From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: remove IRQ mask clearing from init_controller()
Date: Tue, 08 Aug 2006 23:51:53 -0400
Message-ID: <44D95BD9.7030702@pobox.com>
References: <20060807023904.GA28202@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32411 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030451AbWHIDv4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Aug 2006 23:51:56 -0400
In-Reply-To: <20060807023904.GA28202@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Initial IRQ mask clearing is done by libata-core by freezing all ports
> prior to requesting IRQ.  Remove redundant IRQ clearing from
> init_controller().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

is this for upstream (2.6.19) or upstream-fixes (2.6.18-rc)?

	Jeff



