From: Kushal Koolwal <kushalkoolwal@gmail.com>
Subject: Re: libata: ATA exception error messages in pata_sch module (CONFIG_PATA_SCH)
Date: Tue, 1 Mar 2011 17:48:54 -0800
Message-ID: <AANLkTikpg2d47rAO=FatTe-53Ju4u+YBXt8VKmani8TN@mail.gmail.com>
References: <AANLkTikD3NOA7=zOLRaft8TL=sTgPSCHNNKgTP3AfYWD@mail.gmail.com>
	<4D6D9684.505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34824 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757730Ab1CBBsz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2011 20:48:55 -0500
Received: by iyb26 with SMTP id 26so4480623iyb.19
        for <linux-ide@vger.kernel.org>; Tue, 01 Mar 2011 17:48:54 -0800 (PST)
In-Reply-To: <4D6D9684.505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Borislav Petkov <petkovbb@gmail.com>, linux-ide@vger.kernel.org

> You shouldn't really use a 40-conductor cable in a system that has devices
> that support faster than UDMA mode 2.
The system restrict device speeds up to UMDA2 speeds at the firmware
level (BIOS) and physical connectors use to connect IDE devices comes
only in 40 conductor cable format.

> Normally the kernel would detect the
> 40-wire cable and block using faster speeds, but it seems like the pata_sch
> driver doesn't support cable detection as the cable_detect method is set to
> ata_cable_unknown (either because the hardware doesn't support it or the
> author didn't bother to implement it), so it can't detect this
> automatically.
Yes you are right. We have another system with same UDMA2 restrictions
(BIOS/Physical connectors) but uses the piix driver (instead of
pata_sch) and in that we don't see these messages.

I don't know much about how the Linux IDE sub-system works but I am
willing to test and report the results if somebody cares to write a
patch that introduces the cable detection mechanism in the pata_sch
driver.

Thanks!

Kushal
