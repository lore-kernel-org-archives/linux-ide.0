From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Question about LS120 floppies
Date: Thu, 02 Jul 2009 19:20:08 -0500
Message-ID: <4A4D4EB8.5080503@lwfinger.net>
References: <4A4BC762.3090104@lwfinger.net>	<4A4C441B.6050808@gmail.com>	<4A4CBD9E.4070404@lwfinger.net> <20090702181240.747e4063@lxorguk.ukuu.org.uk> <4A4D48A6.2060204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmailhost06.isp.att.net ([207.115.11.56]:37541 "EHLO
	fmailhost06.isp.att.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbZGCAT6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jul 2009 20:19:58 -0400
In-Reply-To: <4A4D48A6.2060204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> On 07/02/2009 11:12 AM, Alan Cox wrote:
>> On Thu, 02 Jul 2009 09:01:02 -0500
>> Larry Finger<Larry.Finger@lwfinger.net>  wrote:
>>
>>> Robert Hancock wrote:
>>>> On 07/01/2009 02:30 PM, Larry Finger wrote:
>>>>> I have been trying to help someone on the openSUSE forums. He is
>>>>> running a 2.6.27 kernel and finds that his "Super Floppy" drive works
>>>> Are they using the old IDE drivers, or libata? Do they have any kernel
>>>> output, etc?
>>> In 2.6.27, I think he has the old IDE driver, but I'm not sure. In any
>>> case, the entire thread on the openSUSE forum is at
>>>
>>> http://forums.opensuse.org/hardware/417147-ls-120-opensuse-11-a.html
>>>
>>> Thanks for any help you can give.
>>
>> Basically four content free pages. Ignoring all the stuff about HAL the
>> hardware is detected and the drive reports that the media type is not
>> supported.
>>
>> That all appears to be working beautifully, although I've no idea why the
>> media type is not supported - I wonder if something is trying to read the
>> wrong block sizes or if the LS120 has some magic no standard bits.
>>
>> Unfortunately they are very very obscure hardware.
> 
> Yes, definitely a lot of uninformed speculation on that thread. The
> floppy driver has nothing to do with any IDE/ATA drive like this, and if
> OpenSUSE is using libata drivers then attempting to load the IDE floppy
> driver is also useless.
> 
> It would be useful if the reporter could verify that the drive is at all
> functional with that media under any OS. That "Cannot read medium -
> unknown format" is being reported by the drive itself in response to a
> "read capacity" request, not the driver. So unless there's some magic
> that the driver needs to do to get the drive to recognize the disc, it
> seems like a hardware problem.

The OP seemed more interested in ranting about the state of drivers in
Linux than in getting his device to work. He is sending the hardware
and a couple of new disks to me so that I can figure what is wrong.

He is currently trying to purchase a Panasonic drive on Ebay, as he
claims that the coding is different than for the Matshitu drives. At
least there is a different driver under DOS. These drives don't even
have Windows drivers. I'm prepared to try his drive with FreeDOS on my
machine when it arrives.

Larry
