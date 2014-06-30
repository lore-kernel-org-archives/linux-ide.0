From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v7 1/7] phy: add a driver for the Berlin SATA PHY
Date: Mon, 30 Jun 2014 20:55:35 +0400
Message-ID: <53B19687.5050400@cogentembedded.com>
References: <1403530783-17180-1-git-send-email-antoine.tenart@free-electrons.com> <1403530783-17180-2-git-send-email-antoine.tenart@free-electrons.com> <53AB1CFD.4040500@cogentembedded.com> <20140630095940.GB10058@kwain> <53B176F1.5060308@gmail.com> <20140630154409.GB29613@kwain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35895 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbaF3Qzj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jun 2014 12:55:39 -0400
Received: by mail-lb0-f178.google.com with SMTP id 10so5994033lbg.23
        for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2014 09:55:38 -0700 (PDT)
In-Reply-To: <20140630154409.GB29613@kwain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Antoine_T=E9nart?= <antoine.tenart@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: tj@kernel.org, kishon@ti.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org

Hello.

On 06/30/2014 07:44 PM, Antoine T=E9nart wrote:

>>>>> +	/* set the controller speed */
>>>>> +	writel(0x31, ctrl_reg + PORT_SCR_CTL);

>>>>     Value undocumented? Or is this the SATA SControl register by c=
hance?

>>> Some magic is still there...

>> I guess Sergei was referring to AHCI spec here.

    Actually, even to the SATA specs. :-)

>> PORT_SCR bits are documented in AHCI spec as:

>> 7:4 =3D 0x3 Limit speed negotiation to a rate not greater than Gen3
>>            communication rate.

>> 3:0 =3D 0x1 Perform interface communication sequence [...]. This is
>>            functionally equivalent to a hard reset [...].

>> So, the question is: Should we really need to reset controller in th=
e
>> PHY driver or is it already done in AHCI common code? At least we
>> should change the comment to something like
>> /* set Gen3 controller speed and perform hard reset */

> I just checked, the AHCI common code has a function to do the reset:
> ahci_reset_controller(). As of the max speed negociation rate, I did =
not
> see it in the common AHCI functions.

    You've looked in a wrong place -- since SControl is a standard *SAT=
A*=20
register, it gets read/written by the libata core. The low-level driver=
 only=20
provides scr_{read|write}() methods.

> The eSATA port on the Berlin2Q works without this line, but it may be=
 a
> good idea to keep the max speed negociation rate.

    It's usually libata's task to negotiate the SATA speed.

> Anyway, we can remove the reset part. Nice catch!

    Thanks.

> Antoine

WBR, Sergei

