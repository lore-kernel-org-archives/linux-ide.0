From: Balazs Ree <ree@ree.hu>
Subject: Re: unable to set udma >= 3 on ich5 on 2.6.11
Date: Thu, 23 Jun 2005 06:48:55 +0200
Message-ID: <pan.2005.06.23.04.48.47.954791@ree.hu>
References: <564d96fb05062005064283caaf@mail.gmail.com> <pan.2005.06.21.17.50.40.495619@ree.hu> <200506212251.27168.rafael.espindola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41677 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262124AbVFWFAx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jun 2005 01:00:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DlJjD-0002b3-72
	for linux-ide@vger.kernel.org; Thu, 23 Jun 2005 06:54:15 +0200
Received: from 3e44bdc0.adsl.enternet.hu ([62.68.189.192])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2005 06:54:15 +0200
Received: from ree by 3e44bdc0.adsl.enternet.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2005 06:54:15 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tue, 21 Jun 2005 22:50:52 -0300 keltez=E9ssel Rafael =C1vila de Esp=EDn=
dola
azt =EDrta:

> Em Tue 21 Jun 2005 14:50, Balazs Ree escreveu:
>> Just a blind guess... you might
>> want to try to set the kernel parameter CONFIG_IDEDMA_IVB (IGNORE
>> word93 Validation BITS). I had this problem recently and this was
>> the one that solved it. But I am not an expert so pardon me if I sai=
d
> It worked!
> Thanks.
>=20
> What is to blame? ICH5? If so, Is there a  black list were I could ad=
d it?

To me it seems that there are two implementations of the 80cc ribbon
detection in the kernel - one is the "standard" and the other one is th=
e
one that some drives actually implement? Or how is that? Maybe it would=
 be
good to make the default setting to "true" in the kernel config or rath=
er
just put some more emphasized hint about this in some docs where people
bump into it more easily? It is true that the help text of the config
parameter tells exactly what to do, but otherwise I spent a long time
investigating this problem before finding the "obvious", and I guess I'=
m
not alone.

--=20
Bala'zs REE' jabber + email: ree@ree.hu
             ICQ: 75955071   AIM + skype: reebalazs


