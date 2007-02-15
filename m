From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SiI 3114 and sata_sil
Date: Thu, 15 Feb 2007 14:27:58 -0500
Message-ID: <45D4B43E.2040807@pobox.com>
References: <45D4A705.4050407@andrei.myip.org> <45D4A98A.7070705@pobox.com> <45D4AB9C.9050808@andrei.myip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58450 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030763AbXBOT2E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 14:28:04 -0500
In-Reply-To: <45D4AB9C.9050808@andrei.myip.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florin Andrei <florin@andrei.myip.org>
Cc: linux-ide@vger.kernel.org

Florin Andrei wrote:
> Jeff Garzik wrote:
>> Florin Andrei wrote:
>>> (I'm not subscribed to linux-ide)
>>>
>>> I've two almost identical systems (slightly different CPUs) that use 
>>> SiI 3114 for SATA and RAID.
>>>
>>> One of them was installed a while ago with Fedora Core 5 (kernel 
>>> 2.6.15-1.2054_FC5smp) and whoever installed it was able to turn on 
>>> hardware RAID.
>>
>> This chip does not support hardware RAID.  The capability simply isn't 
>> there in the silicon.
>>
>> http://linux-ata.org/faq-sata-raid.html#sii
> 
> Wow! :-(
> 
> So that means that the FC5 system is not actually on RAID? Even though 
> it seems so? (using /dev/dm-* for filesystem volumes)
> 
> # lspci | grep -i sata
> 03:05.0 RAID bus controller: Silicon Image, Inc. SiI 3114 
> [SATALink/SATARaid] Serial ATA Controller (rev 02)
> # df -m
> Filesystem           1M-blocks      Used Available Use% Mounted on
> /dev/dm-6               125931      2999    116432   3% /
> /dev/dm-1                   99        13        81  14% /boot
> tmpfs                     1012         0      1012   0% /dev/shm
> /dev/dm-2                 9917       151      9254   2% /tmp
> /dev/dm-3                 9917       237      9168   3% /var
> # lsmod | grep ata
> sata_sil               13897  2
> libata                 58321  1 sata_sil
> scsi_mod              129641  3 sg,libata,sd_mod
> # cat /etc/modprobe.conf | tail -n 1
> alias scsi_hostadapter sata_sil
> 
> So in fact /dev/dm-* are just on one disk each (not RAID1), or what is 
> going on here?

The's dmraid providing /software/ RAID as noted in 
http://linux-ata.org/faq-sata-raid.html#dmraid

	Jeff



