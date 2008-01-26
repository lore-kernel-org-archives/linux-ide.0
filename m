From: Tejun Heo <htejun@gmail.com>
Subject: Re: Firmware on SATA PMP Sil3726 - Sil3124
Date: Sat, 26 Jan 2008 10:43:41 +0900
Message-ID: <479A904D.6070305@gmail.com>
References: <1335f497460b0140ad1ddb9ff2a858d0@jogback.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:65290 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354AbYAZBns (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 20:43:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1404624wah.23
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2008 17:43:47 -0800 (PST)
In-Reply-To: <1335f497460b0140ad1ddb9ff2a858d0@jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Lars_Michael_Jogb=E4ck?= <lm@swip.net>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Lars Michael Jogb=E4ck wrote:
> Hello,
>=20
> I've got a couple of older PMP's with Sil3726.
>=20
> I wonder if it's possible from Linux to check which firmware version
> it is on the Sil3726 and on the Sil3124?
>=20
> Is it possible to upgrade the firmware/bios on Sil3726 and Sil3124
> from Linux?

That is done via the scary config device which linux detects alright bu=
t
needs more quirking to get the SIMG admin software to work.  So,
currently, not.

--=20
tejun
