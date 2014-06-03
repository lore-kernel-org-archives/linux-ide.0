From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Add Device ID for HighPoint RocketRaid 642L
Date: Tue, 3 Jun 2014 14:56:09 -0400
Message-ID: <20140603185609.GL26210@htj.dyndns.org>
References: <20140603145625.036687b6@Vantage>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:38318 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbaFCS4M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2014 14:56:12 -0400
Content-Disposition: inline
In-Reply-To: <20140603145625.036687b6@Vantage>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?B?Suly9G1l?= Carretero <cJ-ko@zougloub.eu>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>

On Tue, Jun 03, 2014 at 02:56:25PM -0400, J=E9r=F4me Carretero wrote:
> This device normally comes with a proprietary driver, using a web GUI
> to configure RAID:
>  http://www.highpoint-tech.com/USA_new/series_rr600-download.htm
> But thankfully it also works out of the box with the AHCI driver,
> being just a Marvell 88SE9235.
>=20
> Devices 640L, 644L, 644LS should also be supported but not tested her=
e.
>=20
> Signed-off-by: J=E9r=F4me Carretero <cJ-ko@zougloub.eu>

Applied to libata/for-3.16 w/ stable cc'd.

Thanks.

--=20
tejun
