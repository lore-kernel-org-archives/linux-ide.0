From: Tejun Heo <teheo@suse.de>
Subject: Re: nonzero mismatch_cnt with no earlier error
Date: Tue, 06 Mar 2007 01:00:51 +0900
Message-ID: <45EC3EB3.10407@suse.de>
References: <45DF859B.2050108@eyal.emu.id.au>	<Pine.LNX.4.64.0702231929380.31611@p34.internal.lan>	<45DF8DE3.2050903@eyal.emu.id.au> <17890.25524.465403.130119@notabene.brown> <45E297E5.50303@eyal.emu.id.au> <45EB95EF.9030702@suse.de> <45EBCC43.9010709@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jericho.provo.novell.com ([137.65.248.124]:33017 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933584AbXCEQBA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Mar 2007 11:01:00 -0500
In-Reply-To: <45EBCC43.9010709@eyal.emu.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-ide <linux-ide@vger.kernel.org>

Eyal Lebedinsky wrote:
> It is in the original thread on linux-raid, but here it is for this list.
> This is the full dmesg. There were only MARKs in between.
> 
> I run a raid 'check' every Friday (cron). The last one reported some parity errors.
> 
> *** last week check start:
> [927080.617744] md: data-check of RAID array md0
> [927080.630783] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
> [927080.648734] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
> [927080.678103] md: using 128k window, over a total of 312568576 blocks.
> 	*** last week error:
> [937567.332751] ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x4190002 action 0x2
> [937567.354094] ata3.00: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 512 in
> [937567.354096]          res 51/04:83:45:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)

I need full kernel log including the boot messages so that I can tell
which controller/driver is involved here and also the result of 'hdparm
-I /dev/sdX' of your drives would be nice.

BTW, this is SMART read log for page 09 which is SMART self-test log.
The device aborted it.  Dunno who issued it or why it got aborted.  As I
wrote in the previous mail, EH discovered that SError has accumulated
link level errors and thus treated it as ATA bus error.  All
transmissions over SATA are checksummed and link errors supposedly don't
cause data corruption, so, in theory, the above error message should be
irrelevant to your problem.

Ah.. please also post the result of 'smartctl -d ata -a /dev/sdX' for
your drives.  That might reveal something.

-- 
tejun
