From: "Kim, Milo" <Milo.Kim@ti.com>
Subject: RE: [PATCH] Allow Marvell SATA driver to work with
 LEDS_TRIGGER_IDE_DISK
Date: Wed, 9 Jan 2013 01:29:44 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F69E12010@DQHE02.ent.ti.com>
References: <1357668987-3610-1-git-send-email-josh.coombs@gmail.com>
 <20130108190657.GW5075@titan.lakedaemon.net>
 <CAMW5UfY2vKEJ7K8tLJ1+JeKsr_hxtUTva9HGJxLan6k+KGdmvg@mail.gmail.com>
 <20130108200350.GX5075@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52574 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756389Ab3AIBaH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2013 20:30:07 -0500
In-Reply-To: <20130108200350.GX5075@titan.lakedaemon.net>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Josh Coombs <josh.coombs@gmail.com>
Cc: "cooloney@gmail.com" <cooloney@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, linux ARM <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>

> -----Original Message-----
> From: linux-leds-owner@vger.kernel.org [mailto:linux-leds-
> owner@vger.kernel.org] On Behalf Of Jason Cooper
> Sent: Wednesday, January 09, 2013 5:04 AM
> To: Josh Coombs
> Cc: cooloney@gmail.com; linux-kernel@vger.kernel.org; linux-
> ide@vger.kernel.org; rpurdie@rpsys.net; linux ARM; jgarzik@pobox.com;
> linux-leds@vger.kernel.org
> Subject: Re: [PATCH] Allow Marvell SATA driver to work with
> LEDS_TRIGGER_IDE_DISK
> 
> On Tue, Jan 08, 2013 at 02:18:04PM -0500, Josh Coombs wrote:
> > Would it make more sense to add a second trigger
> > for SATA instead?
> 
> I'll leave that up to the led guys, I just wanted to raise the point
> that the driver could logically support other types of disks, and we
> should come up with a migration path instead of adding capabilities
> ad-hoc.

I agree with Jason's suggestion. One more thing to consider.

If we replace the name, 'ide-disk' or 'ide_disk' with general one,
then we should change the value of 'default_trigger' under arch directory also.
LED trigger works if the name is matched with trigger name of LED device.

Thanks,
Milo
