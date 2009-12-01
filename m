From: Tejun Heo <tj@kernel.org>
Subject: Re: PROBLEM: "lost interrupt (Status 0x50)" from DVD drive, long
 wait 	on 2.6.31 till 2.6.32rc6
Date: Tue, 01 Dec 2009 15:11:47 +0900
Message-ID: <4B14B3A3.4090103@kernel.org>
References: <d4db24520911150535pc4cddbufe86713cb317d7c9@mail.gmail.com> <d4db24520911151957s781902e0v2bc9e9c20f3ebdd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54940 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbZLAGLb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 01:11:31 -0500
In-Reply-To: <d4db24520911151957s781902e0v2bc9e9c20f3ebdd5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Postma <e.j.postma+linux-ide@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

On 11/16/2009 12:57 PM, Erik Postma wrote:
> 2009/11/15 Erik Postma <e.j.postma+linux-ide@gmail.com>:
>> (...)
>> [7.7.] Other information that might be relevant to the problem
>>       (please look in /proc and include all information that you
>>       think to be relevant):
>>
>> Here's dmesg:
>> (...)
> 
> Just now I had a boot where it did something different; here's what I
> guess is the relevant part of dmesg. This is the same kernel and of
> course the same hardware as described in the earlier email. Does the
> fact that it's unpredictable mean there's possibly hardware issues?
> Still have not seen any sign of trouble on 2.6.30 or earlier.
> 
> [    6.872066] ata4.00: qc timeout (cmd 0xa0)
> [    6.872123] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
> 0x6 frozen
> [    6.872183] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
> [    6.872184]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00
> 00 00
> [    6.872186]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
> 0x5 (timeout)
> [    6.872337] ata4.00: status: { DRDY ERR }
> [    6.872417] ata4: soft resetting link
> [    7.052604] ata4.00: configured for UDMA/33
> [    7.053051] ata4: EH complete

Timeouts on TURs.  These seem pretty common for optical drives for
some reason.  I can't think of anything which has changed since .30
which could have affected execution of NODATA command.  Is the drive
useable once those timeouts passed?  Does having a media in the drive
or not make any difference?

Thanks.

-- 
tejun
