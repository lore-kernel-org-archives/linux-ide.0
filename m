From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: sata_dwc_460ex driver
Date: Fri, 27 May 2016 19:46:10 +0100
Message-ID: <yw1x7fef5ogd.fsf@unicorn.mansr.com>
References: <57485F96.8010001@free.fr> <yw1xeg8n5v74.fsf@unicorn.mansr.com>
	<57487C33.4020306@free.fr>
	<CAPBZ5Qd5MFP+7fyRaGgnmLNu3--J=+ogs0nCD4pfoU27gPE+cg@mail.gmail.com>
	<574894DB.4090706@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:45188 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbcE0SqV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2016 14:46:21 -0400
In-Reply-To: <574894DB.4090706@free.fr> (Mason's message of "Fri, 27 May 2016
	20:41:31 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Andy Gross <andy.gross@linaro.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christian Lamparter <chunkeey@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kishon Vijay Abraham <kishon@ti.com>, Sebastian Frias <sf84@laposte.net>

Mason <slash.tmp@free.fr> writes:

> On 27/05/2016 20:15, Andy Gross wrote:
>
>> On 27 May 2016 at 11:56, Mason wrote:
>>=20
>>> How come there are so few phy drivers in drivers/phy if most
>>> devices would typically require one?
>>=20
>> Short answer is that the generic phy framework is fairly recent
>> (~3 years old).  A lot of phys are stuck off in other places like
>> drivers/usb/phy.  At least that's my take on it.
>
> <confused> Where did the SATA phy drivers use to live?
>
> $ find -name phy
> ./drivers/usb/phy
> ./drivers/phy
> ./drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy
> ./drivers/net/phy
> ./drivers/gpu/drm/msm/dsi/phy
> ./include/linux/phy
> ./include/dt-bindings/phy
> ./Documentation/devicetree/bindings/phy
> ./Documentation/phy
>
> drivers/ata/ahci.h mentions SATA phy registers.
> Is AHCI standardized to the point that platform-specific PHYs
> are not required?

A lot of hardware, especially older, doesn't need PHY drivers since the
PHY either has no settings or is configured by platform firmware.  In
some other cases, the PHY is tightly coupled to the SATA/USB/whatever
controller and handled directly by its driver.

--=20
M=E5ns Rullg=E5rd
