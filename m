From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata [ata_piix] still no resume from S3 ?
Date: Sun, 22 Jul 2007 21:19:18 +0900
Message-ID: <46A34B46.6050204@gmail.com>
References: <20070712162450.GA7132@0x82.com> <469744DB.5070600@gmail.com>	 <20070714210117.GA20723@0x82.com> <469DD216.5040305@gmail.com>	 <20070719092053.GA21254@0x82.com> <469F2E4A.1020502@gmail.com>	 <20070719150436.GA9006@0x82.com>  <46A0552E.30606@gmail.com> <1185017817.7774.6.camel@0x82>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.232]:57400 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758885AbXGVMT0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 08:19:26 -0400
Received: by qb-out-0506.google.com with SMTP id o24so897656qba
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 05:19:25 -0700 (PDT)
In-Reply-To: <1185017817.7774.6.camel@0x82>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?UsO6YmVuIEZvbnNlY2E=?= <krani1@0x82.com>
Cc: Linux Kernel Mailling List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

R=C3=BAben Fonseca wrote:
> On Fri, 2007-07-20 at 15:24 +0900, Tejun Heo wrote:
>> R=C3=BAben Fonseca wrote:
>>> I wish I could disable this card reader. It is built in on the hard=
ware,
>>> and there are no drivers for Linux. There is no option on the BIOS =
to
>>> disable the device. Is there any way (kernel parameters, magic prog=
ram,
>>> etc) to disable this device without opening my laptop to cut the wi=
res?
>>> :D
>> OIC.  How about not loading tifm_7xx1 module?  Does that make any
>> difference?
>>
>=20
> AFAIK the tifm_7xx1 module belongs to the other card reader I have on
> this laptop (see device ID 09.04.0). This one is a cardbus device and=
 I
> can simply disconnect it on startup, and the tifm_7xx1 modulo is neve=
r
> loaded. Anyway I've tried without this card and module and it still
> doesn't work.

Can you post the failing log (just take a picture of the screen) with
the card reader disconnected?

--=20
tejun
