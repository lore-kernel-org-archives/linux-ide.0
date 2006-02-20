From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: minor fix for 2.6.16 (respin)
Date: Mon, 20 Feb 2006 06:16:40 -0500
Message-ID: <43F9A518.7090100@pobox.com>
References: <43F0659D.9000109@tw.ibm.com> <43F2C524.6030705@gmail.com> <43F2D076.4080207@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:40659 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932467AbWBTLQo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 06:16:44 -0500
In-Reply-To: <43F2D076.4080207@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Jeff,
> 
> Respin two minor fixes from libata-dev tree that might be good for 2.6.16:
>  - Fix the array index value in ata_rwcmd_protocol() for the added FUA commands.
>    (This only affects some VIA PATA adapters. Other hardware is safe from this bug.)
>  - Filter out ATAPI packet command error messages in ata_pio_error()
> 
> Patch against the libata-dev upstream branch
> (f1b318793dcd2d9ff6b5ac06e7762098fa079cee).
> For your review, thanks.

I pulled this in via upstream-fixes, please confirm that #upstream and 
#irq-pio look OK...

	Jeff



