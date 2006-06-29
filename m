From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCHSET] libata dbg scheme conversion, take 1
Date: Thu, 29 Jun 2006 19:18:06 +0200
Message-ID: <20060629171806.GA20882@gollum.tnic>
References: <20060629160912.GA23122@zmei.tnic> <44A407CF.4000508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp110.plus.mail.re2.yahoo.com ([206.190.53.35]:30854 "HELO
	smtp110.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751065AbWF2RSK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 13:18:10 -0400
Content-Disposition: inline
In-Reply-To: <44A407CF.4000508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Fri, Jun 30, 2006 at 02:03:11AM +0900, Tejun Heo wrote:
<snip> 
> Hello,
> 
> I think this patchset is looking good generally.  Please consider the 
> following.
> 
> * Don't make currently visible-by-default messages invisible-by-default 
> or vice-versa.
The way I see it, we print by default everything marked ERR/WARN/DRV, as it is
being done down in libata-core.c

> * Don't mix visiable-by-default messages with debug messages.  e.g. It 
> seems you made ATA_MSG_INFO debug category and put EH messages and some 
> debug messages into it.  This is not good.  EH messages should be 
> visible to user by default && enabling it shouldn't turn on debug 
> messages with it.
Well, it is sometimes unclear what level exactly a message should be but afterwe
have converted everything changing the level is as trivial as changing the
ATA_MSG_* arg passed to ata_(port/dev)_printk so this won't be a problem. An
initial overhaul of the levels will be needed once the conversion is done.
Also, I tried to stick to the levels that were there previously so since their
semantics changes too, now, that also introduces some small differences.

> * Please create ATA_MSG_DEBUG category and put 
> important-but-not-too-frequent debug messages into it.  
Can you please define those "important-but-not-too-frequent" more precisely and
support it with an example in the code?

> e.g. The current 
> patch puts all debug messages during probe into CMD.  Turning on CMD 
> will generate a *lot* of messages and qc issues messages are sometimes 
> very uninteresting.  OTOH, probing messages are generally low-volume but 
> more interesting.  So, it should be possible to slect them separately. 
> Just put not-too-frequent messages into DEBUG.
agreed
> * To me, DRV/INFO distinction doesn't seem to be clear.
INFO was revalidation messages, EH progress and DRV are standard driver
messages.

Regards,
    Boris.

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

