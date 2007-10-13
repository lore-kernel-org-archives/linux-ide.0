From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE updates (part 2)
Date: Sun, 14 Oct 2007 00:41:25 +0200
Message-ID: <200710140041.25152.bzolnier@gmail.com>
References: <200710131825.24768.bzolnier@gmail.com> <200710140009.06260.bzolnier@gmail.com> <20071013232922.3ff6a464@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:51895 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbXJMWgP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 18:36:15 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1117010fkz
        for <linux-ide@vger.kernel.org>; Sat, 13 Oct 2007 15:36:13 -0700 (PDT)
In-Reply-To: <20071013232922.3ff6a464@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 14 October 2007, Alan Cox wrote:
> > > > 		/* Probably a PCI interface... */
> > > > 		for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; ++i)
> > > > 			hw->io_ports[i] = data_port + i - IDE_DATA_OFFSET;
> > > > 		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
> 
> Ok so in actual fact
> 
> - The piece of code above can't be executed anyway
> - The ctrl_port argument is not needed ?

pmac_ide_init_hwif_ports() is also called by ide_init_hwif_ports()
through ppc_ide_md.init_hwif.

Bart
