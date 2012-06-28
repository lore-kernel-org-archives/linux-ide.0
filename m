From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Highpoint DC7280
Date: Wed, 27 Jun 2012 23:30:37 -0600
Message-ID: <CADLC3L16mwinUHbDuSo-fctjeN4j81rZTT0fQ=dMX0b939W=5w@mail.gmail.com>
References: <4FDEDE3A.7030507@psi5.com>
	<4FDFF1C1.4060808@gmail.com>
	<4FEB345D.2070708@psi5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36300 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab2F1Fai convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2012 01:30:38 -0400
Received: by obbuo13 with SMTP id uo13so2534677obb.19
        for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2012 22:30:38 -0700 (PDT)
In-Reply-To: <4FEB345D.2070708@psi5.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Brandt <brandtc@psi5.com>
Cc: linux-ide@vger.kernel.org

On Wed, Jun 27, 2012 at 10:27 AM, Christian Brandt <brandtc@psi5.com> w=
rote:
> Sorry for the delay, I was sick for a couple of days.
>
> Am 19.06.2012 05:28, schrieb Robert Hancock:
>> What does lspci -vv show for that board?
>
> =A0Please see MIME attachment dc7280lspci-initialized.txt (for
> completeness, uninitialized the IRQ is 64 and MaxPayload is 128 bytes=
).
>
>> It looks like that driver contains a binary blob so who knows what i=
t is
>> actually doing internally.
>
> =A0I am now done playing with ubuntu 12.04 and are going to dig a bit
> deeper in using debian and a vanilla kernel.

Well, it looks like it doesn't claim compatibility with anything
standard like AHCI. If it's just a pure HBA with no hardware RAID,
etc. then I'm not sure exactly why there seems to be so much code in
the driver?
