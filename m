From: Michael Thonke <iogl64nx@gmail.com>
Subject: Re: Playing with SATA NCQ
Date: Mon, 30 May 2005 20:34:59 +0200
Message-ID: <429B5CD3.7080106@gmail.com>
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299F47B.5020603@gmail.com>	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>	 <1117438192.4851.29.camel@localhost.localdomain>  <429B56CA.5080803@rtr.ca> <1117477364.3108.2.camel@localhost.localdomain> <429B5A94.6010301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:35479 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261708AbVE3SfD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 May 2005 14:35:03 -0400
Received: by wproxy.gmail.com with SMTP id 68so1807434wri
        for <linux-ide@vger.kernel.org>; Mon, 30 May 2005 11:35:03 -0700 (PDT)
In-Reply-To: <429B5A94.6010301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Erik Slagter <erik@slagter.name>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Mark Lord schrieb:

> Erik Slagter wrote:>
>
>> Still I'd like to run in ACHI mode ;-)
>
>
> Me too!  But from reading the ICH6 Intel docs,
> it seems that AHCI mode is only for true SATA drives.
>
> Or perhaps I've mis-read that part.
>
> Cheers
>
Well your're right NCQ i only a feature of SATA drives (native ones) not
like the SATA drives
that uses Marvell Brigde chip (orig. PATA) like Samsung SP80 SPxxxx series.
The new ones are real SATA drives. But some PATA devices and controllers
support TCQ.
There're surviral docs about this..also Jeff Garzik mentoined it on his
libata doc site.


Greets and best regards

    Michael
