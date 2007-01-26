From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_via: style clean up, no indirect method call in
 LLD
Date: Fri, 26 Jan 2007 17:24:32 -0500
Message-ID: <45BA7FA0.8070909@pobox.com>
References: <20070125114659.GD8606@htj.dyndns.org> <45B92E07.2040904@pobox.com> <20070126055731.GF8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48956 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbXAZWYe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Jan 2007 17:24:34 -0500
In-Reply-To: <20070126055731.GF8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, j.taimr@chello.nl

Tejun Heo wrote:
> Call ata_bmdma_irq_clear() directly instead of through
> ap->ops->irq_clear() according to libata style guideline.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied to #upstream-fixes


