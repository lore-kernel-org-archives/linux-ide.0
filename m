From: Mark Lord <liml@rtr.ca>
Subject: Re: Responding to 2 thread <2.6.23.8 - Hang with sata_mv (7042)...>
 AND  <Bug: get EXT3-fs error Allocating block in system zone>
Date: Tue, 11 Dec 2007 12:42:13 -0500
Message-ID: <475ECBF5.4050205@rtr.ca>
References: <BD261180E6D35F4D9D32F3E44FD3D901053E84BD@EMPBEDEX.empirix.com> <45ED682A.9040408@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010A7E1B45@EMPBEDEX.empirix.com> <4728A816.8020608@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010AAE852F@EMPBEDEX.empirix.com> <473B36D7.8000205@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE8585@EMPBEDEX.empirix.com> <473B44CB.6010209@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE89CA@EMPBEDEX.empirix.com> <473B76E0.7010500@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE911D@EMPBEDEX.empirix.com> <473C7625.2040300@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AB2CFF0@EMPBEDEX.empirix.com> <473CC4B8.4090607@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AEF6982@EMPBEDEX.empirix.com> <475D6CC3.2080400@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AFF2936@EMPBEDEX.empirix.c
 om>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3014 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981AbXLKRmO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Dec 2007 12:42:14 -0500
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010AFF2936@EMPBEDEX.empirix.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, hp@syntomax.com

Morrison, Tom wrote:
> I am a little confused as to exactly what thread I am to respond to 
> and/or what requests...but lets try this and see if I get close?
> 
> I have the <far> below mentioned hardware/configuration (flat 4Gig 
> of DDR mem (0x0_000_0000 to 0x1_000_0000)...PPC/8548E - 36bit addressing
> 
> As can be seen below - Mark has asked me try patching my sata_mv 
> (and scsi_lib) with some patches from the second thread in subject:
> 
>     1) Disable 64bit DMA in sata_mv (equivalent of the CAP_64 for 
>        AHCI) and disabling the bounce:
> 
>     2) Disable queue bounce limit in drivers/scsi/scsi_lib.c
> 
> +#if 0
>          blk_queue_bounce_limit(q, scsi_calculate_bounce_limit(shost));
> +#endif
> 
> Mark had already asked me to try #1 a while back - and that didn't work.
> So, I tried #2 - and now it doesn't hang for me went writing a large 
> File (which was my error condition)...
> 
> So, as Linus suggested in his email, it looks like something 
> is wrong in the bounce buffering? What - somebody will have
> to look into this further...
..

That's a bit strange, actually.. because you said that this system
does not have any RAM at any addresses above 0xffffffff.
The physical RAM in this system is supposedly from 0 - 0xffffffff (4Gbytes).

????

> -----Original Message-----
> From: Mark Lord [mailto:liml@rtr.ca] 
> Sent: Monday, December 10, 2007 11:44 AM
> To: Morrison, Tom
> Cc: Jeff Garzik; linux-ide@vger.kernel.org; Tejun Heo; hp@syntomax.com
> Subject: Re: Revisiting - 2.6.23.8 - Hang with sata_mv (7042) + Flat
> 4Gig (no holes) Memory
> 
> Morrison, Tom wrote:
> ..
>> To re-state the problem....
>>
>> Hardware/Configuration:
>>    MPC8548E with a 7042 (rev 2 - connected internal via a PEX switch) 
>>    2.6.23.8 (using PHYS_64BIT & PTE_64BIT - for 36 bit addressing
>>              & MSI is NOT compiled in)
>>    Flat 4Gig Memory Map (no holes - 0 - 0x0_FFFF_FFFF defined -
> special
>>  	                   low reserve memory is also used)
>>
>>    Local Bus & PCI Express IOMem mapped to unique space in 
>> 		0xC_xxxx_xxxx with extensions to the ioremap routines 
>> 		to create the appropriate requested physical address...
>> 		This is (and should be) transparent to the requesting 
>> 		function that calls ioremap.
>> 		
>>    2 SATA hard drives connected.
>>
>> To recreate:
>>    Write a large file (now greater than >310Mbytes) - hangs
>>    and soft lockup is detected by kernel - no useful info 
>>    in stack trace...
>>
>> Of interest:
>>    a) Replace sata_mv.c - with the 'old' Marvell's reference 
>>       driver and it works perfectly!!
>>
>>    b) Also, sata_mv works perfectly in all conditions - if we boot
> with 
>>       less than the ~3750M from the command line (which I note is
> ~below
>>       where its PEX IOmemory space is located).
> ..
> 
> Tom:  could you please try and follow the recent thread here (linux-ide)
> entitled " Bug: get EXT3-fs error Allocating block in system zone ".
> 
> Somebody there has a similar problem on x86-32 with RAM above 4GB
> using a standard AHCI SATA controller.
> 
> Jens has posted a couple of debugging patches there to try and isolate
> things.
> (patches attached here for convenience, though you'll have to
> modify/hack
>  the first one for sata_mv instead of ahci).
> 
> -ml
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

