From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc7 3/3] libata: pata_via CX700 quirks
Date: Thu, 5 Jul 2007 13:34:07 +0100
Message-ID: <20070705133407.21977a92@the-village.bc.nu>
References: <20070705043127.GX29122@htj.dyndns.org>
	<20070705043501.GY29122@htj.dyndns.org>
	<20070705043949.GZ29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60821 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754304AbXGEM1v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 08:27:51 -0400
In-Reply-To: <20070705043949.GZ29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Thu, 5 Jul 2007 13:39:49 +0900
Tejun Heo <htejun@gmail.com> wrote:

> For some reason, via decided that combined SATA/PATA setup in sata_via
> isn't good enough and added a SATA port without SCR access to CX700.

(It seems to be an integrated PATA/SATA bridge of some sort)

> For yet another unknown reason, slave slot of the SATA port dislikes
> SETXFER.
> 
> This patch implements two quirks for CX700 - VIA_SATA_PATA and
> VIA_BAD_SLAVE_SETXFER.  SATA_PATA indicates that the first port is
> SATA and BAD_SLAVE_SETXFER indicates slave port may fail SETXFER.

This makes no sense. If the SETXFER failed how did the device get into
the mode it is in ? How will change down work ? Why does the old IDE
driver work ?

I think this needs a lot more explanation

NAK

