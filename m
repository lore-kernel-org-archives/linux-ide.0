From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ATIIXP and libata
Date: Fri, 4 Nov 2005 11:17:06 +0100
Message-ID: <58cb370e0511040217y778fab7cj47d198b53126f9d7@mail.gmail.com>
References: <436AA2EA.2040508@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.195]:7008 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161124AbVKDKRH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2005 05:17:07 -0500
Received: by nproxy.gmail.com with SMTP id q29so81231nfc
        for <linux-ide@vger.kernel.org>; Fri, 04 Nov 2005 02:17:06 -0800 (PST)
In-Reply-To: <436AA2EA.2040508@yahoo.co.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruno Harbulot <bruno_harbulot@yahoo.co.uk>
Cc: linux-ide@vger.kernel.org, Velu Erwan <erwan@seanodes.com>

On 11/4/05, Bruno Harbulot <bruno_harbulot@yahoo.co.uk> wrote:
> Hello,
>
>
> I am trying to make a SATA drive work (fast) on an Asus Pundit-R (P4R8L
> motherboard).
> I have tried the patch posted on linux-ide by Erwan Velu on 10/10/05. It
> works and hdparm indicates about 55MB/s (thanks Erwan).
>
> However, Erwan's patch relies on testing the name of the pci device, in
> drivers/ide/pci/atiixp.c:
> if (strncmp(drive->name,"hdc",strlen("hdc")) == 0)
>
> This solution is obviously not very generic. (Perhaps I should say that,
> at least in my case, hda is a DVD drive on the IDE connector and hdc is
> the SATA drive). As Bartlomiej Zolnierkiewicz replied to Erwan's
> message, using libata's ata_id_is_sata would probably be a better route.
>
> I have tried to have a look at this (in kernel 2.6.14), but I think
> there is a major problem: atiixp is under ide/pci and doesn't seem to
> have anything to do with libata and the sata modules under the scsi
> directory. (Please feel free to correct me, linux-ide something very new
> to me.)
> I have added some "printk"s in libata-core.c, in "ata_dev_config", where
> it seems that the "ata_dev_knobble" test is made, but it is never called
> (even when I make sure that ata_xiip and libata are loaded first in my
> initrd image). Would this mean that this IDE/SATA(/PATA?) controller is
> not handled my libata at all? Should it be?

It is PATA controller and should be handled by IDE driver.

> (I don't know much about the subject, but I presume that workarounds to
> get ata_id_is_sata "to work somehow" from atiixp.c would not be the
> right thing to do, even if feasible.)

<linux/ata.h> include is used by both IDE and libata
driver, however ata_id_is_sata() shouldn't be used
directly in atiixp.c but similar check should be added
to eighty_ninty_three() from ide-iops.c.

Bartlomiej
