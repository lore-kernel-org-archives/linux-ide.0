From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sat, 28 Apr 2007 16:18:04 -0400
Message-ID: <4633ABFC.1020606@rtr.ca>
References: <4633AB75.7070107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2804 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbXD1USG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 16:18:06 -0400
In-Reply-To: <4633AB75.7070107@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun,
> 
> While working on the new hdparm (version 7.0, released today),
> I ran into trouble when a buggy SG_IO/ATA_16 packet caused
> the libata EH to get confused.
> 
> I triggered this by accident, issuing an IDENTIFY command
> which incorrectly specified ATA_PROT_NODATA.  My error, for sure,
> but libata never recovered from the "stuck DRQ bit" that resulted.
...

This was on 2.6.21, with ata_piix.

Cheers
