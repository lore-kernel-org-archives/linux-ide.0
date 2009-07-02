From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Question about LS120 floppies
Date: Thu, 02 Jul 2009 17:54:14 -0600
Message-ID: <4A4D48A6.2060204@gmail.com>
References: <4A4BC762.3090104@lwfinger.net>	<4A4C441B.6050808@gmail.com>	<4A4CBD9E.4070404@lwfinger.net> <20090702181240.747e4063@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:54164 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbZGBXxG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jul 2009 19:53:06 -0400
Received: by pzk31 with SMTP id 31so519390pzk.33
        for <linux-ide@vger.kernel.org>; Thu, 02 Jul 2009 16:53:09 -0700 (PDT)
In-Reply-To: <20090702181240.747e4063@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, linux-ide@vger.kernel.org

On 07/02/2009 11:12 AM, Alan Cox wrote:
> On Thu, 02 Jul 2009 09:01:02 -0500
> Larry Finger<Larry.Finger@lwfinger.net>  wrote:
>
>> Robert Hancock wrote:
>>> On 07/01/2009 02:30 PM, Larry Finger wrote:
>>>> I have been trying to help someone on the openSUSE forums. He is
>>>> running a 2.6.27 kernel and finds that his "Super Floppy" drive works
>>> Are they using the old IDE drivers, or libata? Do they have any kernel
>>> output, etc?
>> In 2.6.27, I think he has the old IDE driver, but I'm not sure. In any
>> case, the entire thread on the openSUSE forum is at
>>
>> http://forums.opensuse.org/hardware/417147-ls-120-opensuse-11-a.html
>>
>> Thanks for any help you can give.
>
> Basically four content free pages. Ignoring all the stuff about HAL the
> hardware is detected and the drive reports that the media type is not
> supported.
>
> That all appears to be working beautifully, although I've no idea why the
> media type is not supported - I wonder if something is trying to read the
> wrong block sizes or if the LS120 has some magic no standard bits.
>
> Unfortunately they are very very obscure hardware.

Yes, definitely a lot of uninformed speculation on that thread. The 
floppy driver has nothing to do with any IDE/ATA drive like this, and if 
OpenSUSE is using libata drivers then attempting to load the IDE floppy 
driver is also useless.

It would be useful if the reporter could verify that the drive is at all 
functional with that media under any OS. That "Cannot read medium - 
unknown format" is being reported by the drive itself in response to a 
"read capacity" request, not the driver. So unless there's some magic 
that the driver needs to do to get the drive to recognize the disc, it 
seems like a hardware problem.
