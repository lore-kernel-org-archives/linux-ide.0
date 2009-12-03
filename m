From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 03 Dec 2009 12:39:48 -0500
Message-ID: <4B17F7E4.9040302@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost>	<4B1771CD.3090409@garzik.org> <20091203165947.13841802@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:33306 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZLCRjn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 12:39:43 -0500
In-Reply-To: <20091203165947.13841802@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/03/2009 11:59 AM, Alan Cox wrote:
>> The merge window is upon us, which by strict rules means that anything
>> not already in libata-dev.git#upstream needs to wait until 2.6.34.
>
> Not quite yet - Linus hasn't said "go"

He rarely if ever says "go."  The kernel X is released, and people send 
pull requests to Linus for X+1.  He typically merges immediately, but 
does not push out the first set of merges for a few days.

The stuff pushed to Linus for kernel X+1 should have already been living 
in linux-next (libata-dev.git#NEXT, to us).


> The bits that probably should be delayed a bit more (if any) IMHO are the
> 32bit enables for hardware that doesn't use 32bit by default on the
> drivers/ide stack, and tweaks for obscure old hardware that won't get
> much testing.

Agreed mostly...  I still want to push fixes even if for obscure hardware.

	Jeff



