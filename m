From: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Subject: Re: AMD SP5100 SATA low perfomance
Date: Fri, 27 Jul 2012 11:57:18 +0100
Message-ID: <5012740E.7040507@mrc-lmb.cam.ac.uk>
References: <20120724204454.GC5167@liondog.tnic> <CAKu2wpTFZNY4nwi47gRPbzaHUFPRfJEZa+GTgO4L=vJ-y+9gCA@mail.gmail.com> <20120726100440.GB30717@aftab.osrc.amd.com> <CAKu2wpSw-jTMnRkZyDf9aGuNqY7kRp6AUUHKr7CVoo_QXRzj=Q@mail.gmail.com> <CAKu2wpQY3=VK-7RZjheRjaYPN2OQxoD=r1qU08DwmjM9xhkxcQ@mail.gmail.com> <20120726180854.GD9161@aftab.osrc.amd.com> <CAKu2wpThVHc9nAL=xvcPSKcv-cnOFp+Y41CpQyxsqo292FzjRA@mail.gmail.com> <CAKu2wpRkHnAdwiwuoyXfS+KrWQ7DBed1yh_K5eSu0o2d0GWJuA@mail.gmail.com> <20120727090719.GA13992@aftab.osrc.amd.com> <CAKu2wpQe+SR3BSsrf+oNzfok6OdQtBKMeYfTGdNOcc-s-AWjjQ@mail.gmail.com> <20120727102521.GA14445@aftab.osrc.amd.com> <CAKu2wpRzPfakZB20OPs37+YoR8MXsvZjvSZo+6V_WWKVX0iYKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:42143 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab2G0K5Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2012 06:57:25 -0400
In-Reply-To: <CAKu2wpRzPfakZB20OPs37+YoR8MXsvZjvSZo+6V_WWKVX0iYKQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <brushkoff@gmail.com>
Cc: Borislav Petkov <bp@amd64.org>, linux-ide@vger.kernel.org

Rus V. Brushkoff wrote:
>> So the Hitachi ones are lighter than the WD ones and behave like mobile
>> hdds in that respect.
> 
> Yes, these Hitachi is lighter and more sensitive to vibrations - even
> hanging on wires is sufficient for twice perfomance drop - the whole
> vibro silence is requred for it to reach the max speed. I think this
> is mostly the hardware design flaw of this particular model - will
> return all of them.

Well, you said that the 2.5" WD drives showed the same symptoms, so I
don't see how you conclude the problem is Hitachi-specific. It seems
more likely to be an interaction between some (or all) 2.5" drives and
the particular case/fan combination.

How are the 2.5" drives mounted in the cases?

Perhaps it would be fixable by using low-vibration fans or fan mounting
kits. Perhaps mounting the drives on a lump of solid metal to bring them
up to the same mass as a 3.5" drive would fix it. Perhaps resilient
mounting of the drives would fix it. Perhaps a stiffer/heavier case
would fix it.

Now that you know the problem is hardware-related, the same symptoms
should show up using Windows (or any other OS). So maybe Hitachi (and WD
and the case and fan manufacturers) might now be interested in finding a
better cure, or at least warning potential customers.
