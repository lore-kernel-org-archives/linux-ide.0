From: Harri Olin <harri.olin@gmail.com>
Subject: Re: sata_mv, io stucks
Date: Sat, 15 Nov 2008 17:18:35 +0200
Message-ID: <491EE84B.1010600@gmail.com>
References: <48F88449.1000704@ngs.ru> <49003B9C.1010303@ngs.ru> <4900A12F.3030307@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:55935 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbYKOPSq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Nov 2008 10:18:46 -0500
In-Reply-To: <4900A12F.3030307@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Artem Bokhan <aptem@ngs.ru>, linux-ide@vger.kernel.org

Mark Lord wrote:
>>> Two marvell controllers, 16 disks, software raid10, IO stucks on 
>>> different disks, kernel 2.6.26.5.
>>> With default ubuntu's 8.04 2.6.24 kernel the problem can not be 
>>> repeated
>>>
>>>
>>> [  289.851609] ata11.00: exception Emask 0x0 SAct 0x1 SErr 0x0 
>>> action 0x6 frozen
>>> [  289.851695] ata11.00: cmd 61/08:00:60:1e:bf/00:00:01:00:00/40 tag 
>>> 0 ncq 4096 out
>>> [  289.851697]          res 40/00:00:00:00:00/00:00:00:00:00/00 
>>> Emask 0x4 (timeout)
>>> [  289.851774] ata11.00: status: { DRDY }
>>> [  289.851834] ata11: hard resetting link
>>> [  290.649259] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> [  290.749239] ata11.00: max_sectors limited to 256 for NCQ
>>> [  290.809189] ata11.00: max_sectors limited to 256 for NCQ
>>> [  290.809194] ata11.00: configured for UDMA/133
>>> [  290.809200] ata11: EH complete
>>> [  290.809242] sd 10:0:0:0: [sdk] 1953525168 512-byte hardware 
>>> sectors (1000205 MB)
>>> [  290.809258] sd 10:0:0:0: [sdk] Write Protect is off
>>> [  290.809263] sd 10:0:0:0: [sdk] Mode Sense: 00 3a 00 00
>>> [  290.809286] sd 10:0:0:0: [sdk] Write cache: enabled, read cache: 
>>> enabled, doesn't support DPO or FUA
> ...
>
> I've just returned here from a month holiday in Italy,
> and I'll have a look at this and other sata_mv issues
> next week or so.

I ran git-bisect on it and it returned 
a3718c1f230240361ed92d3e53342df0ff7efa8c as first bad commit. Also 
verified by hand that patching it on working tree breaks it.

-- 
Harri.

