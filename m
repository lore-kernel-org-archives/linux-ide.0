From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH #upstream 1/2] libata: relocate forcing PIO0 on reset
Date: Tue, 30 Oct 2007 17:25:26 -0400
Message-ID: <4727A146.7080701@redhat.com>
References: <20071029074109.GO11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:57293 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110AbXJ3VZg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 17:25:36 -0400
In-Reply-To: <20071029074109.GO11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 10/29/2007 03:41 AM, Tejun Heo wrote:
>   retry:
> +	ata_link_for_each_dev(dev, &ap->link) {

How do I backport these loops to 2.6.23?

I see something like this in the old code:

	for (i=0; i < ATA_MAX_DEVICES; i++) {
		dev = &ap->device[i];
                if (!ata_dev_enabled(dev))
                        continue;
		do_something(dev);
	}
