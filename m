From: "Michal 'hramrach' Suchanek" <hramrach@centrum.cz>
Subject: Re: Via SATA not working here
Date: Tue, 14 Sep 2004 11:43:36 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040914094336.GG18257@uvt316-2.ruk.cuni.cz>
References: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz> <414520BB.3080306@wasp.net.au>
Reply-To: "Michal 'hramrach' Suchanek" <hramrach@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dec59.ruk.cuni.cz ([195.113.2.17]:58130 "HELO dec59.ruk.cuni.cz")
	by vger.kernel.org with SMTP id S269240AbUINJpv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Sep 2004 05:45:51 -0400
Content-Disposition: inline
In-Reply-To: <414520BB.3080306@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>, f@uvt316-2.ruk.cuni.cz
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, Sep 13, 2004 at 08:23:23AM +0400, Brad Campbell wrote:
> Michal 'hramrach' Suchanek wrote:
> >Hello
> >
> >I found it would eventually lock up with the hdd led shining steadily.
I saw the lockup happen finally and I saw a stream of
hda: lost interrupt
I did not try to reproduce it with 2.6.5 because it takes hours of
compilig to cause the lockup.
> 
> Could you try it with a 2.6.5 kernel please? There were some changes made 
> between 2.6.5 and 2.6.7 that may well cause issues with HD's attached to 
> dongles. There have been patches created for this by they have not yet made 
> the mainstream kernel.
> 
> I'd be interested to see how that pans out.
With 2.6.5 I get the same results.

The libata error message:

ata1: DMA timeout, stat 0x0
ATA: abnormal status 0xD0 on prot 0xEC07
scsi0: ERROR on channel 0, id0, lin0, CDB: Write (10) 00 01 65 dc e7 00
00 42 00
Current sda: sense key Medium Error
Additional sense: Write Error - auto reallocation failed
end_request: I/O error, dev sda, sector 23452903
ATA: abnormal status 0xD0 on prot 0xEC07
ATA: abnormal status 0xD0 on prot 0xEC07
ATA: abnormal status 0xD0 on prot 0xEC07


Note that the 0xd0 is the same as the ide DMA timeout error.

Thanks

Michal Suchanek
