From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 02/03] sata_mv  cosmetic preparations for IRQ coalescing
Date: Wed, 25 Mar 2009 09:45:00 -0400
Message-ID: <49CA355C.9020606@rtr.ca>
References: <49B6EE95.1010808@rtr.ca> <49B6EED8.8060205@rtr.ca> <49C99821.7050404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:37663 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758209AbZCYNpD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Mar 2009 09:45:03 -0400
In-Reply-To: <49C99821.7050404@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
..
>> @@ -1,10 +1,13 @@
>> /*
>>  * sata_mv.c - Marvell SATA support
>>  *
>> - * Copyright 2008: Marvell Corporation, all rights reserved.
>> + * Copyright 2008-2009: Marvell Corporation, all rights reserved.
>>  * Copyright 2005: EMC Corporation, all rights reserved.
>>  * Copyright 2005 Red Hat, Inc.  All rights reserved.
>>  *
>> + * Originally written by Brett Russ.
>> + * Extensive overhaul and enhancement by Mark Lord <mlord@pobox.com>.
..

The above change is only to help people find the right person
to complain to when they have trouble with the driver.
Seeing as Brent hasn't worked on it for many years now,
I figured it needed an update.
 

> I'd like to think my own extensive overhaul, conversion to new EH, 
> preparation for NCQ, 64-bit DMA changes, and work on chip generation 
> separation amounted to something...
..


So why don't you patch a line for yourself into there?
I could always use an extra hand supporting this beast.  ;)

Cheers
