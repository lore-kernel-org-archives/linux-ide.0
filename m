From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: sata_sis and SIS180 in combined mode
Date: Sun, 10 Dec 2006 16:01:47 +0100
Message-ID: <457C215B.2000506@gmx.net>
References: <200612031834.16797.sven@linux4geeks.de>	<45735B51.5040501@gmx.net>	<20061204001114.066b10f3@localhost.localdomain>	<457370CB.60008@gmx.net>	<20061204125637.539c102d@localhost.localdomain>	<4574B968.1070709@gmx.net> <20061205003108.2b22f665@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45316 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760814AbWLJPBv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Dec 2006 10:01:51 -0500
In-Reply-To: <20061205003108.2b22f665@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Sven Ladegast <sven@linux4geeks.de>, uwe.koziolek@web.de, linux-ide@vger.kernel.org

Hello Alan,

The sata_sis.c did not work using the sis_info133 for PATA port:
scsi0: pata_sis
ata1: port disabled. ignoring
ata1: reset failed, giving up

If i have added SATA disks to the controller und using the old code, the
PATA disk is running, because the PATA disk is
using the SATA status from the SATA disk (incorrectly).

> Please push with the SATA driver changes to use it.
>   
I have no idea why the import is not working.
I have removed the static before sis_info133 because the symbol was not
exported.

regards
Uwe

