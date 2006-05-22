From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: pdc20575 and driver 1.04
Date: Mon, 22 May 2006 03:10:43 -0400
Message-ID: <447163F3.6070307@pobox.com>
References: <200605191815.44099.viet@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:64391 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932555AbWEVHKq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 03:10:46 -0400
In-Reply-To: <200605191815.44099.viet@mandriva.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viet@mandriva.com
Cc: linux-ide@vger.kernel.org

viet@mandriva.com wrote:
> Hi Jeff,
> 
> We've briefly met at Deauville while you were working with mandriva
> I hope everything is fine with you - I myself have just been laid off, just about six years after joining mandrake ...
> 
> Anyway, back to business.
> I have a Promise sataII TX2+ cards, with a pdc 20575.
> 
> I have just tried stock 2.6.17-rc4 and applied 2.6.17-rc4-git2-libata1.patch.bz2
> I am only detecting the two sata lines.
> the motherboard is smp, and has pdc20265 onboard. there are 4 drives attached to the TX2+ (two sata, two pata)
> 
> If I am not mistaken, driver version 1.04 is the latest one you have ?

Promise PATA-on-SATA-cards support lives in 
libata-dev.git#promise-sata-pata, until someone cleans it up.

This is not found in 2.6.17-rc4 nor 2.6.17-rc4-git2-libata1.  It is 
found in Andrew Morton's -mm tree, though.

	Jeff



