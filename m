From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH v2] ata_piix: minor typo and a printk fix
Date: Tue, 01 Oct 2013 19:39:24 +0200
Message-ID: <524B08CC.7010604@linux.com>
References: <52459308.1040905@linux.com> <20130930193628.GA8091@htj.dyndns.org>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:34200 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab3JARj3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Oct 2013 13:39:29 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so3553823eae.38
        for <linux-ide@vger.kernel.org>; Tue, 01 Oct 2013 10:39:26 -0700 (PDT)
In-Reply-To: <20130930193628.GA8091@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

2013-09-30 21:36 keltez=E9ssel, Tejun Heo =EDrta:
> Hello,
>=20
> Tried to apply it but patch seems whitespace damaged and doesn't
> apply.  Please resend.  Also, one comment.
>=20
> On Fri, Sep 27, 2013 at 04:15:36PM +0200, Levente Kurusa wrote:
>> -	ICH5_PMR		=3D 0x90, /* port mapping register */
>> +	ICH5_PMR		=3D 0x90, /* address map register */
>=20
> I don't know whether the name has changed but PMR at least did stand
> for Port Mapping Register.  I don't see much point in updating the
> comment here.
>=20
> Thanks.
>=20

According to the specifications of ICH5, it is called
Address Map Register. I didn't want to change the variable's name,
because I think it would cause some headaches for those wanting to find
information on google.
http://www.intel.com/content/dam/doc/datasheet/82801eb-82801er-io-contr=
oller-hub-datasheet.pdf
See Chapter 11.1.32

The patch gets whitespace damaged due to Thunderbird, I will experiment
before resending it again.

--=20
Regards,
Levente Kurusa
