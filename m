From: Eric Mudama <edmudama@gmail.com>
Subject: Re: Via SATA not working here
Date: Tue, 14 Sep 2004 09:03:19 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <311601c90409140803aaa4d31@mail.gmail.com>
References: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz>
	 <414520BB.3080306@wasp.net.au>
	 <20040914094336.GG18257@uvt316-2.ruk.cuni.cz>
Reply-To: Eric Mudama <edmudama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.207]:62157 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269380AbUINPDa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Sep 2004 11:03:30 -0400
Received: by mproxy.gmail.com with SMTP id 77so24549rnl
        for <linux-ide@vger.kernel.org>; Tue, 14 Sep 2004 08:03:20 -0700 (PDT)
In-Reply-To: <20040914094336.GG18257@uvt316-2.ruk.cuni.cz>
List-Id: linux-ide@vger.kernel.org
To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Cc: Brad Campbell <brad@wasp.net.au>, f@uvt316-2.ruk.cuni.cz, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, 14 Sep 2004 11:43:36 +0200, Michal 'hramrach' Suchanek
<hramrach@centrum.cz> wrote:
> With 2.6.5 I get the same results.
> 
> The libata error message:
> 
> ata1: DMA timeout, stat 0x0
> ATA: abnormal status 0xD0 on prot 0xEC07
> scsi0: ERROR on channel 0, id0, lin0, CDB: Write (10) 00 01 65 dc e7 00
> 00 42 00
> Current sda: sense key Medium Error
> Additional sense: Write Error - auto reallocation failed
> end_request: I/O error, dev sda, sector 23452903
> ATA: abnormal status 0xD0 on prot 0xEC07
> ATA: abnormal status 0xD0 on prot 0xEC07
> ATA: abnormal status 0xD0 on prot 0xEC07
> 
> Note that the 0xd0 is the same as the ide DMA timeout error.

Not sure how libata queried the additional sense: key/code/qual etc
from the drive, since it appears to have gotten a busy timeout.

FYI, 0xD0 is simply a 0x50 status (ready/seek complete) + the busy
bit, which is automatically set most by hardware upon receipt of a new
command.  In SATA, this is often set internally in a shadow task file
register, and has nothing to do with physical "registers" on the drive
itself.

Can someone quickie translate that CDB for me into its ATA command?

--eric
