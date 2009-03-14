From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Off-by-one in both LIBATA and IDE drivers
Date: Sat, 14 Mar 2009 08:48:27 +0000
Message-ID: <20090314084827.2f2b05c2@lxorguk.ukuu.org.uk>
References: <20090313074120.48682.qmail@web4108.mail.ogk.yahoo.co.jp>
	<49BA7172.80908@gmail.com>
	<A88EBC06918A4B0789B55D31ECDAF1BB@DIAMOND8600>
	<49BB1341.2020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50009 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751542AbZCNIrp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 04:47:45 -0400
In-Reply-To: <49BB1341.2020203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Norman Diamond <n0diamond@yahoo.co.jp>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

> ata_piix should definitely attach to 8086/7111 regardless of the 
> subsystem IDs. I can't really explain why it's not. You should at least 
> be seeing a message about the ata_piix version, if not then somehow the 
> driver probe function isn't even being called..

Because on at least some kernels

hda=noprobe ... etc

does not stop the old IDE layer grabbing the PCI device and continuing to
claim ownership (which means ATA cannot attach to it). Arguably this is
correct behaviour as the IDE layer was asked to ignore the devices *NOT*
to ignore the controller.

Alan
