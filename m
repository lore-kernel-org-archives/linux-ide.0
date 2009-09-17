From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Add pata_atp867x driver for Artop/Acard ATP867X
 	controllers
Date: Thu, 17 Sep 2009 16:51:37 -0400
Message-ID: <4AB2A159.907@pobox.com>
References: <8b5805ff0909111906j68c20c3yf7226f2798a67d80@mail.gmail.com> 	<8b5805ff0909120359g2faf661br463b19518d935110@mail.gmail.com> 	<4AABD122.2000400@gmail.com> <8b5805ff0909121717w1516c273k2a568779b9c31662@mail.gmail.com> 	<8b5805ff0909121726g2f1a78c1o1ff7289e059eabe5@mail.gmail.com> 	<4AAC4315.6010102@pobox.com> <8b5805ff0909121941y38b7764fv3cc4d0b5c1ba6c89@mail.gmail.com> 	<4AAC632E.3090902@pobox.com> <8b5805ff0909122155u77a869c5t89a81fbf1a7eb391@mail.gmail.com> 	<51f3faa70909122250o59fcd174ifee4277ba25a20fe@mail.gmail.com> <8b5805ff0909142132g59fbba8dwebc0b21484d7e157@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54714 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbZIQUvj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Sep 2009 16:51:39 -0400
In-Reply-To: <8b5805ff0909142132g59fbba8dwebc0b21484d7e157@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jung-Ik (John) Lee" <jilee@google.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Daniel Walker <dwalker@fifo99.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>, Eric Uhrhane <ericu@google.com>

On 09/15/2009 12:32 AM, Jung-Ik (John) Lee wrote:
> From: John(Jung-Ik) Lee<jilee@google.com>
>
> This is a new pata driver for ARTOP 867X 64bit 4-channel UDMA133 ATA ctrls.
> Based on the Atp867 data sheet rev 1.2, Acard, and in part on early ide codes
> from Eric Uhrhane<ericu@google.com>.
>
> Signed-off-by: John(Jung-Ik) Lee<jilee@google.com>
> Reviewed-by:  Grant Grundler<grundler@google.com>
> Reviewed-by:  Gwendal Gringo<gwendal@google.com>
> ---
>
>   rev 01: Cleared some checkpatch.pl complaints. Thanks to Daniel.
>   rev 02: Removed hard-coded value for active/recovery. Thanks to Robert.
>           Use atp867x_cable_detect() until ata_cable_40short()
>   rev 03: changes per Jeff's comment: Thansk to Jeff.
> 	 ioread/iowrite, enum, speed-to-mode calc, single mapping, etc.
>
>   drivers/ata/Kconfig        |    9 +
>   drivers/ata/Makefile       |    1 +
>   drivers/ata/pata_atp867x.c |  548 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci_ids.h    |    2 +
>   4 files changed, 560 insertions(+), 0 deletions(-)

applied


