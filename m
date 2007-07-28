From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: move ide_config_drive_speed() calls to upper layers
Date: Sat, 28 Jul 2007 22:57:38 +0400
Message-ID: <46AB91A2.6060303@ru.mvista.com>
References: <200707270222.28230.bzolnier@gmail.com> <20070727122723.35b379d9@the-village.bc.nu> <200707272119.19438.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:52553 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751374AbXG1Szj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 14:55:39 -0400
In-Reply-To: <200707272119.19438.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>On Fri, 27 Jul 2007 02:22:27 +0200
>>Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

>>>* Convert {ide_hwif_t,ide_pci_device_t}->host_flag to be u16.

>>>* Add IDE_HFLAG_POST_SET_MODE host to indicate the need to program the
>>>  host for the transfer mode after programming the device.  Set it in
>>>  au1xxx-ide/cs5530/cs5535/pdc202xx_new/sc1200/via82cxxx host drivers.

>>The CS5530 at least shouldn't care what order changes are done. I don't

    And neither CS5535. And Au1200 static bus controller shouldn't care about 
the order too, so au1xxx-ide hardly needs that.
Here's the datasheet, BTW:

http://www.razamicroelectronics.com/documents/32798e_Au1200_db.pdf

>>think the SC1200 does either but I don't have the docs to hand.

    It seems pretty much alike CS553x except it's accessed via PCI config. 
space, not MSRs... Here's the datasheet:

http://www.amd.com/files/connectivitysolutions/geode/32579B_sc1200_ds.pdf

    I have a feeling that only pdc202xx_new and jmicron drivers actually need 
this flag (and the latter one actually doesn't care as its methods are empty 
anyway).  Well, AMD/VIA chips enable UltraDMA mode by snooping Set Features 
command (as the drivers tell them to do so), so the order seems important 
unless that is changed.

> Thanks,
> Bart

MBR, Sergei
