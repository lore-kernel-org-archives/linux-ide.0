From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: SATA and full-duplex?
Date: Sun, 27 Sep 2009 13:21:01 -0600
Message-ID: <4ABFBB1D.8060608@gmail.com>
References: <9948385e0909270702s4670f785y1f45fb090eb5b282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:38342 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbZI0TVA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Sep 2009 15:21:00 -0400
Received: by ywh4 with SMTP id 4so4165850ywh.33
        for <linux-ide@vger.kernel.org>; Sun, 27 Sep 2009 12:21:04 -0700 (PDT)
In-Reply-To: <9948385e0909270702s4670f785y1f45fb090eb5b282@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?windows-1252?Q?David_Bala=9Eic?= <xerces9@gmail.com>
Cc: linux-ide@vger.kernel.org

On 09/27/2009 08:02 AM, David Bala=9Eic wrote:
> Hi!
>
> In a discussion with a friend the question whether SATA support full
> duplex has come up.
>
> While there is some info on the web that explains that SATA does not
> support it, unlike SAS, the firend claims that SATA does not support
> full-duplex in the sense "the same line can transfer data in both
> directions", but it does support sending data over the transmit pair
> and receiving over the receive pair at the same time.
>
> An example is : in NCQ setup, the drive is sending data as a response
> to READ command and during that the host send another queued command
> to the same drive.
>
> Is this possible and supported by SATA ?
> (I'm interested in SATA support as a standard, not as much about
> current Linux support)

Well, at the low level FISes can be sent in both directions at once on=20
the link. It's somewhat limited when this can happen, though, and=20
transferring actual data in both directions at the same time isn't=20
possible. The particular case you mentioned also isn't supposed to=20
happen: "The FPDMA Data Phase is defined as the period from reception o=
f=20
a DMA Setup FIS until either the associated transfer count is exhausted=
=20
or the ERR bit in the shadow Status register is set. During this period=
=20
the host may not issue new commands to the device nor may the device=20
signal new command completions to the host." Once a transfer starts, it=
=20
has to either finish or fail without anything else happening in the=20
interim. Basically the actual data transfers over the SATA link  are=20
"single-threaded".
