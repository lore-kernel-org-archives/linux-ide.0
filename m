From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Disabling SATA hardware interrupts
Date: Mon, 4 Dec 2006 12:03:50 +0000
Message-ID: <20061204120350.3bbd520d@localhost.localdomain>
References: <c70dbe410612040308o5cbe878cue4ce98c088776afc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:49373 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1757095AbWLDL5F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Dec 2006 06:57:05 -0500
In-Reply-To: <c70dbe410612040308o5cbe878cue4ce98c088776afc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thinus Viljoen <thinus.viljoen@gmail.com>
Cc: linux-ide@vger.kernel.org

> Reason: I am building a real-time system using RTAI. I do not need to
> access the HDD while in real-time mode, but I must access another
> peripheral which shares the interrupt with libata. I want do disable
> the libata interrupts while in real-time mode, to improve the timing
> characteristics of the real-time peripheral.

The nIEN bit in the device registers control interrupt generation on ATA
devices. However ATA devices don't generate interrupts except on command
completion or during command processing so if you have no I/O outstanding
you won't have any interrupts anyway.

With funky new stuff like AHCI and NCQ this isn't so simple but for
simple ATA as with the ata_piix driver it is.
