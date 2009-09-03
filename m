From: Mark Lord <liml@rtr.ca>
Subject: Re: Fwd: Long delay when booting with SATA DVD on Marvell 88SE6121
Date: Thu, 03 Sep 2009 17:05:25 -0400
Message-ID: <4AA02F95.4050508@rtr.ca>
References: <20090817002918.GA2805@gozer.dminteractive.com>	 <4A9BD7DF.8030606@kernel.org>	 <5ffd7e260908311856j1fd42765rbdc5245bf4e7bd71@mail.gmail.com> <5ffd7e260908311900u3a4a02b9kd36156cfdce902c0@mail.gmail.com> <4A9FC81B.7020702@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:54250 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932269AbZICVFY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Sep 2009 17:05:24 -0400
In-Reply-To: <4A9FC81B.7020702@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mike Hokenson <logan@gozer.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> Mike Hokenson wrote:
>> (sorry, resent to linux-ide without the html)
>>
>> On Mon, Aug 31, 2009 at 9:02 AM, Tejun Heo <tj@kernel.org> wrote:
>>>> [    6.312129] ata2.00: qc timeout (cmd 0xa1)
>>>> [    6.312135] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>>> [   11.352006] ata2: link is slow to respond, please be patient (ready=0)
>>>> [   16.336009] ata2: device not ready (errno=-16), forcing hardreset
>>>> [   21.532007] ata2: link is slow to respond, please be patient (ready=0)
>>>> [   26.348009] ata2: SRST failed (errno=-16)
>>>> [   31.544008] ata2: link is slow to respond, please be patient (ready=0)
>>>> [   36.360014] ata2: SRST failed (errno=-16)
>>>> [   36.544307] ata2.00: ATAPI: ASUS    DRW-2014L1T, 1.02, max UDMA/66
>>>> [   36.560317] ata2.00: configured for UDMA/66
>>>> [   36.576547] scsi 1:0:0:0: CD-ROM            ASUS     DRW-2014L1T
>>>> 1.02 PQ: 0 ANSI: 5
>>> "libata.force=2:udma33" would force it to udma/33 but I don't think
>>> that would be the problem here.  IDENTIFY doesn't use udma anyway.
>>> Does the problem go away if you do "libata.force=2:pio0"?
>> Thanks for the suggestion, but it didn't help. libata is setup as a
>> module in Debian's kernel, so I created a /etc/modprobe.d/libata.conf
>> with "options libata force=2:pio0" and rebuilt initrd. This appears to
>> have properly registered the force flag, but it seems to have only
>> been applied once the kernel worked through the issue with the
>> controller/port:
>>
>> [    3.985969] usbhid: v2.6:USB HID core driver
>> [    6.316130] ata2.00: qc timeout (cmd 0xa1)
>> [    6.316135] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> [   11.356004] ata2: link is slow to respond, please be patient (ready=0)
>> [   16.340004] ata2: device not ready (errno=-16), forcing hardreset
>> [   21.536004] ata2: link is slow to respond, please be patient (ready=0)
>> [   26.352504] ata2: SRST failed (errno=-16)
>> [   31.548004] ata2: link is slow to respond, please be patient (ready=0)
>> [   36.364514] ata2: SRST failed (errno=-16)
>> [   36.548307] ata2.00: ATAPI: ASUS    DRW-2014L1T, 1.02, max UDMA/66
>> [   36.548323] ata2.00: FORCE: xfer_mask set to pio0
>> [   36.564827] ata2.00: configured for PIO0
>> [   36.565669] scsi 1:0:0:0: CD-ROM            ASUS     DRW-2014L1T
>>   1.02 PQ: 0 ANSI: 5
>>
>> I'm not sure if this is due to a modular libata or if that's just the
>> way it is with this particular problem..
> 
> Yeah, PIO0 is forced for initial probing anyway, so the parameter is a
> bit bogus in this case.  I'm out of ideas.  Mark, marvell 88se6121 is
> timing out the initial IDENTIFY but successfully probes it after a
> couple of resets.  Any ideas?
..

I haven't really been following along.  But.. I have zero information
here about the Marvell 6121 --> it's supposedly an AHCI chip, isn't it?

The device that's failing is an optical drive.  These often won't respond
to many commands until the onboard firmware finishes examining whatever disc
happens to be inserted, which can take longer than the time we normally allow.
I wonder if it has anything to do with that ?

