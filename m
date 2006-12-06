From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: low performance trying pata_sis
Date: Wed, 6 Dec 2006 13:19:55 +0000
Message-ID: <20061206131955.37a4e2fc@localhost.localdomain>
References: <4576A24F.90200@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45928 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760587AbWLFNMY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2006 08:12:24 -0500
In-Reply-To: <4576A24F.90200@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: "linux.ide" <linux-ide@vger.kernel.org>

On Wed, 06 Dec 2006 11:58:23 +0100
Uwe Koziolek <uwe.koziolek@gmx.net> wrote:

> There is a wrong order to initialize the drivers. The IDE-platform
> driver was initialized before pata_sis.
> So the generic platform driver is driving the IDE controller instead of
> pata_sis.

I would suggest not trying to use both together - there isn't an easy way
to sort that out because the generic driver in libata will grab devices
before legacy drivers/ide if it is the other way around.

At least the current way around you get the old drivers by default.
