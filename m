From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_sis and SIS180 in combined mode
Date: Sun, 10 Dec 2006 15:51:29 +0000
Message-ID: <20061210155129.08f32084@localhost.localdomain>
References: <200612031834.16797.sven@linux4geeks.de>
	<45735B51.5040501@gmx.net>
	<20061204001114.066b10f3@localhost.localdomain>
	<457370CB.60008@gmx.net>
	<20061204125637.539c102d@localhost.localdomain>
	<4574B968.1070709@gmx.net>
	<20061205003108.2b22f665@localhost.localdomain>
	<457C215B.2000506@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56944 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761276AbWLJPnz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Dec 2006 10:43:55 -0500
In-Reply-To: <457C215B.2000506@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Sven Ladegast <sven@linux4geeks.de>, uwe.koziolek@web.de, linux-ide@vger.kernel.org

On Sun, 10 Dec 2006 16:01:47 +0100
Uwe Koziolek <uwe.koziolek@gmx.net> wrote:

> Hello Alan,
> 
> The sata_sis.c did not work using the sis_info133 for PATA port:
> scsi0: pata_sis
> ata1: port disabled. ignoring

That sort of makes sense. The sis_info133 will check the enable bits on
the basis that its a pata port. What port port number do you pass - I
assume 2 - that runs off the end of the array. Tweak sis_133_pre_reset
and try that.
