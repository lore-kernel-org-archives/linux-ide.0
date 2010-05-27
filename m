From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 4/4] pata_samsung: Add Samsung PATA controller driver
Date: Thu, 27 May 2010 18:18:42 +0900
Message-ID: <AANLkTil--urA89NTNxpu6FrdmFbxSoJ82KdUhDC0OOpd@mail.gmail.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
	<1274948524-2970-5-git-send-email-kgene.kim@samsung.com>
	<AANLkTikr8txaKEE0FO4d-nA-cpQv3zIQ8TALqM539fhz@mail.gmail.com>
	<20100527085714.GK4720@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20100527085714.GK4720@trinity.fluff.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

On Thu, May 27, 2010 at 5:57 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Thu, May 27, 2010 at 05:43:47PM +0900, Jassi Brar wrote:
>> On Thu, May 27, 2010 at 5:22 PM, Kukjin Kim <kgene.kim@samsung.com> =
wrote:
>> > From: Abhilash Kesavan <a.kesavan@samsung.com>
>> >
>> > Adds support for the Samsung PATA controller. This driver is based=
 on the
>> > Libata subsystem and references the earlier patches sent for IDE s=
ubsystem.
>> >
>> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>> > ---
>> > =C2=A0drivers/ata/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
9 +
>> > =C2=A0drivers/ata/Makefile =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> > =C2=A0drivers/ata/pata_samsung.c | =C2=A0591
>>
>> Fasten your seat belts before reading further....
>>
>> Rather than generic 'samsung', I would suggest the driver named
>> after the SoC, that is supported first(chronologically) in mainline =
kernel.
>> All newer SoCs should be simply taken to contain the controller of t=
hat SoC.
>> Otherwise, the same naming problem comes back to haunt us should
>> Samsung decides to use a different IP in future SoCs. What would we
>> call that driver? pata_samsung_v2.c ?
>
> I'm not so bothered, but it could be pata_samsung_cfcon or anything,
> a new block could be called pata_samsung_v2 or fred
well, then pata_samsung.c is better for we know chances of this IP chan=
ge in
future SoCs are quite slim.
And even if it does change we shall call it
pata_samsung_really_final_this_time.c ;)
