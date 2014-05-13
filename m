From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v2 3/6] ata: ahci: add AHCI support for the Berlin BG2Q
Date: Tue, 13 May 2014 14:07:51 +0200
Message-ID: <20140513120751.GA3213@kwain>
References: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
 <1399886217-20474-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140512141221.GE3378@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:38478 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759800AbaEMMHz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 May 2014 08:07:55 -0400
Content-Disposition: inline
In-Reply-To: <20140512141221.GE3378@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org

Hi Andrew,

On Mon, May 12, 2014 at 04:12:21PM +0200, Andrew Lunn wrote:
> On Mon, May 12, 2014 at 11:16:54AM +0200, Antoine T=C3=A9nart wrote:

[=E2=80=A6]

> I've no idea is this is a good or bad idea, but could you put all the
> above code in the phy driver? It does seem to be mostly phy
> related. Then teach the core ahci code about optional phy nodes in DT=
=2E
> You can then probably do without a ahci berlin driver.

The code is PHY related, but the setup done is SATA specific. I think i=
t
makes sense to keep it here. From what I saw lots of PHY drivers only
power up / down the PHYs.

Lots of port setups are done in the SATA framework, so it would separat=
e
related code into two subsystems.

Antoine

--=20
Antoine T=C3=A9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
