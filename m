From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 0/4] libata: irq driven pio follow-up patches
Date: Fri, 30 Sep 2005 07:21:43 -0400
Message-ID: <433D1FC7.2060401@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:64131 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030278AbVI3LWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2005 07:22:11 -0400
In-Reply-To: <433D1BC7.6060301@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Applied patches 1-4 to irq-pio branch.

I wonder if dataout_task and pio_task can be merged?

	Jeff



