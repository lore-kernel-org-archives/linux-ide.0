From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 3/3 v2] AT91: initialize Compact Flash on AT91SAM9263 cpu
Date: Fri, 6 Feb 2009 14:33:19 +0100
Message-ID: <200902061433.19490.stf_xl@wp.pl>
References: <200902061214.19789.stf_xl@wp.pl> <498C2A57.6010908@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:28275 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594AbZBFNdW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Feb 2009 08:33:22 -0500
In-Reply-To: <498C2A57.6010908@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

=46riday 06 February 2009 13:17:27 Sergei Shtylyov napisa=C5=82(a):
> > +void __init at91_add_device_cf(struct at91_cf_data *data)
> > +{
> >  =20
> [...]
> > +	/* enable EBI controlled pins */
> > +	at91_set_A_periph(AT91_PIN_PD5, 1);  /* NWAIT */
> > +	at91_set_A_periph(AT91_PIN_PD8, 0);  /* CFCE1 */
> > +	at91_set_A_periph(AT91_PIN_PD9, 0);  /* CFCE2 */
> > +	at91_set_A_periph(AT91_PIN_PD14, 0); /* CFNRW */
> > +
> > +	if (data->flags & AT91_CF_TRUE_IDE)
> >  =20
>=20
>    Again, I've probably missed something but this structre doesn't ha=
ve=20
> the 'flags' field. How is this suppoed to compile?
Patch 2/3 add flags to the at91_cf_data structure.

Stanislaw Gruszka
