From: echo6 <echo6_uk@yahoo.com>
Subject: Re: sata_inic162x  LED enable request
Date: Thu, 04 Sep 2008 19:14:37 +0100
Message-ID: <48C0258D.8040002@yahoo.com>
References: <695462.9268.qm@web904.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from n10.bullet.re3.yahoo.com ([68.142.237.123]:34454 "HELO
	n10.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752136AbYIDSVW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Sep 2008 14:21:22 -0400
In-Reply-To: <695462.9268.qm@web904.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bob,

It is a possibility, I guess I need to rape my laptop and replace a
drive with Windows on it to test just to be sure it isn't hardware.
Although I think you may be right, the card is duff.

Jon.

Bob Stewart wrote:
> Jon,
> 
> Are you aware that I had a card that "almost" worked, but
> would fail with timeouts under any sort of load?
> 
> 
> --- echo6 <echo6_uk@yahoo.com> wrote:
> 
> Hmmm,  thanks Bob, I guess I need to consider what else may be causing
> my system to hang with my setup.
> 
> Jon.
> 
> Bob Stewart wrote:
>>>> Tejun,
>>>>
>>>> I've been using the new driver to boot my second machine for about 2 weeks,
>>>> now, as well as having another 200GB disk hanging off it; all without any
>>>> problems.  Well done!  What I would like to see is the LED enabled
> properly,
>>>> although the board uses a different header pin for each drive.  Anyway, if
> I've
>>>> got it right, here is my suggested change.
>>>>
>>>> --- linux-2.6.27-rc5.a/drivers/ata/sata_inic162x.c	2008-08-28
>>>> 18:52:02.000000000 -0400
>>>> +++ linux-2.6.27-rc5.b/drivers/ata/sata_inic162x.c	2008-09-01
>>>> 14:05:24.000000000 -0400
>>>> @@ -96,6 +96,7 @@
>>>>  	PORT_SCR		= 0x20,
>>>>  
>>>>  	/* HOST_CTL bits */
>>>> +	HCTL_LEDEN		= (1 << 3),  /* enable LED operation */
>>>>  	HCTL_IRQOFF		= (1 << 8),  /* global IRQ off */
>>>>  	HCTL_FTHD0		= (1 << 10), /* fifo threshold 0 */
>>>>  	HCTL_FTHD1		= (1 << 11), /* fifo threshold 1*/
>>>> @@ -540,7 +541,7 @@
>>>>  	void __iomem *port_base = inic_port_base(ap);
>>>>  
>>>>  	/* fire up the ADMA engine */
>>>> -	writew(HCTL_FTHD0, port_base + HOST_CTL);
>>>> +	writew(HCTL_FTHD0 + HCTL_LEDEN, port_base + HOST_CTL);
>>>>  	writew(IDMA_CTL_GO, port_base + PORT_IDMA_CTL);
>>>>  	writeb(0, port_base + PORT_CPB_PTQFIFO);
>>>>
>>
>>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIwCWMbSv1saVS9ucRAoU6AKCGktFr4jCOa8VnYCBvrgFlq/NzDgCfcP4L
hLhvfiqFGDNq9v7XBEI2SYY=
=yTsD
-----END PGP SIGNATURE-----

