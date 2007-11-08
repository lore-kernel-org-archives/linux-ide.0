From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA eating my disk, port reset, destroying unrelated data
Date: Wed, 07 Nov 2007 18:22:21 -0600
Message-ID: <473256BD.1080205@shaw.ca>
References: <fa.49dhbrKdHhj8Seg3o+OTGRYqytk@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:61412 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756112AbXKHAWg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 19:22:36 -0500
In-reply-to: <fa.49dhbrKdHhj8Seg3o+OTGRYqytk@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Norbert Preining wrote:
> Dear all!
> 
> (please Cc me for answers)
> 
> Since about 5 days I am having serious problems with my SATA drive:
> 
> kernel 2.6.22 (from Debian/sid)
> hardware nv
> 
> Sometimes at boot time, often/always at disk io intense stuff:
> 
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x400000 action 0x2

Serror 0x400000 means a handshake error. Usually Serror indications are 
due to a hardware problem (bad SATA cable, power or drive problem).

> ata1.00: (BMDMA stat 0x25)
> ata1.00: cmd 35/00:00:2a:6f:c0/00:04:0c:00:00/e0 tag 0 cdb 0x0 data 524288 out
>          res 51/84:10:1a:72:c0/84:01:0c:00:00/e0 Emask 0x10 (ATA bus error)
> ata1: soft resetting port
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> 
> Even worse, sometimes the reset does not work ...
> 
> ata1: device not ready (errno=-16), forcing hardreset
> ata1: hard resetting port
> ata1 SRST failed (errno=-19)
> ata1: reset failed (errno=-19), retrying in 10 secs
> ..
> 
> (typed from a digital photo, nothing remains in the logs)
> 
> After this I need to do a cold boot otherwise the drive is really in a
> bad state and not even the bios gets it right.

If even the BIOS cannot reset properly then that also really points to a 
hardware problem..

> 
> Interestingly the whole stuff DID work for a long time until I did too
> many things at the same time: 2 x svn up, copying 40G from the SATA
> drive to an USB drive, aptitude upgrade. Before I did regularly the same
> stuff (like svn up etc), but this time it was too much, it seems.
> 
> Apropos data hosing: After the first incident some data on my windows
> partitions (/dev/sda1) was hosed, programs missing, chkdisk necessary
> etc.
> 
> I attach dmesg (from the current boot with a succeeding soft reset, I
> interrupted the svn process before the SATA drives goes into hard reset
> failures), .config, lspci -v output.
> 
> Are there any chances that using 2.6.23 will improve/fix this? Any other
> suggestions?
> 
> I would consider it an hardware problem, but since it started at one big
> io thingy and is persistent since then I am a bit sceptic.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

