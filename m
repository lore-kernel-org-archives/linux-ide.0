From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_sis and SIS180 in combined mode
Date: Mon, 4 Dec 2006 00:11:14 +0000
Message-ID: <20061204001114.066b10f3@localhost.localdomain>
References: <200612031834.16797.sven@linux4geeks.de>
	<45735B51.5040501@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:45285 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1760157AbWLDAEQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Dec 2006 19:04:16 -0500
In-Reply-To: <45735B51.5040501@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Sven Ladegast <sven@linux4geeks.de>, uwe.koziolek@web.de, linux-ide@vger.kernel.org

On Mon, 04 Dec 2006 00:18:41 +0100
Uwe Koziolek <uwe.koziolek@gmx.net> wrote:

> Because you are only using the PATA port, you can make a private
> solution, move the PCI-ID 180 from  sata_sis.c  to  sis5513.c  or 
> pata_sis.c
> dependend on the ide driver you want to use.
> 
> The SiS180 has no hardware RAID functionality, It is only a BIOS based
> software raid. The SiS180 is a combined  SATA/PATA controller.
> 
> I will try a patch for this issue.

Are both ports off the same set of PCI resources ? If not then it would
be better to put a set of entry points into pata_sis that allow sata_sis
to "plug in" pata support. I'm happy to help hack on this given enough
info.

Alan
