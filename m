From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 4/4] irq-pio: add read/write multiple support
Date: Tue, 04 Oct 2005 08:07:07 -0400
Message-ID: <4342706B.3030608@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:64678 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932397AbVJDMHT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 08:07:19 -0400
In-Reply-To: <43426ED9.8030004@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Albert Lee wrote:
> I would like to work on the LBA28/LBA48 translation. Please withdraw the 
> r/w multiple patch 4/4 for the moment since it might conflict with it.
> Thanks.

Now that your C/H/S support work is merged into the 'upstream' branch 
(queued for 2.6.15), the LBA28/LBA48 translation work is probably 
easier.  Your C/H/S patches really did a good job of cleaning up 
ata_scsi_rw_xlat().

	Jeff


