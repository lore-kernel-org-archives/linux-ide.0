From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Small initializer patch for ide-disk.c
Date: Tue, 21 Dec 2004 16:51:26 -0500
Message-ID: <41C89ADE.1010403@pobox.com>
References: <20041221202407.GD2725@artsapartment.org>	<41C88F73.2090606@pobox.com> <20041221133056.6a5a3259.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18367 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261865AbULUVvd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Dec 2004 16:51:33 -0500
In-Reply-To: <20041221133056.6a5a3259.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: ahaas@airmail.net, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Art Haas wrote:
>>
>>>Hi.
>>>
>>>This patch adds C99 initializers to the file. It can clearly wait until
>>>after 2.6.10 is released if you want to send it to Linus.
>>
>>The unpatched version is far more readable and maintainable.
>>
> 
> 
> I was thinking the exact opposite ;)


The problem with this (and similar patches to PCI drivers' struct 
pci_device_id arrays) is that a single line explodes into 4-5 or more 
lines, when it is _already_ plainly obvious to the maintainer what each 
field value represents.

It uses more space without adding value to the maintainer ("I have to 
scroll a lot more to see the same information?  Thanks!").

Once the struct has exploded from one line per entry to bunches, the 
maintainer is then forced to reverse the damage by creating a macro that 
allows the data to shrink again.  Why not just avoid the expand-shrink 
cycle in the first place?  See example below, from drivers/ide/pci/piix.h.

Of course, Art's patch modifies drivers/ide/*, so Bart's opinion on the 
subject is far more important than mine.

	Jeff



#define DECLARE_PIIX_DEV(name_str) \
         {                                              \
                .name           = name_str,             \
                .init_setup     = init_setup_piix,      \
                .init_chipset   = init_chipset_piix,    \
                .init_hwif      = init_hwif_piix,       \
                .channels       = 2,                    \
                .autodma        = AUTODMA,              \
                .enablebits     = {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
                .bootable       = ON_BOARD,             \
         }
