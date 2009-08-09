From: Gwendal Grignou <gwendal@google.com>
Subject: Re: Drive tester
Date: Sun, 9 Aug 2009 15:06:17 -0700
Message-ID: <e7510f760908091506u1547f9e9qc094ff98bba64077@mail.gmail.com>
References: <9b0a5b990907162309j2ff4f872v47b18be74c7eeab9@mail.gmail.com>
	 <23E65EE4544D484CBE73B588E192C6D612D3108FF0@sc-vexch3.marvell.com>
	 <87f94c370907231431p470874bax1155b88895cd97d5@mail.gmail.com>
	 <23E65EE4544D484CBE73B588E192C6D612D301CCCD@sc-vexch3.marvell.com>
	 <87f94c370907231531r291ccadaude79a848a4a09286@mail.gmail.com>
	 <4A6947EF.1020103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:49485 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbZHIWGV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 18:06:21 -0400
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id n79M6LL5011326
	for <linux-ide@vger.kernel.org>; Sun, 9 Aug 2009 15:06:21 -0700
Received: from bwz25 (bwz25.prod.google.com [10.188.26.25])
	by wpaz13.hot.corp.google.com with ESMTP id n79M6IB8002969
	for <linux-ide@vger.kernel.org>; Sun, 9 Aug 2009 15:06:18 -0700
Received: by bwz25 with SMTP id 25so2336888bwz.35
        for <linux-ide@vger.kernel.org>; Sun, 09 Aug 2009 15:06:17 -0700 (PDT)
In-Reply-To: <4A6947EF.1020103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, Bill Weiler <weilerb@marvell.com>, Kernelnewbies <kernelnewbies@nl.linux.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, Jul 23, 2009 at 10:34 PM, Robert Hancock<hancockrwd@gmail.com> =
wrote:
> On 07/23/2009 04:31 PM, Greg Freemyer wrote:
>>
>> cc'ing: linux-ide@vger.kernel.org
>>
>> maybe they can help
>>
>> On Thu, Jul 23, 2009 at 6:12 PM, Bill Weiler<weilerb@marvell.com> =A0=
wrote:
>>>
>>> ________________________________________
>>> From: Greg Freemyer [greg.freemyer@gmail.com]
>>> Sent: Thursday, July 23, 2009 2:31 PM
>>> To: Bill Weiler
>>> Cc: Kernelnewbies
>>> Subject: Re: Drive tester
>>>
>>> On Wed, Jul 22, 2009 at 7:55 PM, Bill Weiler<weilerb@marvell.com> =A0=
wrote:
>>>>
>>>> I wanted to make an Application that could send scripted SCSI and =
SATA
>>>> commands to my drives. I have found my Fedora Linux to be too comp=
lex to
>>>> control the drives in this way. I have looked at minimal Linux but=
 I
>>>> think
>>>> this would have the same problem. Is there an easier Open Source O=
S, or
>>>> an
>>>> embedded PC Linux that would be easier to modify?
>>>
>>> Bill,
>>>
>>> For sata drives, have you looked at the SG_IO interface?
>>>
>>> That is how hdparm interfaces with the kernel. =A0I know it sends a=
 lot
>>> of low level ATA commands to the drive from user space. =A0I think =
most
>>> use the SG_IO interface. =A0How much simpler can it get?
>>>
>>> strace hdparm may give you an education as to how simple it is.
>
> The best way to issue arbitrary ATA commands is likely to issue them =
as ATA
> pass-through SCSI commands using SG_IO, yes.
>
>>>
>>> fyi: I believe the kernel looks for dangerous ata commands and bloc=
ks
>>> them. =A0But I think those are the types of commands that cause dat=
a
>>> loss. =A0Not sure what the criteria is.
>
> If you're running as unprivileged user I believe we block things like=
 could
> do things like brick the drive such as uploading firmware, etc. Howev=
er, if
> you have read-write access to the device node you can still read and =
write
> sectors anywhere on the disk. A few commands are blocked even for roo=
t
> users, like SET FEATURES - XFER MODE as it will screw up the mode
> configuration, but it's mostly fair game.
>
>>>
>>> I have studied hdparm and the SG_IO interface and delved into the s=
csi
>>> drivers and ata drivers.
>>>
>>> For example, I wanted to script a single NCQ and a single NCQ write=
=2E A
>>> normal read(fd,buf,4096) does 1 NCQ read but a write(fd,buf,4096) d=
oes
>>> dozens of NCQ reads before doing the 1 NCQ write. How do I get rid =
of these
>>> reads?
>
> Try opening the device node with O_DIRECT. That will prevent pagecach=
e
> effects from changing the IO pattern. However, you can't get less tha=
n
> page-size (4K granularity) on requests, for that you'll need to issue=
 SCSI
> or ATA commands directly.
>
>>>
>>> Also, I need to do soft and hard resets and these are not exposed.
>
> Indeed, there's no way currently to trigger these other than as part =
of
> error handling (i.e. command errors, hotplug operations, etc.) There'=
s
> likely no reason it couldn't be added, but obviously nobody's needed =
it
> enough to bother so far..

We can trigger reset from user space using scsi scan interface.
hard/soft is decided by the interface driver, in particular if it has
access to SATA SCR registers or is working in IDE backward
compatibility mode.
Once you know the scsi location { host_id, channel_id, target_id,
lun_id } of you ATA disk, issue

echo <channel_id> <target_id> <lun_id> > /sys/class/scsi_host/host<host=
_id>/scan

=46or instance, on my system:
echo 0 0 0 > /sys/class/scsi_host/host5/scan

Will generate:
ata6: hard resetting link
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: configured for UDMA/133
ata6: EH complete

> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
