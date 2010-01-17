From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: silicon image 3124 support PATA
Date: Sun, 17 Jan 2010 13:36:18 -0600
Message-ID: <4B5366B2.302@gmail.com>
References: <9edb119c1001160231v3081a2e4u79884988fc5e2359@mail.gmail.com>	 <4B51FBF2.7070501@gmail.com> <9edb119c1001170225j4a3553edl68376c6ba2c11cd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:58866 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab0AQTgW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Jan 2010 14:36:22 -0500
Received: by ywh12 with SMTP id 12so846476ywh.21
        for <linux-ide@vger.kernel.org>; Sun, 17 Jan 2010 11:36:20 -0800 (PST)
In-Reply-To: <9edb119c1001170225j4a3553edl68376c6ba2c11cd5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: amruth pattanada <amruth.vamadev@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 01/17/2010 04:25 AM, amruth pattanada wrote:
> Thanks Robert for the information. I wanted to send standard ATA
> commands via 3124 controller and basically map it to legacy ide
> interface  because the RTOS does not have SATA framework and works
> with only legacy based ide device.We have supported server works, ALI,
> intel BMDE chipset successfully.Is it feasible idea to map 3124 to
> ide.I see in the data sheet that standard ATA commands can be sent via
> 3124 controller by populating PRB block(FIS type 0x27) in LRAM.Can you
> please let me know if we can follow this approach. I want to enable
> minimum configuration to operationalise the device so that I can read
> and write data onto the device.
> As per your response I see that legacy based IDE (ATA SFF interface)
> is not supported in 3124, can we atleast enable with minimum settings
> for controller to work. How do we enable 32 bit mode only instead of
> 64 bit mode supported natively. I see that in linux driver only 64bit
> is activated. Please let me know

I don't know what RTOS you're using or how its IDE framework works, but 
I suspect this controller is different enough from anything SFF-based 
that you'll have some trouble. (This is a big reason why libata was 
created instead of trying to cram such drivers into the IDE framework.) 
The only suggestion I'd have would be to look at the libata code in 
sata_sil24 and see how it's doing things and see if you can adapt that 
somehow. (Keeping in mind that the Linux code is under GPL, of course..)

> Thanks
> Amruth p.v
>
> On Sat, Jan 16, 2010 at 9:48 AM, Robert Hancock<hancockrwd@gmail.com>  wrote:
>> On 01/16/2010 04:31 AM, amruth pattanada wrote:
>>>
>>> Hi
>>> I am currently working on porting linux sata silicon image 3124 to
>>> RTOS based kernel. I have checked the code and found that it supports
>>> native sata mode only.
>>> I have legacy ide driver and want to integrate 3124 controller. I
>>> wanted to run 3124 in PATA mode. I checked libata and found that it
>>> only supports 3112.
>>> Can anybody please point what steps needs to be taken for making 3124
>>> run in PATA mode.
>>
>> If you mean run in SFF-compatible mode like the 3112, you can't. The 3124 is
>> a pure FIS-based SATA controller and doesn't support a legacy SFF-style
>> interface. If you're trying to make an IDE driver for the 3124 I think you
>> will have a lot of trouble, the IDE code was not really designed to handle
>> such a device.
>>
>>> Here is my observation so far.
>>> I have MMIO for both port and host using PCI configuration space.
>>> I can read global control register and after reset I can see that the
>>> default values are set correctly.
>>> I have port map of 8192
>>> bytes(0-2000,2000-4000,4000-6000,6000-8000)ports 0..3 respectively,
>>> and planning to reset the port, followed steps from linux code but
>>> unable to validate if the port is successfully reset.
>>> I have PRB mapped but after softreset, reading low,mid and high LBA
>>> but signature is not as per data sheet.
>>> Can I can use default standard ATA PRB and map it to legacy ide driver
>>> or is there any register setting needs to be done to bring in PATA
>>> mode.
>>> Any pointers will be appreciated.
>>> Thanks
>>> Amruth p.v
>>> Sr.Embedded Engineer
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

