From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 08 May 2007 14:45:25 +0200
Message-ID: <464070E5.7090006@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134303.57f95d63@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:57745 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967043AbXEHMpj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 08:45:39 -0400
Received: by py-out-1112.google.com with SMTP id a29so1465855pyi
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 05:45:38 -0700 (PDT)
In-Reply-To: <20070508134303.57f95d63@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
>> One thing I'm worried about is that somehow I'm thinking there are
>> controllers/devices out there which choke if there PIO data transfer is
>> interrupted (timing-wise).  Is this something I just imagined up?
> 
> There are a couple of problem controllers. They use the
> ata_data_xfer_noirq method for ->data_xfer() which blocks local
> interrupts in the method itself and in those cases we have no choice. Such
> chips are all ancient thankfully.

OIC, using separate data_xfer() definitely makes sense.

-- 
tejun
