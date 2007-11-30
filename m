From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Fri, 30 Nov 2007 10:34:49 +0900
Message-ID: <474F68B9.2090203@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com> <20071129160555.38ee2edc@the-village.bc.nu> <474EE561.7010207@gmail.com> <474EE5F8.1030409@gmail.com> <474F0B11.7000205@rtr.ca> <474F4294.9030203@gmail.com> <474F6163.3030500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:48396 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762099AbXK3Be6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 20:34:58 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1762250rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 17:34:55 -0800 (PST)
In-Reply-To: <474F6163.3030500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

Hello,

Mark Lord wrote:
>> One thing I don't understand about this argument is that PIO cycle time
>> is not determined by CPU power.  It's bound by PCI and ATA bus speed.
>> If you put a faster CPU on the job, it just ends up wasting the same
>> amount of time burning up more CPU cycles or am I misjudging power of
>> those embedded CPUs?
> ...
> 
> Yes, it wastes the same amount of real (clock on the wall) time.
> 
> But since it is typically a much slower system to begin with,
> it has little in the way of "excess" computing capability,
> so those few hundred microseconds of PIO time mean a lot
> more to it than they would to a GHz+ processor.
> 
> In other words, such devices are usually close to their real-time
> limits to begin with, so a 200-300usec real-time delay is difficult
> to "make up" afterwards.
> 
> For a 1.8GHz Pentium-M, no problem --> it can churn away about
> 2-3 thousand instructions per microsecond afterwards.
> 
> But an 800MHz geode would require 2-8X that amount of real time
> to execute the same number of "catch up" instructions.

Okay, that makes more sense.  The only thing which happens regularly is
polling for media change which involves reading maybe a few tens of
bytes.  The overhead of doing those using PIO wouldn't be too much more
than the cost of writing CDBs out.  It would help more if we can cut
down the number of commands used for testing media changed event (on my
to do list).

During probing, it doesn't really matter.  The only other case where
many of these misc ATAPI commands can occur is when new media is
inserted and starting up writing.  And yeah I can see it might hurt if
the processor is already fully loaded.

> If I were doing this, I'd probably just do PIO for all non bulk xfer
> opcodes, same as you, for ease of maintainership.
> 
> But I'd also think really hard about some way to allow full DMA
> for chipsets/drives that can be trusted.  Not a whitelist (like Alan,
> I don't believe in those), but something..

Does module parameter / sysfs node sound good enough to you?

-- 
tejun
