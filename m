From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Early ATA devices
Date: Wed, 01 Aug 2007 09:47:49 -0400
Message-ID: <46B08F05.9080306@garzik.org>
References: <20070801014137.4ab39e94@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46384 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762813AbXHANrv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Aug 2007 09:47:51 -0400
In-Reply-To: <20070801014137.4ab39e94@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> #1	We assume identify works. Early ATA actually lists this command
> as optional

ITYM we assume identify command exists on the device?

We certainly do not assume IDENTIFY command, if exists, succeeds.

What is the proper probing method -- notice if command-aborted is 
returned and do something from there?


> #2	We don't allow for INIT_DEV_PARAMS failing which it may do on
> some early IDE pre ATA devices

Suggested handling?  Ignore device, since we don't know what state its 
in, if this fails?


> We check ATA < 4 || non-LBA capable when deciding whether to issue
> INIT_DEV_PARAMS. ATA 4+ however mandate LBA so the second case isn't
> theoretically at least possible.

I agree, though I figured that the current code was more robust, in case 
some weirdo device decided to forget its LBA-ness.

No strong opinions here, though.


> So in theory we can persuade libata to drive original MFM/RLL disks with
> relatively few changes

Crazy :)

	Jeff



