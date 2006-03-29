From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2.6.16] sata_mv.c :: three bug fixes
Date: Wed, 29 Mar 2006 12:37:22 -0500
Message-ID: <442AC5D2.2080209@rtr.ca>
References: <200603290950.32219.lkml@rtr.ca> <20060329170628.GA25640@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:65254 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750893AbWC2Rhb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Mar 2006 12:37:31 -0500
In-Reply-To: <20060329170628.GA25640@localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Aloni <da-x@monatomic.org>
Cc: Mark Lord <lkml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, sander@humilis.net, dror@xiv.co.il

Dan Aloni wrote:

> The original code checks ap for NULL, are you sure it is safe to
> remove this?

"ap" is used above in the same function, long before the check for NULL,
so the checks lower down are worthless.

Cheers

