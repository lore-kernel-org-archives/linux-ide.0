From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 0/4] libata: more CHS follow-up patches
Date: Thu, 06 Oct 2005 07:26:39 -0400
Message-ID: <434509EF.3040307@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com> <434276B9.7080807@tw.ibm.com> <43427AFD.1020405@pobox.com> <4343B5F5.4090402@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:28641 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750802AbVJFL0t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 07:26:49 -0400
In-Reply-To: <4343B5F5.4090402@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Albert Lee wrote:
> Dear all,
> 
> More CHS follow-up patches:
> 
> patch 1/4: move the initialization of ATA_TFLAG_LBA and ATA_TFLAG_LBA48 
> flags to the SCSI translation functions
> 
> patch 2/4: calculate read/write commands and protocols on the fly

These two patches are OK, but failed to apply, probably due to mailer 
issues.

> [jgarzik@pretzel libata-dev]$ patch -sp1 < /g/tmp/mbox 
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/scsi/libata-core.c.rej
> 7 out of 7 hunks FAILED -- saving rejects to file drivers/scsi/libata-scsi.c.rej


> patch 3/4: support overriding the ata_rwcmd_protocol() function

Your above patches make it easy enough to add this patch at any time.  I 
would rather wait until Alan is actually using the hook in his code.


> patch 4/4: optimize LBA28/LBA48 usage

seems OK, but I would like this to see a lot of testing before getting 
merged.  Once they are mailer-unmunged, I will apply patches #1 and #2 
to 'upstream' branch.  Then I will clone a branch from upstream called 
optimize-lba48, and apply patch #4.

I'm worried, for example, that some hardware may not have been tested 
much in the field with rapid switching between LBA28 and LBA48.

	Jeff


