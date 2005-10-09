From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/3] libata: CHS follow-up patches (resend #4)
Date: Sun, 09 Oct 2005 09:41:58 -0400
Message-ID: <43491E26.40508@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com> <434276B9.7080807@tw.ibm.com> <43427AFD.1020405@pobox.com> <4343B5F5.4090402@tw.ibm.com> <434509EF.3040307@pobox.com> <43461B81.1090808@tw.ibm.com> <43463296.3090007@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:15772 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750711AbVJINmK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Oct 2005 09:42:10 -0400
In-Reply-To: <43463296.3090007@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Albert Lee wrote:
> (Resend #4, mailnews.wraplength	set to 0 to keep Thunderbird from trimming trailing whitespaces.
> Sorry for all the noises.)
> 
> 
> CHS follow-up patches.
> 
> patch 1/3: move the initialization of ATA_TFLAG_LBA and ATA_TFLAG_LBA48
> flags to the SCSI translation functions
> 
> patch 2/3: calculate read/write commands and protocols on the fly
> 
> patch 3/3: LBA28/LBA48 optimization

You've been very patient in resending, thanks :)

I wanted to go ahead and merge Doug Gilbert's error handling updates, 
which in turn caused some conflicts with your patches.  Would you please 
rediff and resend the same three patches, against the latest 'upstream' 
branch?

	Jeff



