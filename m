From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Wed, 31 Jan 2007 15:50:17 +0300
Message-ID: <45C09089.7070300@ru.mvista.com>
References: <45BF5003.3000503@imc-berlin.de>	<20070130164401.295f9913@localhost.localdomain>	<45BF7658.1090204@imc-berlin.de>	<20070130172629.70ad628d@localhost.localdomain>	<45BF7E21.7010605@imc-berlin.de> <20070130180727.594b35d0@localhost.localdomain> <45BF88B9.3050802@imc-berlin.de> <45BF8F33.3070008@ru.mvista.com> <45C066A8.2090500@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:43946 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933198AbXAaMu0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Jan 2007 07:50:26 -0500
In-Reply-To: <45C066A8.2090500@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

Hello.

Steven Scholz wrote:

>>>How could one then explain

>>>current capacity is 78140160 sectors would be           0x000004A85300
>>>native  capacity is 185074430006016 sectors would be    0xA852FFA85300

>>>? First three bytes ok, then the other three bytes rubbish?

>>   Note that they're not complete garbage but equal the value of the
>>lower 3 bytes minus 1. What is clear is that Read Native Max Address Ext
>>command must be mistreating the HOB bit... :-)

> Well this results from

> 	addr++;	/* since the return value is (maxlba - 1), we add 1 */

> in idedisk_read_native_max_address_ext().

> Apparently on my system
> 
> 		u32 high = (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
> 			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
> 			    args.hobRegister[IDE_SECTOR_OFFSET];
> 		u32 low  = ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
> 			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
> 			    (args.tfRegister[IDE_SECTOR_OFFSET]);
> 
> high and low contain the same values! :-(

    Right.
    I also have doubts about IDE_CONTROL_REG being properly decoded/handled in 
your FPGA.

> I "hardcoded" set_max = capacity, now I get

> hda: Host Protected Area detected.
>         current capacity is 78140160 sectors (40007 MB)
>         native  capacity is 78140160 sectors (40007 MB)
> hda: Host Protected Area disabled.
> hda: 4289221376 sectors (2196081 MB) w/8192KiB Cache, CHS=65535/255/63

> ;-)

> But still something must go terribly wrong.

    Erm, the resulting capacity still seems wrong, so you need to also change 
idedisk_set_max_address_ext().

> smartctl shows

>   7 Seek_Error_Rate         0x000f   061   060   030     -       1513926
> 195 Hardware_ECC_Recovered  0x001a   100   066   000     -       104721680

> And after just doing a "mke2fs /dev/hda1" I see

>   7 Seek_Error_Rate         0x000f   061   060   030     -       1516919
> 195 Hardware_ECC_Recovered  0x001a   095   066   000     -       104791382

> :-(

    I'm not sure smartctl names these attributes corectly -- they're vendor 
specific, after all... :-)

> --
> Steven

MBR, Sergei
