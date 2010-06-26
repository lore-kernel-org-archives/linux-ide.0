From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ata link not reset properly
Date: Fri, 25 Jun 2010 22:07:10 -0600
Message-ID: <4C257CEE.2070309@gmail.com>
References: <4C223F8A.9030306@odi.ch> <4C224429.6010705@kernel.org> <4C224502.2040206@kernel.org> <4C2305A8.4070708@odi.ch> <4C24C903.1070705@kernel.org> <4C24EED2.4020300@odi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40538 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0FZEHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jun 2010 00:07:16 -0400
In-Reply-To: <4C24EED2.4020300@odi.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 06/25/2010 12:00 PM, Ortwin Gl=FCck wrote:
>
>
> On 25.06.2010 17:19, Tejun Heo wrote:
>> Patch attached, but please see below.
>
> Cheers, I will give it a try and provide feedback if "it" happens aga=
in.
>
>> Is it PATA?
>
> Yes. This chipset doesn't have SATA, only PATA.

Ahh, ok, it's not sata_nv at all then, it's pata_amd. On the same chip,=
=20
totally different controller though.

PATA doesn't normally use hard-resets as a means of error recovery -=20
that would mean hitting the RESET line, which I don't think most=20
controllers can do on software command (it usually only gets asserted o=
n=20
power up or hitting the reset button), unlike on SATA where there's a=20
defined way to trigger a COMRESET which is mostly equivalent. Also, tha=
t=20
resets both devices on the channel, unlike soft reset which is specific=
=20
to one device.

>
> CONFIG_ATA=3Dy
> CONFIG_ATA_SFF=3Dy
> CONFIG_SATA_NV=3Dy
> CONFIG_PATA_AMD=3Dy
>
>> Why do you have 2.01?
>
> for the DVD drive?
>
>> Can you please attach full boot
>> log?
>
> attached.
>
> Thanks.
>   Ortwin

