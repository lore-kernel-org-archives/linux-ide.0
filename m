From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 3/4] irq-pio: integrate ata_pio_first_block() with
 ata_pio_task()
Date: Tue, 04 Oct 2005 06:10:25 -0400
Message-ID: <43425511.1040700@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412F91.4040305@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:3494 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751207AbVJDKKa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 06:10:30 -0400
In-Reply-To: <43412F91.4040305@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Albert Lee wrote:
> Patch 3/4: integrate ata_pio_first_block() with ata_pio_task()
> 
> Changes:
>    - change the return value of ata_pio_complete()
>    - add return value for ata_pio_first_block() to avoid queuing another 
> ata_pio_task()
>    - rename variable "qc_completed" to "has_next" in ata_pio_task()

seems OK.

not applied since patch #2 was not applied.


