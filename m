From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Failed to set xfermode on LITE-ON  LTR-40125S
Date: Fri, 26 Jan 2007 11:33:14 +0000
Message-ID: <20070126113314.05c22e67@localhost.localdomain>
References: <20070125201750.2adbd57c@buffy.scoobygang>
	<45B97A73.6050703@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41825 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933183AbXAZLVm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jan 2007 06:21:42 -0500
In-Reply-To: <45B97A73.6050703@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: John Williams <john@pond-weed.com>, linux-ide@vger.kernel.org

> Tejun fixed the problem by ATA_FLAG_SETXFER_POLLING for pata_via.
> Maybe the same fix works for pata_sis.
> 
> Could you please try the attached patch, thanks.

I wonder what is really going on here. drivers/ide has some slightly
different handling and notes about problems with some drives. The polling
SETXFER is I fear just hiding the real issue which we've seen on the VIA,
SiS and also with a weird timing fix on the sl8c205

Alan
