From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_sis: implement laptop list and add ASUS A6K/A6U
Date: Tue, 09 Jan 2007 05:34:34 -0500
Message-ID: <45A36FBA.7010402@pobox.com>
References: <20070108173600.GJ10987@htj.dyndns.org> <20070109000119.GK10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33508 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbXAIKeg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Jan 2007 05:34:36 -0500
In-Reply-To: <20070109000119.GK10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, "Jakub W. Jozwicki" <jakub007@go2.pl>, Andreas Henriksson <andreas@fatal.se>

Tejun Heo wrote:
> From: Jakub W. Jozwicki J <jakub007@go2.pl>
> 
> In ASUS A6K/A6U hdd is connected to SiS 96x via 40c cable, however it
> is short cable and is UDMA66 capable.
> 
> tj: fixed if () conditionals
> ah: fixed infinite loop
> 
> Signed-off-by: Jakub W. Jozwicki <jakub007@go2.pl>
> Cc: Andreas Henriksson <andreas@fatal.se>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> lap++ was missing.  This will result in infinite loop.  Please apply
> this one.  Thanks to Andreas Henriksson for spotting this.

applied


