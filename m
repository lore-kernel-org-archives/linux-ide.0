From: Matt Gillette <Matt.Gillette@netcell.com>
Subject: Re: ATA passthrough questions
Date: Thu, 19 Jan 2006 12:43:32 -0800
Message-ID: <DF42C291-57BB-4645-99F5-ED86D7CF22FC@netcell.com>
References: <867ae21dff5bea23500e8489161916d3@Netcell.com> <58cb370e0601190354g54d54f3j4fdb5240ccd21917@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 64-60-240-146.cust.telepacific.net ([64.60.240.146]:2531 "EHLO
	Netcell.com") by vger.kernel.org with ESMTP id S1161401AbWASUnL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jan 2006 15:43:11 -0500
In-Reply-To: <58cb370e0601190354g54d54f3j4fdb5240ccd21917@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej,

Thank you for answering my questions - responses inline

On Jan 19, 2006, at 3:54 AM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> On 1/9/06, Matt Gillette <Matt.Gillette@netcell.com> wrote:
>> Hi,
>> I have a few questions about ata passthrough. Our controller creates
>> its own ATA commands to configure the device, so I need full  
>> access to
>> the taskfile when sending commands to the controller/drive.
> What do you need to configure using non-standard commands?  RAID?

RAID. The netcell controller is a hardware raid. We have two ways to  
configure it - through bios and using vendor specific ata commands.

>> Could someone tell me why CONFIG_IDE_TASKFILE is disabled by default?
>
> Well, because it is experimental/dangerous/unfinished.
> However some distributions enable it by default.

Is this still being worked on (ie, will it ever be enabled by default)?

Also, if you know the distributions, could you name a couple that  
enable it?

>> Is www.kernel.org/pub/linux/kernel/people/jgarzik/libata the place to
>> get information on libata? Or are there other places anyone can
>> recommend?After glancing at the pdf, it looks like the function
>
> http://linux.yyz.us/sata/

Exactly what I was looking for - thanks.

>> HDIO_DRIVE_TASKFILE is called ata_tf_to_host in libata - is this
>> right?Does this command need to be enabled in the kernel  
>> configuration
>> options ala CONFIG_IDE_TASKFILE? Is there any open source code that
>> uses theata_tf_to_host command so I can see it in action?
>
> Do you need to this from driver of from user-space application?
>
> If the former please give some link to the source code
> so we could see what libata functions are needed.

We are hoping to send these commands from a user-space application.  
Currently we don't have our own driver. We added our vendor/device  
ids to ide-generic so everything is handled by that driver. Now that  
our ids are in kernel.org, I was hoping to find a way to send these  
ATA commands down to our card without requiring another change to the  
kernel.

One question that I have is what's the difference between the older  
ide drivers and libata. What is the future of the ide driver - is it  
going to be phased out and replaced by libata, or will they both  
remain in the kernel and developed in parallel.

Also, I'm unclear about using libata - do we need to have a driver in  
libata to use its functionality, or does our current driver (ide- 
generic) allow us to use libata's passthrough. Our card currently  
doesn't implement any sata features, but it could in the future. If  
we wanted to use these features (say Command Queueing) what is needed  
to get support.

> If the latter than are using ATA pass-through interface
> you need to issue specially prepared SG_IO ioctl instead.

This looks like it could do the trick. Two questions - is this  
enabled by default, and are there any open source projects where I  
can see it being used?

> Thanks,
> Bartlomiej

Thanks,
Matt
