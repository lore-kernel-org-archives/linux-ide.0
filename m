From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED
Date: Tue, 13 Jul 2010 19:30:51 -0600
Message-ID: <4C3D134B.2090604@gmail.com>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65092 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab0GNBay (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jul 2010 21:30:54 -0400
Received: by iwn7 with SMTP id 7so6450174iwn.19
        for <linux-ide@vger.kernel.org>; Tue, 13 Jul 2010 18:30:54 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomas Lund <tlund@nxs.se>
Cc: linux-ide@vger.kernel.org

On 07/13/2010 03:09 PM, Tomas Lund wrote:
> Today I plugged in a brand new sil3132 controller (LYCOM SATA PE-103
> 2-CH) in my server, put it in the secondary graphics-card 16x
> PCI-Express slot (I wanted to find out if it worked there), hooked port
> 0 up to a PMP and attached two disks on port 0 and 1 and powered my
> server on.
>
> After getting alot of errors at kernel start when it was detecting the
> disks (not saved, sorry) I started to eliminate things and narrow it down:
>
> * SATA-controller is now in a "normal" 1x PCI-Express slot.
> * No PMP, just one disk now attached to port 0 on the controller.
> * Switched SATA-cable.
> * Switched to a different disk (different vendor)
>
> All disks I tried works fine on the motherboard ICH8 controler.

...

> ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata9.00: irq_stat 0x00020002, device error via D2H FIS
> ata9.00: failed command: READ DMA
> ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
> res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
> ata9.00: status: { DRDY ERR }
> ata9.00: error: { ABRT }
> ata9.00: configured for UDMA/100
> ata9: EH complete

This seems strange, the drive apparently reported command aborted when 
trying to read the first sectors of the disk, but there's no indication 
of why (there's nothing set in Serror).

Can you test the controller in a different machine? It could be faulty..
