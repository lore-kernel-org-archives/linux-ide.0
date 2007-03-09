From: Tejun Heo <teheo@suse.de>
Subject: Re: nonzero mismatch_cnt with no earlier error
Date: Fri, 09 Mar 2007 21:36:06 +0900
Message-ID: <45F154B6.4060109@suse.de>
References: <45DF859B.2050108@eyal.emu.id.au>	<Pine.LNX.4.64.0702231929380.31611@p34.internal.lan>	<45DF8DE3.2050903@eyal.emu.id.au> <17890.25524.465403.130119@notabene.brown> <45E297E5.50303@eyal.emu.id.au> <45EB95EF.9030702@suse.de> <45EBCC43.9010709@eyal.emu.id.au> <45EC3EB3.10407@suse.de> <45EC933C.8010004@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jericho.provo.novell.com ([137.65.248.124]:5872 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422770AbXCIMgL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 07:36:11 -0500
In-Reply-To: <45EC933C.8010004@eyal.emu.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-ide <linux-ide@vger.kernel.org>

Hello, sorry about the long delay.

Eyal Lebedinsky wrote:
>> BTW, this is SMART read log for page 09 which is SMART self-test log.
>> The device aborted it.  Dunno who issued it or why it got aborted.  As I
>> wrote in the previous mail, EH discovered that SError has accumulated
>> link level errors and thus treated it as ATA bus error.  All
>> transmissions over SATA are checksummed and link errors supposedly don't
>> cause data corruption, so, in theory, the above error message should be
>> irrelevant to your problem.
>>
>> Ah.. please also post the result of 'smartctl -d ata -a /dev/sdX' for
>> your drives.  That might reveal something.
> 
> sd[ab] are on the motherboard, sd[cdef] are on a Promise SATA-II-150-TX4.
> 
> In smartd.conf all the disks run a full selftest once a week which may have
> coincided with the time of the reported error.

All the logs look fine.  No driver recorded any error condition in smart
logs.  The SMART command abort is really fishy.  There is no reason the
device would abort that command unless something weird is going on.  I'm
afraid I can't tell much at this point.  It might be a good idea to
schedule SMART self test and RAID checksumming at different time slot.

-- 
tejun
