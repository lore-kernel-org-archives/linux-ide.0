From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v7 1/7] phy: add a driver for the Berlin SATA PHY
Date: Mon, 30 Jun 2014 16:40:49 +0200
Message-ID: <53B176F1.5060308@gmail.com>
References: <1403530783-17180-1-git-send-email-antoine.tenart@free-electrons.com> <1403530783-17180-2-git-send-email-antoine.tenart@free-electrons.com> <53AB1CFD.4040500@cogentembedded.com> <20140630095940.GB10058@kwain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63937 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbaF3Okz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jun 2014 10:40:55 -0400
In-Reply-To: <20140630095940.GB10058@kwain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Antoine_T=E9nart?= <antoine.tenart@free-electrons.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: tj@kernel.org, kishon@ti.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org

On 06/30/2014 11:59 AM, Antoine T=E9nart wrote:
> On Wed, Jun 25, 2014 at 11:03:25PM +0400, Sergei Shtylyov wrote:
>> On 06/23/2014 05:39 PM, Antoine T=E9nart wrote:
>>> +	/* set the controller speed */
>>> +	writel(0x31, ctrl_reg + PORT_SCR_CTL);
>>
>>     Value undocumented? Or is this the SATA SControl register by cha=
nce?
>
> Some magic is still there...

Antoine,

I guess Sergei was referring to AHCI spec here. PORT_SCR bits are
documented in AHCI spec as:

7:4 =3D 0x3 Limit speed negotiation to a rate not greater than Gen3
           communication rate.

3:0 =3D 0x1 Perform interface communication sequence [...]. This is
           functionally equivalent to a hard reset [...].

So, the question is: Should we really need to reset controller in the
PHY driver or is it already done in AHCI common code? At least we
should change the comment to something like
/* set Gen3 controller speed and perform hard reset */

Sebastian
