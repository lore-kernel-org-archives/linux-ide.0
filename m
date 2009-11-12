From: Tejun Heo <tj@kernel.org>
Subject: Re: Nvidia ION (MCP79) eSata fails for external cabinet Thecus N2050
 (SIL5744)
Date: Fri, 13 Nov 2009 05:04:23 +0900
Message-ID: <4AFC6A47.4040502@kernel.org>
References: <A5D2B277-9D37-49FC-A5C2-30E8707C26B2@laxfiske.se> <4AF7CE6F.9050306@kernel.org> <8A904902-4AB1-4CD9-9C2E-1B06461E3010@laxfiske.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42030 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096AbZKLUDB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Nov 2009 15:03:01 -0500
In-Reply-To: <8A904902-4AB1-4CD9-9C2E-1B06461E3010@laxfiske.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?=D6rjan_Nordlund?= <orjan@laxfiske.se>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

11/12/2009 09:51 PM, =D6rjan Nordlund wrote:
> Will do. Have to wait until i am in the office again. I only have
> eSata on my ubuntu box @ home.  As previously stated this device has
> had some quirks before when i tried to use USB. The comments below
> are from Alan Stern who developed a patch for scsi_scan.c to make
> the device work when using the USB port on the Thecus N2050.

The two interfaces the device implement are pretty much independent.
USB presents itself as a SCSI device while the eSATA device will show
up as a SATA device.  For some reason, recent 5744s seem to have
various firmware issues, so it wouldn't be too surprising if it has
similar bugs on ATA side too.  Anyways, please let us know what you
find.

Thanks.

--=20
tejun
