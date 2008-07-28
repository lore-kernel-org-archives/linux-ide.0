From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_it821x: Driver updates and reworking
Date: Mon, 28 Jul 2008 16:58:54 +0200
Message-ID: <200807281658.54380.bzolnier@gmail.com>
References: <20080724171606.1c2a677c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:37265 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756858AbYG1PBr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 11:01:47 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3432682fkq.5
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 08:01:47 -0700 (PDT)
In-Reply-To: <20080724171606.1c2a677c@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Thursday 24 July 2008, Alan Cox wrote:
> - Add support for the RDC 1010 variant
> - Rework the core library to have a read_id method. This allows the hacky
> bits of it821x to go and prepares us for pata_hd
> - Switch from WARN to BUG in ata_id_string as it will reboot if you get
> it wrong so WARN won't be seen
> - Allow the issue of command 0xFC on the 821x. This is needed to query
> rebuild status.
> - Tidy up printk formatting
> - Do more ident rewriting on RAID volumes to handle firmware provided
> ident data which is rather wonky
> - Report the firmware revision and device layout in RAID mode
> - Don't try and disable raid on the 8211 or RDC - they don't have the
> relevant bits
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Looks interesting, do you plan on porting it to ide/pci/it821x later?

PS a bit of shame that this is not splitted on patches with smaller
granularity (would make review/merging work far more effective)

Thanks,
Bart
