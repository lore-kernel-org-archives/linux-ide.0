From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 11:58:02 -0500
Message-ID: <43D8FF9A.4020805@pobox.com>
References: <20060126055050.GA4737@htj.dyndns.org> <43D8FBBD.6070205@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:46261 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751317AbWAZQ6m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 11:58:42 -0500
In-Reply-To: <43D8FBBD.6070205@dgreaves.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: Tejun Heo <htejun@gmail.com>, Nicolas.Mailhot@LaPoste.net, Jens Axboe <axboe@suse.de>, Linux-ide <linux-ide@vger.kernel.org>, Christopher Smith <csmith@nighthawkrad.net>, Erik Slagter <erik@slagter.name>, hahn@physics.mcmaster.ca, mlaks@verizon.net, Soeren Sonnenburg <kernel@nn7.de>, mlaks@verizononline.net

David Greaves wrote:
> Have a look for subjects such as
>   Problems with multiple Promise SATA150 TX4 cards

This is almost certainly either a power or PCI bus/slot issue.


>   Possible libata/sata/Asus problem (was Re: Need to upgrade to latest
> stable mdadm version?)

Highly likely to be a motherboard/BIOS issue related to properly tuning 
and timing the hardware.

HOWEVER, libata can help (via Tejun's recent patches) by properly 
handling the error when throw to us by hardware.

	Jeff


