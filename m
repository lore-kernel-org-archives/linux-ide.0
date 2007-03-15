From: Mark Lord <liml@rtr.ca>
Subject: IOMEGA IDE ZIP (ATAPI) drive
Date: Thu, 15 Mar 2007 18:12:02 -0400
Message-ID: <45F9C4B2.20906@rtr.ca>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <45F7E34B.6020206@gmail.com> <45F7F90B.6070709@rtr.ca> <45F7FD13.2070907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:2976 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395AbXCOWMH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Mar 2007 18:12:07 -0400
In-Reply-To: <45F7FD13.2070907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Stanislav Brabec <sbrabec@novell.com>, albertl@mail.com, jeff@garzik.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Mark Lord wrote:
>> Really?  I didn't notice when libata gained ATAPI-disk support.
>>
>> Are you *sure* about that??
> 
> Not sure sure but almost sure.  :-)  What ide-scsi does is borrowing
> SCSI mid and high level drivers while using ide as SCSI low level
> driver.  To SCSI, libata and ide-scsi aren't very different except that
> libata also exports SBC device to it.  So, if SCSI could handle ATAPI
> disk via ide-scsi, I don't think there is any reason it can't with libata.

Okay, I dusted off one of my old (actually, I believe *the oldest*)
Zip100 drives in the collection, and tried it out here with both
2.6.20 and 2.6.21-rc3-git9.   It works mostly fine with each.

A couple of minor issues, though.

(1) When ejecting a disk, either with the "eject /dev/sdc" command
or using the front-panel soft-eject button on the drive,
I get the following in syslog from libata:

sdc: Spinning up disk...<3>ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
         res 00/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata4: soft resetting port
ATA: abnormal status 0x7F on port 0x00010177
ATA: abnormal status 0x7F on port 0x00010177
ata4.00: configured for PIO2
ata4: EH complete


(2) The above log says PIO2, but the IDENTIFY data for this drive,
which I had to patch the kernel to get (ATAPI ATA_16 support),
indicates max PIO0 for this unit.  I suppose maybe the chipset
doesn't go that low, but no big deal since IORDY handshakes it anyway.

Chipset is VIA, PCI ID 1106:0571, Rev.6.


Tejun, if you want one for your testbed, then email me shipping
info (again) and I'll send you this exact unit, with one disc.

Here's the IDENTIFY data, for anyone else here who collects antiques:

/dev/sdc:
80a0 0000 0000 0000 0000 0000 0000 0000
0000 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0000 0000 0000 3233
2e44 2020 2020 494f 4d45 4741 2020 5a49
5020 3130 3020 2020 2020 2020 4154 4150
4920 2020 2020 2020 2020 2020 2020 0000
0000 0e00 0000 0000 0000 0002 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 01f4 01f4 0000 0000 0000
0000 0006 0009 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0101
2863 2920 436f 7079 7269 6768 7420 494f
4d45 4741 2031 3939 3720 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

Cheers

