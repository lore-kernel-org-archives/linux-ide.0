From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/14] ahci: separate out ahci_stop/start_engine()
Date: Mon, 19 Dec 2005 00:33:24 -0500
Message-ID: <43A64624.8040106@pobox.com>
References: <20051218133305.GA31571@htj.dyndns.org> <20051218134822.GK31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:13445 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030275AbVLSFda (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 00:33:30 -0500
In-Reply-To: <20051218134822.GK31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Separate out ahci_stop/start_engine() from ahci_restart_port().  This
> is preparation for conversion to new reset mechanism.

this sort of patch should be sent first, since it is "easy to apply" 
even though I might disagree with earlier patches in the series.

	jeff



