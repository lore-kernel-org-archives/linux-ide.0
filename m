From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v13 0/8] ARM: berlin: add AHCI support
Date: Wed, 30 Jul 2014 19:29:11 +0200
Message-ID: <20140730172911.GB15772@kwain>
References: <1406739902-26311-1-git-send-email-antoine.tenart@free-electrons.com>
 <20140730170923.GE23734@htj.dyndns.org>
 <20140730171829.GF23734@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57542 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754350AbaG3R3Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2014 13:29:25 -0400
Content-Disposition: inline
In-Reply-To: <20140730171829.GF23734@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 30, 2014 at 01:18:29PM -0400, Tejun Heo wrote:
> On Wed, Jul 30, 2014 at 01:09:23PM -0400, Tejun Heo wrote:
> > Hello,
> >=20
> > Applied 3-5 to libata/for-3.17.  I suppose 6-8 are gonna routed
> > through a different tree?
>=20
> Reverted due to build failulre.  Can you please look into it?

Sorry for that... I just fixed it. I'll test and send a new version.

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
