From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH/RFC 4/4] CHS: calculate LBA28/LBA48 commands and
	protocol on the fly
Date: Tue, 04 Oct 2005 16:48:55 +0100
Message-ID: <1128440935.8564.9.camel@localhost.localdomain>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>
	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>
	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com>
	 <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com>
	 <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com>
	 <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com>
	 <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com>
	 <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com>
	 <434276B9.7080807@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:23199 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932532AbVJDPVc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Oct 2005 11:21:32 -0400
In-Reply-To: <434276B9.7080807@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>


> +	if (dev->flags & ATA_DFLAG_LBA) {
> +		qc->tf.flags |= ATA_TFLAG_LBA;
> +
> +		if (lba_28_ok(block, n_block)) {
> +			/* use LBA28 */
> +			tf->command = ATA_CMD_VERIFY;
> +
> +			tf->device |= (block >> 24) & 0xf;
> +		} else if (lba_48_ok(block, n_block)) {
> +			if (!(dev->flags & ATA_DFLAG_LBA48))
> +				return 1;
> +
> +			/* use LBA48 */
> +			qc->tf.flags |= ATA_TFLAG_LBA48;

Can you make this decision a function because older ALi controllers at
least will need to replace it (they do LBA48 PIO, LBA28 DMA)


