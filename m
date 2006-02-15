From: Matt Gillette <matt.gillette@netcell.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Wed, 15 Feb 2006 13:10:52 -0800
Message-ID: <A09A4133-860C-4ABF-952E-0BB41FCA2109@netcell.com>
References: <20060215143439.GA17850@harddisk-recovery.com> <43F37A5E.1090301@rtr.ca> <a3d8b0a0602151257x52f6011bs1b37d9ac43b26619@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 64-60-240-146.cust.telepacific.net ([64.60.240.146]:27121 "EHLO
	Netcell.com") by vger.kernel.org with ESMTP id S932170AbWBOVLy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Feb 2006 16:11:54 -0500
In-Reply-To: <a3d8b0a0602151257x52f6011bs1b37d9ac43b26619@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-ide@vger.kernel.org

Mark,

Thanks to Alan Cox, I now have a libata driver for my IDE controller.  
Now I'm looking into the next problem I have, which seems to be the  
same problem you're running into. I need a generic ATA passthru  
mechanism to configure our raid controller and need to send both non- 
data and data commands (with PIO and DMA).

Bartlomiej suggested using SGIO, but I haven't found any good  
documentation or examples on what I would need to do to prepare and  
send the command.

I'm not sure how much I could help (I'm still a beginner), but I just  
wanted to put in the fact that I'm interested in seeing a working  
example of the SGIO protocol and am willing to offer any help I can.

Matt


> From: Mark Lord <liml@rtr.ca>
> Date: Feb 15, 2006 11:00 AM
> Subject: Re: TASKFILE ioctl for libata?
> To: Erik Mouw <erik@harddisk-recovery.com>
> Cc: linux-ide@vger.kernel.org
>
>
> Erik Mouw wrote:
>> Hi,
>>
>> Hdparm (6.3) needs the TASKFILE ioctl for the ATA security feature  
>> set
>> (security freeze, security unlock, etc.). I can't find it in Jeff's
>> libata-dev tree, is there somebody already working on it? Or is  
>> there a
>> workaround?
>>
>
> If that ioctl is missing in libata, then I'll have to convert hdparm
> to use SGIO to submit ATA Passthru packets instead for libata devices.
>
> That's on my TO-DO list, and rising more quickly to the top now, it  
> seems.
>
> Cheers
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

