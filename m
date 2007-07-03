From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA: Is "DPO and FUA" ever supported?
Date: Tue, 03 Jul 2007 16:10:15 +0900
Message-ID: <4689F657.1010106@gmail.com>
References: <467A7D5A.9070009@msgid.tls.msk.ru> <467BD96C.4090005@ru.mvista.com> <467BE360.7010805@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:24144 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbXGCHKX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 03:10:23 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2649457wah
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 00:10:23 -0700 (PDT)
In-Reply-To: <467BE360.7010805@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
>>> scsi 0:0:0:0: Direct-Access     ATA      ST3250620NS      3.AE PQ: 0
>>> ANSI: 5
>>> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
>>> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
>>> support DPO or FUA
> 
>>> for SATA disk drives.  And I wonder -- are those features
>>> supported at all by linux,
> 
>    FUA is surely supported by libata.

Yeah, all the code is there but it is disabled by default.  The problem
is that some controllers can't handle FUA opcodes properly (sata_sil or
sil24 was one of them, I think) and we need to white or black list
controllers which never happened.

>>> and whenever it can be used to support DPO and/or FUA...
> 
>>    DPO and FUA bits are a part of SCSI CDB and so only affect the
>> block range specified by the command in question while FLUSH CACHE
>> [EXT] operates on the whole cache -- so, it's not equivalent.
> 
>    And yet I didn't name the reason of the non-equivalency for DPO: this
> bit effectively prohibits drive cache replacement to occur as a result
> of a command in question -- this simply has nothing to do with flushing.

DPO doesn't really affect the meaning of the operation.  FUA saves one
command during barrier sequence.  Not a bit gain but might still be useful.

FUA being pretty new on ATA land, I'm worried about firmwares which have
screwed up the implementation and doesn't really do FUA when instructed
to, which contributed to FUA support being left disabled.

-- 
tejun
