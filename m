From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: MSI broken in libata?
Date: Thu, 21 Jan 2010 18:53:11 -0600
Message-ID: <51f3faa71001211653s6ec4b2eep9f63a44a4f1fe674@mail.gmail.com>
References: <64bb37e0912250122n4e0e1842q88c0dad7e99ec6a7@mail.gmail.com>
	 <4B4A815A.60503@gmail.com>
	 <64bb37e1001161358r79ea2da0u88e9894fa5987ef1@mail.gmail.com>
	 <4B536383.7090609@gmail.com>
	 <64bb37e1001171311u21c58fbj9a13b6aaeb7b2c3f@mail.gmail.com>
	 <64bb37e1001181251y733513cdm1be9850af880ee73@mail.gmail.com>
	 <4B55130D.8070503@gmail.com>
	 <64bb37e1001191220u72f7af29xdc1c39f1d114bc21@mail.gmail.com>
	 <51f3faa71001191900y521f2be3u3a5e341f3113559@mail.gmail.com>
	 <64bb37e1001192248nbcb2b55pf9bab5f3fb909354@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f196.google.com ([209.85.223.196]:38353 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab0AVAxN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jan 2010 19:53:13 -0500
In-Reply-To: <64bb37e1001192248nbcb2b55pf9bab5f3fb909354@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Wed, Jan 20, 2010 at 12:48 AM, Torsten Kaiser
<just.for.lkml@googlemail.com> wrote:
>>> Output of the __assign_irq:
>>> 4x PCIe bridge:
>>> [ =A0 =A01.759016] __assign_irq_vector:assigning irq 24 to vector 7=
3
>>> [ =A0 =A01.764928] __assign_irq_vector:assigning irq 25 to vector 8=
1
>>> [ =A0 =A01.770827] __assign_irq_vector:assigning irq 26 to vector 8=
9
>>> [ =A0 =A01.776720] __assign_irq_vector:assigning irq 27 to vector 9=
7
>>> sata_sil24 first gets 19:
>>> [ =A0 =A01.856245] __assign_irq_vector:assigning irq 19 to vector 1=
05
>>> then switches to MSI-28:
>>> [ =A0 =A01.870768] __assign_irq_vector:assigning irq 28 to vector 1=
13
>>> 3 normal interrupts for sata_nv:
>>> [ =A0 =A01.908504] __assign_irq_vector:assigning irq 23 to vector 1=
21
>>> [ =A0 =A01.953848] __assign_irq_vector:assigning irq 22 to vector 1=
29
>>> [ =A0 =A01.999155] __assign_irq_vector:assigning irq 21 to vector 1=
37
>>>
>>> Writing failed again without a message, but the read test showed:
>>> [ =A0 85.695745] do_IRQ: 0.165 No irq handler for vector (irq -1)
>>> [ =A0 85.695763] do_IRQ: 1.165 No irq handler for vector (irq -1)
>>> [ =A0 85.695785] do_IRQ: 3.165 No irq handler for vector (irq -1)
>>> [ =A0 85.695800] do_IRQ: 2.165 No irq handler for vector (irq -1)
>>> Same vector in this error, but sata_sil24 had MSI irq 28 instead of=
 29!
>>> And the vector allocations where not even near 165!
>>
>> Hmm.. Can you send the output of lspci -vv with MSI in use?
>
> I had already done so at the start of this thread, both for MSI and
> the normal, working case:
> http://lkml.org/lkml/2009/12/25/12
> ( http://marc.info/?l=3Dlinux-kernel&m=3D126173296807440&w=3D2 might =
be
> better, als lkml.org seems to eat the attachment borders)
>
> For the minimal kernel with only the sata_nv and sata_sil24 drivers
> the output looks like this:

Well, that doesn't seem that illuminating. Still mysterious where 165
could be coming from.

Anyone have any ideas how random IRQ vectors could be showing up on
the APIC with MSI?
