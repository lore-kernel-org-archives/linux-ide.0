From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] libata: add ioctls to support SMART
Date: Mon, 30 Aug 2004 13:58:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <41336AA8.1070401@pobox.com>
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <413361BF.8020805@pobox.com> <20040830124225.A4358@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268723AbUH3SEP@vger.kernel.org>
In-Reply-To: <20040830124225.A4358@florence.linkmargin.com>
To: Andy Warner <andyw@pobox.com>
Cc: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[...]
>>That implies, then, that you would add code to libata-scsi.c that 
>>translates the ATA-passthru SCSI command into an ATA command using the 
>>ata_scsi_translate() infrastructure.
> 
> 
> Speaking of which - I'm working on this and want to find like
> minded people playing in the libata-scsi.c/04-262r<n>.pdf
> sandbox, and collaborate with them.
> 
> If you're one of these people, ping me off list and we
> can pool our efforts.

I am trying convince someone to do it for me, since I'm working on new 
controller support ATM ;-)

It shouldn't be hard -- just a new function "ata_scsi_passthru_xlat" 
that translates the 04-262r<n>.pdf opcode into struct ata_taskfile. 
That's all that's needed for Step One.

John mentioned he might look at it...  but why don't you guys (and 
everyone else interested) just work publicly on linux-ide?  Share the 
knowledge and patches :)

	Jeff
