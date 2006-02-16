From: Tejun Heo <htejun@gmail.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Thu, 16 Feb 2006 09:06:03 +0900
Message-ID: <43F3C1EB.3040006@gmail.com>
References: <20060215143439.GA17850@harddisk-recovery.com> <43F37A5E.1090301@rtr.ca> <a3d8b0a0602151257x52f6011bs1b37d9ac43b26619@mail.gmail.com> <A09A4133-860C-4ABF-952E-0BB41FCA2109@netcell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:7568 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751356AbWBPAGP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 19:06:15 -0500
Received: by wproxy.gmail.com with SMTP id i3so241786wra
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 16:06:15 -0800 (PST)
In-Reply-To: <A09A4133-860C-4ABF-952E-0BB41FCA2109@netcell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Gillette <matt.gillette@netcell.com>
Cc: Mark Lord <liml@rtr.ca>, Erik Mouw <erik@harddisk-recovery.com>, linux-ide@vger.kernel.org

Matt Gillette wrote:
> Mark,
> 
> Thanks to Alan Cox, I now have a libata driver for my IDE controller. 
> Now I'm looking into the next problem I have, which seems to be the same 
> problem you're running into. I need a generic ATA passthru mechanism to 
> configure our raid controller and need to send both non-data and data 
> commands (with PIO and DMA).
> 
> Bartlomiej suggested using SGIO, but I haven't found any good 
> documentation or examples on what I would need to do to prepare and send 
> the command.
> 
> I'm not sure how much I could help (I'm still a beginner), but I just 
> wanted to put in the fact that I'm interested in seeing a working 
> example of the SGIO protocol and am willing to offer any help I can.

Hello, Matt.

If you're looking for ATA SGIO example, smartctl source should have it. 
  smartctl uses ATA SGIO when given -d ATA option.  And, plesase don't 
top post.

-- 
tejun
