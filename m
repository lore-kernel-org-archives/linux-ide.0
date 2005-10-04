From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 4/4] CHS: calculate LBA28/LBA48 commands and protocol
 on the fly
Date: Tue, 04 Oct 2005 08:52:13 -0400
Message-ID: <43427AFD.1020405@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com> <434276B9.7080807@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:29863 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932417AbVJDMwY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 08:52:24 -0400
In-Reply-To: <434276B9.7080807@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Albert Lee wrote:
> Patch 4/4: calculate LBA28/LBA48 commands and protocol on the fly
> 
> Changes:
>    - calculate LBA28/LBA48 commands and protocol on the fly per Mark and 
> Jeff's advice
>    - add ATA_CMD_READ_MULTI, etc. to ata.h
>    - add multi_count to ata_device (just pave the road for r/w multiple)
>    - removed xfer_protocol, read_cmd and write_cmd from ata_device.
>    - merge ata_prot_to_cmd() and ata_dev_set_protocol() and move it to 
> libata-scsi.c

seems OK at first glance, but please move the LBA28/LBA48 optimization 
change into a separate patch from the rest of these cleanups.

not applied.

