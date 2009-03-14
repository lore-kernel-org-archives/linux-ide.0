From: Avuton Olrich <avuton@gmail.com>
Subject: Generic timeout warnings begin after v2.6.25 but before v2.6.26-rc1
	[Was: DRDY ata message > 2.6.24.7-rt14, not before.]
Date: Sat, 14 Mar 2009 13:51:36 -0700
Message-ID: <3aa654a40903141351y26f2e732t67dd1ac69651f909@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:23799 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbZCNUvj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 16:51:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux IDE <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@pobox.com>

On Fri, Feb 27, 2009 at 3:54 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
> Avuton Olrich wrote:
>>
>> ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>> ata4.00: cmd 35/00:10:b0:70:75/00:00:1f:00:00/e0 tag 0 dma 8192 out
>> =A0 =A0 =A0 =A0 res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (t=
imeout)
>
>
> Since you are seeing generic timeouts, without additional information=
, I
> would guess either a problem with interrupt delivery (not uncommon in=
 -rt
> kernels) or you need to force your drives to 1.5Gbps.
>
> =A0 =A0 =A0 =A0Jeff

OK, I have tried to bisect it (completely without -rt) and it breaks
completely somewhere on the outer limits of this bug. Unfortunately,
there was an unrelated libata bug which made it where 4 of my drives
were not recognized, and since the drive that has this general timeout
issue with linux is dedicated to an lvm I depend on those other drives
so I can mount the lvm so I can reproduce this bug.

What I do know:

Good: v2.6.25
Bad: pre v2.6.26-rc1 (9752082560b440e6a45624569d26802e20d1b8b4)

Please, How can I help further?
--=20
avuton
--
|  (\_/)  This is Bunny. Copy and paste Bunny
| (=3D'.'=3D) into your signature to help him gain
| (")_(") world domination.
