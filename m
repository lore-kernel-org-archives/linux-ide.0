From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before slave_data
Date: Sat, 19 Feb 2011 10:25:53 +0100
Message-ID: <AANLkTinE5x=hmQ6Oykw3Tb38HVeL5eHxjdnPOdMt930q@mail.gmail.com>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122409.19110.4233.sendpatchset@linux-mhg7.site>
	<20110208130701.19709cc6@lxorguk.ukuu.org.uk>
	<AANLkTimAioh_xu0qoQCndSWDAYJ4bpWv01NZn_bZ9g2a@mail.gmail.com>
	<20110208132518.300bb098@lxorguk.ukuu.org.uk>
	<4D514754.30203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57243 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1BSJZz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Feb 2011 04:25:55 -0500
In-Reply-To: <4D514754.30203@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hi,

On Tue, Feb 8, 2011 at 2:38 PM, Sergei Shtylyov <sshtylyov@mvista.com> =
wrote:
> Hello.
>
> On 08-02-2011 16:25, Alan Cox wrote:
>
>>>>> We may need to set SITRE before programming slave_data.
>
>>>> Do you have a documentation cite for this or is it random fiddling=
 with
>>>> a
>>>> driver you can't test ?
>
>>> It is good to enable SITRE register before programming it and all
>>> Intel controllers
>
>> That sounds like someone quoting religion. Documentation cite please=
=2E
>
> =A0 SLC90E66 datasheet only says that SIDETIM register has no effect =
without
> SITRE bit set.

Alan, is this explanation sufficient to ACK this patch?  (Thanks
Sergei for digging it out.)

Jeff, would it be possible to queue patches #01-15 for 2.6.39 if there
are no further concerns with them (thus leaving the merging of
PIIX-like drivers for later)?  They got additional testing on ICH4 and
they look mostly safe & straight-forward compared to #16-21.

Thanks,
Bartlomiej
