From: Avuton Olrich <avuton@gmail.com>
Subject: Re: DRDY ata message > 2.6.24.7-rt14, not before.
Date: Fri, 27 Feb 2009 15:06:00 -0800
Message-ID: <3aa654a40902271506j35620f1byfd04171450581f25@mail.gmail.com>
References: <3aa654a40902270944h3edeadf4pc9fb7587b76d7e9e@mail.gmail.com>
	 <49A86F2E.3080701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:5525 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbZB0XGD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Feb 2009 18:06:03 -0500
In-Reply-To: <49A86F2E.3080701@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux IDE <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@pobox.com>

On Fri, Feb 27, 2009 at 2:54 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
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

Sure, what additional information can I give? I can do it, I just want
to try to minimize the damage :)

So:

1) I will try without -rt

2) I'm not sure if I'll get this error if the drive isn't mounted. If
I can then I will just stop it from mounting and do a bisect.

(please add more here that you need or want)
--=20
avuton
--
|  (\_/)  This is Bunny. Copy and paste Bunny
| (=3D'.'=3D) into your signature to help him gain
| (")_(") world domination.
