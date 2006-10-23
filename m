From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fix ATA passthrough handling for ATAPI devices
Date: Mon, 23 Oct 2006 11:55:35 +0900
Message-ID: <453C2F27.9030302@gmail.com>
References: <20061020050948.GF13677@htj.dyndns.org> <453A720C.6070905@pobox.com> <453A7C6B.3050108@torque.net> <453A7F6B.1010205@pobox.com> <453A8E96.9040702@torque.net> <453A93CB.9000008@pobox.com> <453AA91D.8060803@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:8334 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751282AbWJWCzm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Oct 2006 22:55:42 -0400
Received: by nf-out-0910.google.com with SMTP id c2so2241487nfe
        for <linux-ide@vger.kernel.org>; Sun, 22 Oct 2006 19:55:41 -0700 (PDT)
In-Reply-To: <453AA91D.8060803@torque.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dougg@torque.net
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Douglas Gilbert wrote:
>> 1) The kernel must prevent 16-byte non-passthru commands from reaching
>> 12-byte-only ATAPI devices.
> 
> I would prefer to see the command sent through until
> it hits a transport that cannot carry a 16 byte cdb.
> That transport may be in an external enclosure, or
> the limitation may have been removed.

The host max CDB len has never been a proper protection against illegal 
CDB length.  Think about PATA, ata_piix SLAVE_POSS or PMP cases sharing 
the host w/ ATA devices.  Max CDB len is always 16 in such cases whether 
an ATAPI device supports 12 or 16 byte CDB.  Also, max CDB len doesn't 
protect against smaller CDB (12 bytes) when the device supports 16 byte 
CDBs.

So, for some cases, we had protection and in many others we didn't. 
We've always depended on applications sending correctly sized CDBs and 
ATAPI devices aborting wrong sized CDBs.

I'm not sure whether the protection is necessary, but if it is, we can 
do the protection *properly* by moving cdb restriction to lower level 
such that it's applied per-device not per-host.  This also solves the 
16byte passthrough problem.

IMHO, this issues is separate from SAT passthrough and needs 
improvements regardless.

>> 2) Existing in-the-field solutions that issue commands such as BLANK or
>> a vendor-reserved 0x85 opcode must continue working, without recompile.
> 
> Opcodes 0x85 and 0xa1 are not vendor reserved. They have
> been reserved for t10.org use since SCSI-2. Other SCSI
> opcode ranges are set aside for vendor use.
> The BLANK problems remains.

Ah.. I haven't thought about opcode clash.  I'm all ears on this.  Just 
tell me what to do, I'll go and implement it.

Thanks.

-- 
tejun
