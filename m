From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: Re: [PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
Date: Sat, 26 Feb 2005 16:32:55 -0300
Message-ID: <20050226193255.GA6256@ime.usp.br>
References: <20050224015859.55191.qmail@web40910.mail.yahoo.com> <421D3D33.9060707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from smtpout5.uol.com.br ([200.221.4.196]:205 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S261246AbVBZTc5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Feb 2005 14:32:57 -0500
Received: from dumont.rtb.ath.cx (unknown [200.221.104.251])
	by scorpion5.uol.com.br (Postfix) with ESMTP id DF17C7A4D
	for <linux-ide@vger.kernel.org>; Sat, 26 Feb 2005 16:32:56 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <421D3D33.9060707@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brian Kuschak <bkuschak@yahoo.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Feb 23 2005, Jeff Garzik wrote:
> Does this patch do anything useful?
> 	Jeff
(...)

The patch you posted seems to only affect people using SATA, right?

BTW, just for clarity I'm seeing the message in a PATA environment (on
i386) and Brian is seeing his problem with a SATA device on ppc.


Thanks, Rog=E9rio Brito.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
  Rog=E9rio Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
