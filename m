From: Christian Pernegger <pernegger@gmail.com>
Subject: Re: sata_sil24 blows up under load, please help diagnose
Date: Fri, 9 Oct 2009 03:57:04 +0200
Message-ID: <bb145bd20910081857k3de54622qbdde5d13a8182803@mail.gmail.com>
References: <bb145bd20910081136m1b4e23e2nfeae068f693c3f64@mail.gmail.com>
	 <4ACE9023.8080301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:43446 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758686AbZJIB5l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Oct 2009 21:57:41 -0400
Received: by ewy4 with SMTP id 4so231552ewy.37
        for <linux-ide@vger.kernel.org>; Thu, 08 Oct 2009 18:57:04 -0700 (PDT)
In-Reply-To: <4ACE9023.8080301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

> Please see the recent post from Bernie Innocenti "sata_mv 0000:03:06.0: PCI
> ERROR; PCI IRQ cause=0x30000040". I suspect you could have a similar problem
> with the system running at too high a PCI-X bus clock speed with two cards
> installed.

Speed can be jumpered from 133Mhz down to 100Mhz but that doesn't make
any difference at all. Since the board has only two slots (and I need
both) I can't use the insert-slower-card trick to slow the bus down to
66Mhz.

Fun detail:
pcix1 -- controller1 -- backplane1 -- array1
pcix2 -- controller2 -- backplane2 -- array2
works as long as it's not stressed. As soon as we switched the cabling
like so (to see if the initial failing port would "move" with it or
not):
pcix1 -- controller1 -- backplane2 -- array2
pcix2 -- controller2 -- backplane1 -- array1
the box goes absolutely crazy within seconds of normal access. With
"luck" even while sitting there idle. The only difference is that
array1 has 4 disks and array2 has only 3.

Thank you for trying to help

Christian
