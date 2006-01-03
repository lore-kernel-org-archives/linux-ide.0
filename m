From: Wes Newell <w.newell@verizon.net>
Subject: Re: PATCH: Small fixes backported to old IDE SiS driver
Date: Tue, 03 Jan 2006 11:09:38 -0600
Message-ID: <43BAAFD2.7020702@verizon.net>
References: <1136301581.22598.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms048pub.verizon.net ([206.46.252.48]:45454 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932437AbWACRJh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jan 2006 12:09:37 -0500
In-reply-to: <1136301581.22598.5.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org

Alan Cox wrote:

>Some quick backport bits from the libata PATA work to fix things found
>in the sis driver. The piix driver needs some fixes too but those are
>way to large and need someone working on old IDE with time to do them.
>
>This patch fixes the case where random bits get loaded into SIS timing
>registers according to the description of the correct behaviour from
>Vojtech Pavlik. It also adds the SiS5517 ATA16 chipset which is not
>currently supported by the driver. Thanks to Conrad Harriss for loaning
>me the machine with the 5517 chipset.
>
>Alan
>  
>
Did you guys ever get pata working for the real SIS180 chipset? And I 
don't mean the one that's reported as one in the 964 chipset, but a real 
SIS180 like is on the Jetway S755MAX that has 2 serial and 1 pata channels.
