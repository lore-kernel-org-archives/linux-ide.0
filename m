From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] libata: use local *id instead of dev->id in ata_dev_configure()
Date: Thu, 16 Mar 2006 19:23:55 -0500
Message-ID: <441A019B.3000401@garzik.org>
References: <44144172.9040304@garzik.org> <20060312165701.GA9051@htj.dyndns.org> <44146758.6090006@garzik.org> <20060313053350.GD29870@htj.dyndns.org> <20060313054807.GA24419@htj.dyndns.org> <44150897.1060602@garzik.org> <20060313064016.GA26732@htj.dyndns.org> <44152261.2080203@garzik.org> <20060313104804.GA29996@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:7605 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752451AbWCQAYQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Mar 2006 19:24:16 -0500
In-Reply-To: <20060313104804.GA29996@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> dev->id is used many times in ata_dev_configure().  Use local variable
> id instead for shorter notation.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-2


