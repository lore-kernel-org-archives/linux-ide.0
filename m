From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: [git patches] libata updates - (improve post-reset
 device ready test) regression
Date: Fri, 09 May 2008 10:54:09 -0400
Message-ID: <48246591.7040209@rtr.ca>
References: <20080506154847.GA15299@havoc.gtf.org>	<20080507145616.GA2210@gentoox2.trippelsdorf.de>	<48231DAF.7070900@garzik.org> <20080508234300.3c2a38af@werewolf.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2389 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbYEIOyL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 May 2008 10:54:11 -0400
In-Reply-To: <20080508234300.3c2a38af@werewolf.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?IkouQS4gTWFnYWxsw7NuIg==?= <jamagallon@ono.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linus-IDE <linux-ide@vger.kernel.org>

J.A. Magall=C3=B3n wrote:
> On Thu, 08 May 2008 11:35:11 -0400, Jeff Garzik <jeff@garzik.org> wro=
te:
>=20
>> Markus Trippelsdorf wrote:
>>>> Tejun Heo (12):
>>>>       libata: improve post-reset device ready test
>>> This commit (78ab88f04f44bed566d51dce0c7cbfeff6449a06) causes a lon=
g
>>> boot delay with my onboard Promise controller. It seems like libata
>>> probes for a nonexisting PATA drive...
>>>
>=20
> I also had this patch collected from LKML, that still applies to -git=
6.
> Is it really needed ?
> ref: http://marc.info/?l=3Dlinux-ide&m=3D120913178617926&w=3D2
=2E.
> --- upstream/drivers/ata/libata-eh.c	2008-04-30 17:35:36.000000000 -0=
400
> +++ linux/drivers/ata/libata-eh.c	2008-04-30 17:35:45.000000000 -0400
> @@ -1312,8 +1312,7 @@
>  		err_mask |=3D AC_ERR_ATA_BUS;
>  		action |=3D ATA_EH_RESET;
>  	}
> -	if (serror &
> -	    (SERR_DATA_RECOVERED | SERR_COMM_RECOVERED | SERR_DATA)) {
> +	if (serror & (SERR_DATA_RECOVERED | SERR_DATA)) {
>  		err_mask |=3D AC_ERR_ATA_BUS;
>  		action |=3D ATA_EH_RESET;
>  	}

=2E.

The original problem I had, which prompted this patch, eventually was
resolved in other ways.  But I do think that a hw-recovered bit in SErr=
or
is not a good reason to reset everything.

Tejun suggested that we still want to know about such errors,
and eventually do something if they repeat often enough.
But doing a port/link reset every single time ?=20

> @@ -1924,7 +1923,7 @@
>  	}
> =20
>  	if (ehc->i.serror)
> -		ata_port_printk(ap, KERN_ERR,
> +		ata_link_printk(link, KERN_ERR,
>  		  "SError: { %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s}\n",
>  		  ehc->i.serror & SERR_DATA_RECOVERED ? "RecovData " : "",
>  		  ehc->i.serror & SERR_COMM_RECOVERED ? "RecovComm " : "",
>=20
=2E.

That portion of the patch is still a very good idea.

Cheers
