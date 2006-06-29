From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata dbg scheme conversion, take 1
Date: Fri, 30 Jun 2006 02:03:11 +0900
Message-ID: <44A407CF.4000508@gmail.com>
References: <20060629160912.GA23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.199]:54884 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750971AbWF2RCv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 13:02:51 -0400
Received: by nz-out-0102.google.com with SMTP id i11so198036nzi
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 10:02:50 -0700 (PDT)
In-Reply-To: <20060629160912.GA23122@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Borislav Petkov wrote:
> This patchset converts the relevant pieces of libata to the new debugging
> scheme. Additionally, it adjusts the message level scheme to one appropriate for
> libata. 
> 
> There are still places which use the old debugging macros but they have to be
> dealt with on a case by case basis due to the functionality of the debugging
> macros. Although most of the levels should be appropriately mapped, there might
> still be some message level "skew" which can be dealt with in a later course.

Hello,

I think this patchset is looking good generally.  Please consider the 
following.

* Don't make currently visible-by-default messages invisible-by-default 
or vice-versa.

* Don't mix visiable-by-default messages with debug messages.  e.g. It 
seems you made ATA_MSG_INFO debug category and put EH messages and some 
debug messages into it.  This is not good.  EH messages should be 
visible to user by default && enabling it shouldn't turn on debug 
messages with it.

* Please create ATA_MSG_DEBUG category and put 
important-but-not-too-frequent debug messages into it.  e.g. The current 
patch puts all debug messages during probe into CMD.  Turning on CMD 
will generate a *lot* of messages and qc issues messages are sometimes 
very uninteresting.  OTOH, probing messages are generally low-volume but 
more interesting.  So, it should be possible to slect them separately. 
Just put not-too-frequent messages into DEBUG.

* To me, DRV/INFO distinction doesn't seem to be clear.

Thanks for the good work.  :)

-- 
tejun
