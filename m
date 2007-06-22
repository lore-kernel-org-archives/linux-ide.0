From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: SATA: Is "DPO and FUA" ever supported?
Date: Fri, 22 Jun 2007 18:57:36 +0400
Message-ID: <467BE360.7010805@ru.mvista.com>
References: <467A7D5A.9070009@msgid.tls.msk.ru> <467BD96C.4090005@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:8827 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756741AbXFVOzy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jun 2007 10:55:54 -0400
In-Reply-To: <467BD96C.4090005@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-ide@vger.kernel.org

Hello, I wrote.

>> On each and every machine out there, and on every dmesg
>> output posted on numerous mailinglists, I see messages
>> similar to this:

>> scsi 0:0:0:0: Direct-Access     ATA      ST3250620NS      3.AE PQ: 0 
>> ANSI: 5
>> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
>> SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
>> support DPO or FUA

>> for SATA disk drives.  And I wonder -- are those features
>> supported at all by linux,

    FUA is surely supported by libata.

>> and/or are there disk drives out there which supports it as well?

>    Don't know, the bits have just quite recently been included into ATA 
> spec, IIRC...

    FUA was introduced by ATA/PI-7.  There's no DPO support.

>> For my Seagate ST3250620NS SATA drive (it's a "server" drive,
>> whatever it means), I can see -- at least --

>>            *    Mandatory FLUSH_CACHE
>>            *    FLUSH_CACHE_EXT

>> reported by hdparm -I.  I wonder what "FLUSH CACHE EXT" means,

>    It reports LBA48 of a failing sector while FLUSH CACHE can only 
> report LBA28.

    I meant the sector which failed to be written to.

>> and whenever it can be used to support DPO and/or FUA...

>    DPO and FUA bits are a part of SCSI CDB and so only affect the block 
> range specified by the command in question while FLUSH CACHE [EXT] 
> operates on the whole cache -- so, it's not equivalent.

    And yet I didn't name the reason of the non-equivalency for DPO: this bit 
effectively prohibits drive cache replacement to occur as a result of a 
command in question -- this simply has nothing to do with flushing.

>> Thanks.

>> /mjt

MBR, Sergei
