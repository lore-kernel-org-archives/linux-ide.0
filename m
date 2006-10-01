From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA status reports update
Date: Sun, 01 Oct 2006 09:16:35 +0900
Message-ID: <451F08E3.7030208@gmail.com>
References: <fa.YaF1lJH12hP9W/r7m3pt7oXOeL4@ifi.uio.no> <fa.g2Kx9MbD4ZVWpxAjjpedYrf09zM@ifi.uio.no> <fa.b1vkqJfue4GOQ6qZfdh86ct/nDk@ifi.uio.no> <fa.YmprXb8sC090DghGSt7gnlhfo2c@ifi.uio.no> <fa.IewnjLanGhRn8aKEjkVZcxkolss@ifi.uio.no> <fa.mQXoq13o43zcI4XRFyX1EjaYxI4@ifi.uio.no> <451EEB2A.7070702@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:36856 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751793AbWJAAQm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 20:16:42 -0400
Received: by py-out-1112.google.com with SMTP id n25so1872692pyg
        for <linux-ide@vger.kernel.org>; Sat, 30 Sep 2006 17:16:41 -0700 (PDT)
In-Reply-To: <451EEB2A.7070702@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>, prakash@punnoor.de, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

[cc'ing linux-ide]

Robert Hancock wrote:
> Jeff Garzik wrote:
>> Robert Hancock wrote:
>>> Jeff Garzik wrote:
>>>> Prakash Punnoor wrote:
>>>>> Well, how would one debug it w/o hw docs? Or is it possible to 
>>>>> compare the patch with a working driver for another chipset?
>>>>
>>>> Well, it is based off of the standard ADMA[1] specification, albeit 
>>>> with modifications.  There is pdc_adma.c, which is also based off 
>>>> ADMA.  And the author (from NVIDIA) claims that the driver worked at 
>>>> one time, so maybe it is simply bit rot that broke the driver.
>>>>
>>>> If I knew the answer, it would be fixed, so the best answer 
>>>> unfortunately is "who knows".
>>>>
>>>> I wish I had the time.  But I also wish I had a team of programmers 
>>>> working on libata, too ;-)
>>>
>>> Do you know exactly what is allegedly broken in that version? I see 
>>> that there are some functions which are just "TODO"..
>>
>> I just know it was a working driver at one time.
> 
> I had a look at the ADMA patch. It looks like it is vaguely based off 
> the ADMA spec, though with some significant changes (i.e. 64-bit 
> addresses instead of 32-bit, some things are missing or at least not 
> defined in the constants provided in the patch).
> 
> I think the code will more or less work in ADMA mode with NCQ disabled 
> (i.e. how it is in the patch currently, with #define NV_ADMA_NCQ 
> commented out). However, with NCQ on there would be a few problems:
> 
> -When the driver gets a command which is not DMA-mapped (i.e. PIO 
> commands), it switches the controller from ADMA mode into port-register 
> mode and then issues the command in the existing fashion. This isn't 
> going to work very well if there are already NCQ command(s) in progress, 
> which I assume is a possibility. Either the driver needs to stall the 
> PIO command until all the NCQ commands are done and prevent any other 
> NCQ commands starting while the PIO is in progress (is this viable?), or 
> it needs to push the PIO command through the ADMA pipeline.

Actually, libata core layer already does it.  It never mixes NCQ and 
non-NCQ commands.  sata_nv can safely assume that those two sets of 
commands are always issued disjointly.  The relevant function is 
libata-scsi.c::ata_scmd_need_defer().

> The ADMA 
> standard provides a means for executing PIO commands through the 
> pipeline using PIO-over-DMA, but there's not enough info to say whether 
> the NVIDIA controller implements that the same way or at all. Jeff, you 
> may be able to help with this if you have access to the docs.

It would be nice to have that but I'm doubtful it would worth the 
effort.  I would just leave it as it is as long as it works.

> -Inside the interrupt handler the driver uses ata_qc_from_tag(ap, 
> ap->active_tag) to find the qc which was just completed. This won't work 
> in NCQ as active_tag is not used and multiple commands may be in 
> progress. It should be checking the CPB flags on all the active CPBs to 
> see which one(s) have completed (or maybe the hardware has a register 
> that indicates which CPBs have been completed already, the patch doesn't 
> provide a hint of how that would work however).
> 
> So it looks like it needs some work before NCQ will work properly. 
> However, there would be some gains to getting ADMA working even without 
> NCQ, both in terms of reduced CPU overhead. Also, ADMA supports full 
> 64-bit DMA as opposed to the 32-bit DMA capability of the standard 
> interface, which would reduce IOMMU load on systems with RAM above 4GB. 
> (Note that this is broken in the patch currently, the sg addresses get 
> dumped into a u32 and truncated before they are written to the 
> controller, and it also doesn't set a 64-bit DMA mask in ADMA mode..)

Not only that, hopefully, it will show better EH behavior.  sata_nv's TF 
register mode sometimes hangs holding PCI bus (as in IORDY lockup). 
This happens a lot if you pull a disk out while it's actively processing 
a command but doesn't seem to be restricted to that.  Also, it has been 
suggested that sata_nv's TF register mode might involve some nasty SMM 
code.  I don't recall whether it was verified tho.

Anyways, it would be very nice to have working nv_adma.  I have a CK804 
nv but it's my primary work machine and I'm too lazy to develop on it, 
but I would be more than happy to test or answer questions.

Thanks.

-- 
tejun
