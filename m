From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [2.6.21.1] SATA freeze
Date: Sat, 12 May 2007 19:02:38 -0600
Message-ID: <464663AE.6040409@shaw.ca>
References: <fa.zU1kuoSgByTYCYqY+iCQ5rMJy34@ifi.uio.no>
 <46460C1B.6000609@shaw.ca> <464610F7.6030202@redhotpenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:38859 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756451AbXEMBCl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 May 2007 21:02:41 -0400
In-reply-to: <464610F7.6030202@redhotpenguin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fred Moyer <fred@redhotpenguin.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Fred Moyer wrote:
>> This appears to be a different problem. Something is issuing 
>> SMART-related commands (smartd or smartctl perhaps) which the drive 
>> seems to be reacting strangely to. It apparently completed the command 
>> but never raised DRQ to request any data being transferred even though 
>> we expected it to. Maybe SMART is disabled on the drive and that's 
>> causing it to just toss these commands? CCing linux-ide in case anyone 
>> knows what would cause this.
> 
> Here's smartctl -a for this drive - same output for both sda and sdb. 
> Smartd is currently running.  Any advice appreciated.
> 
> Previously on 2.6.15 I was seeing sdb remount as readonly under heavy 
> i/o.  I have not seen that issue yet with 2.6.21 (with Robert's patch 
> from May 5th for sata_nv), but that occurrence of remounts read-only was 
> infrequently, so that issue may be solved.
> 
> app2 ~ # smartctl -a /dev/sda
> smartctl version 5.36 [x86_64-pc-linux-gnu] Copyright (C) 2002-6 Bruce 
> Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> Device: ATA      ST3808110AS      Version: n/a
> Serial number:             5LR8895K
> Device type: disk
> Local Time is: Sat May 12 12:05:58 2007 PDT
> Device does not support SMART
> 
> Error Counter logging not supported
> 
> [GLTSD (Global Logging Target Save Disable) set. Enable Save with '-S on']
> Device does not support Self Test logging
> 

Sounds like SMART is likely disabled on that drive. You can try doing 
"smartctl -s on /dev/sda" and see if that will turn it on.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

