From: Douglas Gilbert <dougg@torque.net>
Subject: Re: libata: CD and dvd devices not recognized
Date: Fri, 23 Mar 2007 11:19:39 -0400
Message-ID: <4603F00B.30801@torque.net>
References: <45F873AC.6010204@gmail.com>	<200703172107.42107.bzolnier@gmail.com>	<45FD0F68.7090207@gmail.com>	<200703181610.33714.bzolnier@gmail.com>	<45FE7DCC.3000507@ru.mvista.com>	<45FEE5EB.9020909@gmail.com>	<4600BA1C.7060300@tw.ibm.com>	<4600F45C.3000303@gmail.com>	<46021CDA.3070807@tw.ibm.com> <20070322123729.14f11b96@lxorguk.ukuu.org.uk> <46034C34.5000602@tw.ibm.com>
Reply-To: dougg@torque.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:56655 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945912AbXCWPUW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 11:20:22 -0400
In-Reply-To: <46034C34.5000602@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, YUP <yupadmin@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>

Albert Lee wrote:
> Alan Cox wrote:
>>> We have two possible solutions here:
>>> a. Patch Ubuntu, such that the incorrect INQUIRY is fixed.
>>> b. Patch kernel, such that the AOpen drives are blacklisted.
>>>   Each INQUIRY is inspected for the blacklisted drives.
>>>   If the INQUIRY looks wrong, the INQUIRY is rejected.
>>>
>>> I guess a. is the preferred solution...
>>
>> We have two problems here
>>
>> #1 Ubuntu got the inquiry command wrong
>>
>> #2 Until now we considered "INQUIRY" a safe command for SG_IO passthrough.
>>
>> We can't really take INQUIRY out of SG_IO so do we decide its the
>> hardware vendors problem or do something cleverer in the filters ?

Albert,
"Definitions:
....
Reserved: A keyword referring to bits, bytes, words, fields
and code values set aside for future standardization. A
reserved bit, byte, word or field shall be set to zero, or
in accordance with a future version to this standard.
Recipients are not required to check reserved bit, bytes,
words or fields for zero values. ..." [SPC-4 rev 9]

I haven't seen anywhere that says that a recipient may
crash and burn if it receives a non zero value in
a reserved field.

That suggests to me that the ATAPI drive (TORiSAN) should
be black listed.

> Maybe the SG_IO author has better idea (ccing Doug)?

Filtering is madness. We can have:
  - ATA commands passing through SCSI commands
  - encapsulated SCSI commands (security freaks)
  - and of course vendor specific commands

to name a few.

Setting the EVPD bit is to fetch VPD pages (and the
failure shown in this thread is an attempt to fetch
a list of supported VPD pages). The device identification
VPD page (0x83) is very important in FCP, SAS, SAT.
ATA8-ACS allocates 8 bytes in its IDENTIFY DEVICE response
for a wwn. Not sure if any wwn has been proposed for ATAPI
devices.

> BTW, in addition to the AOpen "INQUIRY with EVPD" problem, we have
> another imperfect ATAPI drive (TORiSAN) that freezes when "READ >= 128KB".
> (http://bugzilla.kernel.org/show_bug.cgi?id=6710)
> 
> We can limit "dev->max_sectors" to workaround the TORiSAN problem.
> But I don't know whether "dev->max_sectors" also works for SG_IO?
> If no, some user space application, unaware of the problem,
> might send a "correct" READ that locks the drive completely.

Currently only SCSI subsystem LLDs set max_sectors
(although libata might). Can it be set via sysfs?
Recent versions of the sg driver honour max_sectors
and the block layer SG_IO ioctl implementation always
has.

SCSI direct access devices (i.e. SCSI disks) have a VPD
page that supplies block limit (and optimal) values
for data transfers. Linux doesn't currently ask that
particular question. Of course the standard that defines
block limits also defines an error response if it is
exceeded.

Doug Gilbert



