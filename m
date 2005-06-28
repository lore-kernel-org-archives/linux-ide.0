From: Steven Schlansker <stevenschlansker@gmail.com>
Subject: Re: siimage card causes repeated oopses and panics on a PowerMac G4 running 2.6.12.1
Date: Mon, 27 Jun 2005 22:30:40 -0700
Message-ID: <6A4A6C03-7A2D-45BE-AE66-4CF38F8607EC@gmail.com>
References: <9c1484f205062702203936d7ca@mail.gmail.com> <42BFE177.1050007@pobox.com>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:15278 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261368AbVF1Fao (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jun 2005 01:30:44 -0400
Received: by zproxy.gmail.com with SMTP id r28so295814nza
        for <linux-ide@vger.kernel.org>; Mon, 27 Jun 2005 22:30:44 -0700 (PDT)
In-Reply-To: <42BFE177.1050007@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I turned off preempt and compiled the sata_sil driver.  Loading it  
did not seem to cause any troubles, but dmesg had nothing but a  
version message.  No discovery of hardware seemed to happen with the  
sata driver (this is not a sata card as far as I know?) and no /dev/ 
sd? or /dev/hd? entries appeared at all.

The old kernel module, recompiled without preempt, still causes  
crashing and general badness.

Thank you for the suggestions, got anything else to try?

Again, CCing any replies would be much appreciated.


On Jun 27, 2005, at 4:22 AM, Jeff Garzik wrote:

> Steven Schlansker wrote:
>
>> I have a SIIG Ultra-ATA 133/100 Pro for Mac card in my Sawtooth G4
>> that, upon being touched in any way (loading the siimage module,
>> trying to access the corresponding /dev/hd? entries, and just about
>> anything else) causes either an oops, a flood of oopses, or a panic.
>>
>
>
>> If I do so much as touch the new /dev/hde entry or such, many more
>> oopses and occassionally a panic will happen.  I can provide more
>> samples if necessary, I figured two would be enough to get  
>> started. The process is always different, and sometimes it even  
>> seems to be
>> unrelated to the card entirely.  Usually it's modprobe and udev.  I
>> have not successfully captured one of the panics with netconsole yet,
>> but I remember the line "Aieeee, killing interrupt handler" from  
>> them.
>>  I do not believe that the hardware is defective, as the exact same
>> card works very well under Mac OS X (which even boots from a drive
>> connected to it, so OpenFirmware does not seem to have issues with it
>> either)
>>
>
> Two things:
>
> 1) turn off preempt
>
> 2) use sata_sil driver rather than siimage
>
>     Jeff
>
>
>

