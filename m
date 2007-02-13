From: Tejun Heo <htejun@gmail.com>
Subject: Re: pcim_enable_device BUGs for libata devices in 2.6.20-git6
Date: Tue, 13 Feb 2007 07:30:03 -0800
Message-ID: <45D1D97B.6010002@gmail.com>
References: <45CFB87F.9060802@shaw.ca> <45D02F5B.801@gmail.com> <20070212205444.GC18101@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:42834 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbXBMPaP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 10:30:15 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2299827wxd
        for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2007 07:30:15 -0800 (PST)
In-Reply-To: <20070212205444.GC18101@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hello, Pavel.

Pavel Machek wrote:
>> 1. Don't restore power state and re-enable PCI device on resume from 
>> freeze just as we don't do the opposite when freezing.
>>
>> 2. Unconditionally disable and power down PCI device on suspend whether 
>> it's freeze or not.
>>
>> #2 would be simpler but I'm a bit worried about it.  There might be 
>> controllers which choke after such sequence (save state, disable, power 
>> down, no actual power removal, power on, restore state, re-enable).
> 
> I'd just go for #2.

I think I've been seeing too many weird ATA controller issues to be bold 
about this.  I'll chicken out and go for #1.  :-)

>> #1 can be easily done by taking a look at the current device power state 
>> (gendev->power.power_state).  The problem is that no one in 
>> suspend/resume path seems to be setting that variable except for
>> runtime 
> 
> No, that variable is probably going to go away. If you want to
> remember that you are resuming from freeze, just store that info in
> private data structure.

I see.  Thanks.

-- 
tejun
