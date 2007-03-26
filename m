From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Mon, 26 Mar 2007 13:50:41 +0800
Message-ID: <46075F31.7010806@tw.ibm.com>
References: <45F873AC.6010204@gmail.com>	<200703172107.42107.bzolnier@gmail.com>	<45FD0F68.7090207@gmail.com>	<200703181610.33714.bzolnier@gmail.com>	<45FE7DCC.3000507@ru.mvista.com>	<45FEE5EB.9020909@gmail.com>	<4600BA1C.7060300@tw.ibm.com>	<4600F45C.3000303@gmail.com>	<46021CDA.3070807@tw.ibm.com> <20070322123729.14f11b96@lxorguk.ukuu.org.uk> <46034C34.5000602@tw.ibm.com> <4603F00B.30801@torque.net>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:32824 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbXCZFu6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Mar 2007 01:50:58 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2Q5ow82021348
	for <linux-ide@vger.kernel.org>; Mon, 26 Mar 2007 01:50:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2Q5ovcU055958
	for <linux-ide@vger.kernel.org>; Sun, 25 Mar 2007 23:50:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2Q5ouEV019996
	for <linux-ide@vger.kernel.org>; Sun, 25 Mar 2007 23:50:57 -0600
In-Reply-To: <4603F00B.30801@torque.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dougg@torque.net
Cc: albertl@mail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, YUP <yupadmin@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>

Douglas Gilbert wrote:
> Albert Lee wrote:
> 
>>Alan Cox wrote:
>>
>>>>We have two possible solutions here:
>>>>a. Patch Ubuntu, such that the incorrect INQUIRY is fixed.
>>>>b. Patch kernel, such that the AOpen drives are blacklisted.
>>>>  Each INQUIRY is inspected for the blacklisted drives.
>>>>  If the INQUIRY looks wrong, the INQUIRY is rejected.
>>>>
>>>>I guess a. is the preferred solution...
>>>
>>>We have two problems here
>>>
>>>#1 Ubuntu got the inquiry command wrong
>>>
>>>#2 Until now we considered "INQUIRY" a safe command for SG_IO passthrough.
>>>
>>>We can't really take INQUIRY out of SG_IO so do we decide its the
>>>hardware vendors problem or do something cleverer in the filters ?
> 
> 
> Albert,
> "Definitions:
> ....
> Reserved: A keyword referring to bits, bytes, words, fields
> and code values set aside for future standardization. A
> reserved bit, byte, word or field shall be set to zero, or
> in accordance with a future version to this standard.
> Recipients are not required to check reserved bit, bytes,
> words or fields for zero values. ..." [SPC-4 rev 9]
> 
> I haven't seen anywhere that says that a recipient may
> crash and burn if it receives a non zero value in
> a reserved field.
> 

Thanks for the advice (also Sergei and Alan's). Yurema did
more test on the Aopen 56X/AKH and it seems has trouble with
other commands, too. (It also chokes on GET_CONFIGURATION, etc.
during request sense.) Agreed it's the drive/firmware problem,
not the reserved EVPD bit nor Ubuntu/hald/scsi_id's fault.
Maybe the best fix is firmware update. I will ask AOpen about
any firmware update available for it.

> That suggests to me that the ATAPI drive (TORiSAN) should
> be black listed.

It's the AOpen 56X/AKH drive that chokes on INQUIRY with EVPD=1.
The TORiSAN drive has another ATAPI DMA problem and max_sector
limitation. Sorry for the mix-up.

> 
> 
>>Maybe the SG_IO author has better idea (ccing Doug)?
> 
> 
> Filtering is madness. We can have:
>   - ATA commands passing through SCSI commands
>   - encapsulated SCSI commands (security freaks)
>   - and of course vendor specific commands
> 
> to name a few.
> 
> Setting the EVPD bit is to fetch VPD pages (and the
> failure shown in this thread is an attempt to fetch
> a list of supported VPD pages). The device identification
> VPD page (0x83) is very important in FCP, SAS, SAT.
> ATA8-ACS allocates 8 bytes in its IDENTIFY DEVICE response
> for a wwn. Not sure if any wwn has been proposed for ATAPI
> devices.
> 
> 
>>BTW, in addition to the AOpen "INQUIRY with EVPD" problem, we have
>>another imperfect ATAPI drive (TORiSAN) that freezes when "READ >= 128KB".
>>(http://bugzilla.kernel.org/show_bug.cgi?id=6710)
>>
>>We can limit "dev->max_sectors" to workaround the TORiSAN problem.
>>But I don't know whether "dev->max_sectors" also works for SG_IO?
>>If no, some user space application, unaware of the problem,
>>might send a "correct" READ that locks the drive completely.
> 
> 
> Currently only SCSI subsystem LLDs set max_sectors
> (although libata might). Can it be set via sysfs?
> Recent versions of the sg driver honour max_sectors
> and the block layer SG_IO ioctl implementation always
> has.

It's good to know that the sg driver honors max_sectors.
So, my previous concern about user space app might send commands with
invalid max_sect that kills the TORiSAN drive is solved. :)


> 
> SCSI direct access devices (i.e. SCSI disks) have a VPD
> page that supplies block limit (and optimal) values
> for data transfers. Linux doesn't currently ask that
> particular question. Of course the standard that defines
> block limits also defines an error response if it is
> exceeded.
> 

Thanks,

Albert


