From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: PATA_ARTOP reads byte from PCI IO port without mapping it to the
 right address.
Date: Wed, 30 Mar 2011 12:36:16 -0700
Message-ID: <AANLkTimokmN5++Qghz-2pTDa7KLnRn_YBW-ox_9tP+XO@mail.gmail.com>
References: <4D937FDC.4090607@danielpalmer.co.uk> <20110330202628.5dc8db5f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47105 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754227Ab1C3UEe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Mar 2011 16:04:34 -0400
In-Reply-To: <20110330202628.5dc8db5f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Palmer <me@danielpalmer.co.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 30, 2011 at 12:26 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> w=
rote:
>> unsigned long io =3D pci_resource_start(pdev, 4); =A0 =A0 =A0 =A0 =A0=
 // This
>> returns 0x1400 on my machine
>
> That is the PCI port address.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 reg;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ppi[0] =3D &info_628x;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (inb(io) & 0x10)
>> =A0 =A0 =A0 =A0 =A0// This reads from 0x1400, which isn't were the p=
ort actually
>> is in the processors address
>
> This reads from I/O port 0x1400 - your inb logic and I/O port mapping=
 on
> the platform is responsible for making that work.

Indeed. We do _not_ expect inb/outb to do the equivalent of ioremap()
etc, since the IO port range is just 64kB. The arch code is supposed
to do whatever mapping it needs statically at bootup, and just make
inb/outb honor that mapping.

                          Linus
