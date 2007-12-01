From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 04/12] libata: kill ata_id_to_dma_mode()
Date: Sat, 01 Dec 2007 18:22:07 -0500
Message-ID: <4751EC9F.209@garzik.org>
References: <11961602293422-git-send-email-htejun@gmail.com> <11961602303295-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55724 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbXLAXWJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 18:22:09 -0500
In-Reply-To: <11961602303295-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
> ata_id_to_dma_mode() isn't quite generic.  The function is basically
> privately implemented ata_id_xfermask() combined with hardcoded mode
> printing and configuration which are specific to ata_generic.
> 
> Kill the function and open code it in generic_set_mode() using generic
> xfermode handling functions.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

[responding to Alan's objection, and subsequent thread]

Yeah, it's a matter of taste.  I applied, figuring "in for a dime in for 
a dozen" :)

I'm not thrilled with all these fine-grained exports of timing tables 
and mode mask functions.

I applied the patches, but I would really like to hide more of these 
details away from LLD [if possible, the obvious disclaimed...]

	Jeff



