From: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Subject: Re: Remove obsoleted "idex=noprobe" kernel parameter
Date: Wed, 12 Mar 2008 15:54:49 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0803121553390.13066@Soyuz-KT.TeNet.Odessa.UA>
References: <Pine.LNX.4.64.0803120418580.12249@Soyuz-KT.TeNet.Odessa.UA>
 <200803121435.30213.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Te.NeT.UA ([195.138.80.34]:35613 "EHLO te.net.ua"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbYCLNy4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Mar 2008 09:54:56 -0400
In-Reply-To: <200803121435.30213.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, 12 Mar 2008, Bartlomiej Zolnierkiewicz wrote:

Hi,

:>   Why this option is obsoleted ? It can be used on many systems when Linux 
:"hdx=noprobe" skips probing given IDE device, if given for all devices
:on the contoller, the controller will be not probed at all
:[ "hdx=noprobe" will be converted soon to "ide_core.noprobe=" parameter
:  as we _need_ to re-do parameters handling because the old interface
:  ("hdx=" / "idex=") is not compatible with the IDE warm-plug support ]

Oh, thats good, some chance is left ;)

:It still can be done - just they way of doing it will change:
: *      echo -n "0x168:0x36e:10" > /sys/class/ide_generic/add

Thanks for clarifying.

:
:

		Rus
