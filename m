From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Fri, 10 Aug 2007 19:36:25 +0400
Message-ID: <46BC85F9.1040903@ru.mvista.com>
References: <200708052245.16406.sshtylyov@ru.mvista.com> <200708092248.44675.bzolnier@gmail.com> <20070809235213.391ab6c9@the-village.bc.nu> <200708100152.32753.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55491 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763944AbXHJPeP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Aug 2007 11:34:15 -0400
In-Reply-To: <200708100152.32753.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, rah@bash.sh

Bartlomiej Zolnierkiewicz wrote:

>>> * This driver is heavily based upon:
>>> *
>>> * linux/drivers/ide/pci/hpt366.c               Version 0.36    April 25, 2003
>>> *
>>>reference to hpt366 version should also be updated (or removed)

>>Disagree - its not based on the newer hpt366 driver. Its based on the old

> But this patch has just updated copyright references to match with the new
> driver while the version still matches the old one!

    Err... I've updated the copyright to reflect that I've done some changes 
to these drivers as well...

>>one. Actually by now it bears almost no resemblence any of them

> Indeed, unfortunately...

    :-)

> Bart

MBR, Sergei
