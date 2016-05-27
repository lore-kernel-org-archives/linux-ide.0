From: Mason <slash.tmp@free.fr>
Subject: Re: sata_dwc_460ex driver
Date: Fri, 27 May 2016 20:41:31 +0200
Message-ID: <574894DB.4090706@free.fr>
References: <57485F96.8010001@free.fr> <yw1xeg8n5v74.fsf@unicorn.mansr.com>
 <57487C33.4020306@free.fr>
 <CAPBZ5Qd5MFP+7fyRaGgnmLNu3--J=+ogs0nCD4pfoU27gPE+cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:47367 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbcE0Sl7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 May 2016 14:41:59 -0400
In-Reply-To: <CAPBZ5Qd5MFP+7fyRaGgnmLNu3--J=+ogs0nCD4pfoU27gPE+cg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: Mans Rullgard <mans@mansr.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christian Lamparter <chunkeey@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kishon Vijay Abraham <kishon@ti.com>, Sebastian Frias <sf84@laposte.net>

On 27/05/2016 20:15, Andy Gross wrote:

> On 27 May 2016 at 11:56, Mason wrote:
> 
>> How come there are so few phy drivers in drivers/phy if most
>> devices would typically require one?
> 
> Short answer is that the generic phy framework is fairly recent
> (~3 years old).  A lot of phys are stuck off in other places like
> drivers/usb/phy.  At least that's my take on it.

<confused> Where did the SATA phy drivers use to live?

$ find -name phy
./drivers/usb/phy
./drivers/phy
./drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy
./drivers/net/phy
./drivers/gpu/drm/msm/dsi/phy
./include/linux/phy
./include/dt-bindings/phy
./Documentation/devicetree/bindings/phy
./Documentation/phy

drivers/ata/ahci.h mentions SATA phy registers.
Is AHCI standardized to the point that platform-specific PHYs
are not required?

Regards.
