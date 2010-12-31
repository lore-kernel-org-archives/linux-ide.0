From: Phill Jolliffe <phill.jolliffe@gmail.com>
Subject: Re: PMP 3726 problem?
Date: Fri, 31 Dec 2010 17:53:50 +0000
Message-ID: <AANLkTikS8AgG6E6NeO4fRNHGiy3w2zWAa8aOYZsLKYpA@mail.gmail.com>
References: <AANLkTi=6yROpG+nXHYPqHwbQucwQqmrai9yCyx=GFCPG@mail.gmail.com>
 <4D1BDB10.803@hardwarefreak.com> <AANLkTik+U4eh3bqx5oJ0wxU8+sJogGV+-tPzMTycSPTd@mail.gmail.com>
 <4D1DD305.1020701@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40582 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab0LaRyW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Dec 2010 12:54:22 -0500
Received: by wwa36 with SMTP id 36so12612446wwa.1
        for <linux-ide@vger.kernel.org>; Fri, 31 Dec 2010 09:54:20 -0800 (PST)
In-Reply-To: <4D1DD305.1020701@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: linux-ide@vger.kernel.org

> That's bad. =A0I hate to be the bearer of bad news, but I'm pretty su=
re
> you are screwed. =A0According to Google results, which are slim picke=
ns,
> it seems the Intel H55 chipset does not support FIS based switching,
> which means none of your mobo e/SATA =A0ports will work with a PMP.

That doesn't sound so good :-)

Can you expand on not work? It seems to be working perfectly *if* can
get through a boot and detect the drives. This is about a 50% chance.

> Frankly I'm surprised you didn't purchase one with both eSATA and USB=
 3
> ports to begin with, just in case you ran into what you just did.

The mobo HDMI / DVI / VGA are no good with the processor I have as
there is no integrated graphics in the i5-760. Unless you know someway
round that with Linux??

I'm running xen as well and dom0 will make use of the PCIe graphics car=
d.
