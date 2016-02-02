From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Tue, 02 Feb 2016 15:08:59 +0100
Message-ID: <4743985.XZ7D12RurV@wuerfel>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com> <5709817.yQT8N3CaLj@wuerfel> <56AFD91F.4030008@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:60947 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbcBBOJV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2016 09:09:21 -0500
In-Reply-To: <56AFD91F.4030008@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org, Graeme Gregory <graeme@xora.org.uk>

On Monday 01 February 2016 16:15:59 Brijesh Singh wrote:
> > 
> > This is where we really need the ACPI maintainers to explain the
> > general policy for dealing with firmware updates.
> > 
> > I would assume that adding the feature in a later firmware version
> > is a compatible change, and the feature is non-essential (the
> > device will work fine with the generic SATA driver, except
> > the LEDs don't blink), so it's not a big deal, it's just what
> > you get for having the firmware shipped before the driver is
> > reviewed (don't do that).
> > 
> 
> Agreed, the driver should have been reviewed earlier. And now changes in firmware will also require
> them changing other OSes drivers.

Can you explain that? I would expect the addition of some AML methods
to be a compatible change.

	Arnd
