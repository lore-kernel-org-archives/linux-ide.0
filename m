From: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH 2/2] pata_amd: add support for CS5535 controllers
Date: Fri, 3 Jul 2009 11:33:59 -0300
Message-ID: <be7a9f3d0907030733w460e63b1o5c48206ebb7e574e@mail.gmail.com>
References: <1246630963-5831-1-git-send-email-otavio@ossystems.com.br>
	 <1246630963-5831-2-git-send-email-otavio@ossystems.com.br>
	 <20090703153110.3fa5dfbd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:48102 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbZGCOeF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jul 2009 10:34:05 -0400
Received: by an-out-0708.google.com with SMTP id d40so5488441and.1
        for <linux-ide@vger.kernel.org>; Fri, 03 Jul 2009 07:34:08 -0700 (PDT)
In-Reply-To: <20090703153110.3fa5dfbd@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Fri, Jul 3, 2009 at 11:31 AM, Alan Cox<alan@lxorguk.ukuu.org.uk> wro=
te:
> On Fri, =A03 Jul 2009 11:22:43 -0300
> Otavio Salvador <otavio@ossystems.com.br> wrote:
>
> We already have a CS5535 driver: drivers/ata/pata_cs5535.c
>
> That drives the hardware via the MSR interface which means it doesn't
> rely so much on what firmware and firmware related magic happens to b=
e on
> a given system.

Right but why not also support it at pata_amd as it is done for cs5536?

If the native ones are the suitable ones then wouldn't be better to
drop cs5536 from pata_amd and leave just the native ones as
alternative?

--=20
Otavio Salvador                  O.S. Systems
E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854         http://projetos.ossystems.com.br
