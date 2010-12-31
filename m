From: Tejun Heo <tj@kernel.org>
Subject: Re: PMP 3726 problem?
Date: Fri, 31 Dec 2010 19:03:19 +0100
Message-ID: <20101231180319.GM18831@htj.dyndns.org>
References: <AANLkTi=6yROpG+nXHYPqHwbQucwQqmrai9yCyx=GFCPG@mail.gmail.com>
 <4D1BDB10.803@hardwarefreak.com>
 <AANLkTik+U4eh3bqx5oJ0wxU8+sJogGV+-tPzMTycSPTd@mail.gmail.com>
 <4D1DD305.1020701@hardwarefreak.com>
 <AANLkTikS8AgG6E6NeO4fRNHGiy3w2zWAa8aOYZsLKYpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37230 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab0LaSDY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Dec 2010 13:03:24 -0500
Received: by bwz15 with SMTP id 15so12509484bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 31 Dec 2010 10:03:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikS8AgG6E6NeO4fRNHGiy3w2zWAa8aOYZsLKYpA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phill Jolliffe <phill.jolliffe@gmail.com>
Cc: Stan Hoeppner <stan@hardwarefreak.com>, linux-ide@vger.kernel.org

On Fri, Dec 31, 2010 at 05:53:50PM +0000, Phill Jolliffe wrote:
> > That's bad. =A0I hate to be the bearer of bad news, but I'm pretty =
sure
> > you are screwed. =A0According to Google results, which are slim pic=
kens,
> > it seems the Intel H55 chipset does not support FIS based switching=
,
> > which means none of your mobo e/SATA =A0ports will work with a PMP.
>=20
> That doesn't sound so good :-)
>=20
> Can you expand on not work? It seems to be working perfectly *if* can
> get through a boot and detect the drives. This is about a 50% chance.

Does libata.force=3D1.5Gbps make any difference?

--=20
tejun
