From: Jeff Garzik <jeff@garzik.org>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Mon, 12 Mar 2007 10:05:21 -0400
Message-ID: <45F55E21.4030208@garzik.org>
References: <45F5465F.6050709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50409 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965874AbXCLOFY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Mar 2007 10:05:24 -0400
In-Reply-To: <45F5465F.6050709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, paul@paulbristow.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Stanislav Brabec <sbrabec@novell.com>

Tejun Heo wrote:
> [libata]
> And, as the device requires custom high level driver, libata fails
> miserably.  Would it be worth to try support these devices?  Or are
> they just too outdated to put the effort in?

What SCSI peripheral device type does it report, when booted under libata?

	Jeff


P.S.  As an aside, this reminds to unpack the SATA tape drive I was 
handed many moons ago, and test it with libata.

