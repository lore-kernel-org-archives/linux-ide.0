From: =?ISO-8859-15?Q?Kasimir_M=FCller?= <kjm@kasimir-mueller.de>
Subject: Re: [Fwd: Re: libata , Silicon Image 3124]
Date: Sun, 06 Jan 2008 11:55:03 +0100
Message-ID: <4780B387.1050600@kasimir-mueller.de>
References: <473A5B03.2020808@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010506030301080605080002"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:60000 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbYAFKzs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 05:55:48 -0500
Received: from mo-p00-ob.rzone.de (mrclete-mo-p00-ob.mail [192.168.63.64])
	by charnel-fb-03.store (RZmta 14.0) with ESMTP id i001f8k068CvGt
	for <linux-ide@vger.kernel.org>; Sun, 6 Jan 2008 11:55:46 +0100 (MET)
	(envelope-from: <kjm@kasimir-mueller.de>)
In-Reply-To: <473A5B03.2020808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, christian.kuehn@hamburg.de

This is a multi-part message in MIME format.
--------------010506030301080605080002
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hi Tejun,

Old communication appended below.

I wish you a Happy Xmas and a successful New Year.

I spent some time during Christmas to further investigate the problem. I
bought a new 500GB disk and put all data on this disk.
This is also contineously watched by nagios and cacti
Then
1.) All 5 disks in the external case connected via Portmapper and sil24
card have excellent health-status with smartd.
2.) I get no(!!!!) errors at all if I use the disks as single drives or
with lvm. I verified this by copying large amounts of data (100-200GB)
     with rsync , cp-av and running bonnie++ single and simultaneously 
to  various combinations of drives.
3.) I get the errors as soon as I use raid. Same errors with raid0 (2
disks), 1 (2 disks), 5 (3 disks) in any combination of the drives
4.) The errors appear usually first during mkfs (same with ext3 and
reiserfs) and than
     after writing about 10-50 GB to the raid, and repeat then at 5 to
10 minute intervals according the disk activity.
5.) I used Kernel 2.6.23.1 with Your latest patch: same result
6.) I used kernel 2.6.24 patch rc-6 : same result
7.) during the tests I marked all files with md5-sums:  No data
corruption (!!!), so maybe I can live with it.


linux:/var/log # cat /proc/interrupts
           CPU0
  0:   12457604    XT-PIC-XT        timer
  1:          8    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  4:     186738    XT-PIC-XT        serial
  5:   13328470    XT-PIC-XT        sata_via, ehci_hcd:usb5, VIA8237,
fcpci, eth0
  6:          5    XT-PIC-XT        floppy
  8:          0    XT-PIC-XT        rtc
  9:          0    XT-PIC-XT        acpi
 10:    8019753    XT-PIC-XT        sata_sil24
 11:        114    XT-PIC-XT        uhci_hcd:usb1, uhci_hcd:usb2
 14:     468588    XT-PIC-XT        libata
 15:          0    XT-PIC-XT        libata, uhci_hcd:usb3, uhci_hcd:usb4
NMI:          0
LOC:   12457724
ERR:          1


complete log of kernel errors from today appended as gz:

In the opensuse mailing-list some people reported related errors.
http://lists.opensuse.org/opensuse-de/2007-12/msg00939.html

Can You make someting out of this ? Do You need any more information
(please detail, because I am not a linux-guru)

Yours sincerely

Kasimir Mueller

> kjm@kasimir.mueller.de didn't work.  Forwarding to the original address.
>   
it is kjm@kasimir-mueller.de
>   
>
> ------------------------------------------------------------------------
>
> Betreff:
> Re: libata , Silicon Image 3124
> Von:
> Tejun Heo <htejun@gmail.com>
> Datum:
> Wed, 14 Nov 2007 11:10:57 +0900
> An:
> Kasimir Mueller <kjm@kasimir.mueller.de>
>
> An:
> Kasimir Mueller <kjm@kasimir.mueller.de>
> CC:
> IDE/ATA development list <linux-ide@vger.kernel.org>
>
> Return-Path:
> <htejun@gmail.com>
> X-Original-To:
> htejun@gmail.com
> Delivered-To:
> tj@htj.dyndns.org
> Received:
> from [127.0.0.2] (htj.dyndns.org [127.0.0.2]) by htj.dyndns.org
> (Postfix) with ESMTP id 50E1813A81CF; Wed, 14 Nov 2007 11:10:57 +0900
> (KST)
> Nachricht-ID:
> <473A5931.4040704@gmail.com>
> User-Agent:
> Thunderbird 2.0.0.6 (X11/20070801)
> MIME-Version:
> 1.0
> Referenzen:
> <4738A231.5010700@kasimir-mueller.de> <4738FC4C.7050103@gmail.com>
> <473A11B4.5030409@kasimir.mueller.de>
> In-Reply-To:
> <473A11B4.5030409@kasimir.mueller.de>
> X-Enigmail-Version:
> 0.95.3
> Content-Type:
> text/plain; charset=ISO-8859-15
> Content-Transfer-Encoding:
> 8bit
>
>
> [linux-ide added back. please don't drop cc list]
>
> Kasimir Mueller wrote:
>   
>> Tejun Heo schrieb:
>>     
>>> Kasimir Müller wrote:
>>>  
>>>       
>>>> Nov 12 19:28:42 linux kernel: ata6.02: cmd
>>>> ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
>>>> Nov 12 19:28:42 linux kernel:          res
>>>> 40/00:00:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
>>>>     
>>>>         
>>> That's flush timing out, which isn't good.
>>>
>>> 1. Are the errors localized to ata6.02?
>>>   
>>>       
>> I think it's ata6.01
>>     
>
> The above message says 6.02 tho.  Anyways, if the errors are localized
> to one drive, please swap that drive with another drive.  Do the errors
> follow the drive or stay with the slot?
>
>   
>>> 2. Is FLUSH always involved (ie. is cmd always ea)?
>>>   
>>>       
>> yes
>>     
>
> Hmmm... okay.  That sounds like a dying drive to me.  What does
> 'smartctl -a /dev/sdX' say?
>
>   
>>> 3. If you disable NCQ, what do errors look like?
>>>   
>>>       
>> I put all disk-drives in the blacklist , without a change
>>     
>
> So, NCQ isn't the problem.
>
> ATM, it sounds like a dying drive to me.  Please double check the errors
> are localized to one drive, check smartctl log and try to verify as
> written above.
>
> Thanks.
>
>   


--------------010506030301080605080002
Content-Type: application/x-gzip;
 name="kernel.log.today.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="kernel.log.today.gz"

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
--------------010506030301080605080002--
