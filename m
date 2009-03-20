From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Fri, 20 Mar 2009 09:14:55 -0400
Message-ID: <49C396CF.7030202@rtr.ca>
References: <49C1047D.4000008@rtr.ca> <49C11A0C.3070502@rtr.ca> <49C11ED4.2030307@rtr.ca> <49C19087.5000307@gmail.com> <49C190F1.7010202@kernel.org> <49C28133.8050401@rtr.ca> <49C281A5.5080404@rtr.ca> <49C2D642.90706@kernel.org> <49C39690.6090802@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:47078 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbZCTNPC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Mar 2009 09:15:02 -0400
In-Reply-To: <49C39690.6090802@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun,
> 
> I need a way to limit the multi_count to a specific maximum
> value for sata_mv.  ISTR that some PATA chips may also have
> an upper hardware limit on multi_count.
> 
> Generally, "8" is safe for all chipsets.  Going above that
> requires knowledge of what the chipset can tolerate.
> 
> How about a u8 multi_count_max field in the ata_host struct?
> Use 0xff for "multi_count not allowed", and anything else
> in there as an upper limit for the chipset.
..

Oh, and zero means "don't care".  So it's really easy to add
to libata without having to patch each and every driver.

??
