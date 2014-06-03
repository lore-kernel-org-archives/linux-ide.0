From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Add Device ID for HighPoint RocketRaid 642L
Date: Tue, 3 Jun 2014 14:41:40 -0400
Message-ID: <20140603184140.GJ26210@htj.dyndns.org>
References: <20140530021833.746efa6b@Vantage.cJ>
 <20140603180236.GI26210@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:65254 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932645AbaFCSlo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2014 14:41:44 -0400
Content-Disposition: inline
In-Reply-To: <20140603180236.GI26210@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?B?Suly9G1l?= Carretero <cJ-ko@zougloub.eu>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>

On Tue, Jun 03, 2014 at 02:02:36PM -0400, Tejun Heo wrote:
> On Fri, May 30, 2014 at 02:18:33AM -0400, J=E9r=F4me Carretero wrote:
> > This device normally comes with a proprietary driver, using a web G=
UI
> > to configure RAID:
> >  http://www.highpoint-tech.com/USA_new/series_rr600-download.htm
> > But thankfully it also works out of the box with the AHCI driver,
> > being just a Marvell 88SE9235.
> >=20
> > Devices 640L, 644L, 644LS should also be supported but not tested h=
ere.
> >=20
> > Signed-off-by: J=E9r=F4me Carretero <cJ-ko@zougloub.eu>
>=20
> Applied to libata/for-3.16 w/ stable cc'd.

Ugh... build failure from missing ')'.  Please at least try to compile
the changes before submitting patches.

--=20
tejun
