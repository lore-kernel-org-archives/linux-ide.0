From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 0/3] ata: ahci_platform related cleanups
Date: Fri, 21 Mar 2014 10:25:34 +0100
Message-ID: <3053465.Mc0SLxBG1L@amdc1032>
References: <1395340026-3969-1-git-send-email-b.zolnierkie@samsung.com>
 <532B3F3F.1050508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <532B3F3F.1050508@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, spear-devel@list.st.com
List-Id: linux-ide@vger.kernel.org


Hi,

On Thursday, March 20, 2014 08:19:27 PM Hans de Goede wrote:
> Hi,
> 
> On 03/20/2014 07:27 PM, Bartlomiej Zolnierkiewicz wrote:
> > [ v1 was named "ata: add remaining new-style AHCI platform drivers"
> >   but we are down from 2 drivers to 1 driver so the title of the patch
> >   series no longer was valid :) ]
> > 
> > Hi,
> > 
> > This patch series:
> > - fixes ahci_platform_data->suspend() handling
> > - moves library AHCI platform code to its own file
> > - adds a new-style AHCI platform driver for DaVinci DA850 AHCI controller
> > 
> > Changes since v1:
> > - dropped no longer needed patch #4 (ST SPEAr1340 AHCI controller driver)
> > - adressed review comments for patch #3 from Sekhar Nori
> > - updated patch descriptions
> 
> I assume that the spear patch has been dropped since the spear code has
> already been converted now and thus is no longer using ahci_platform_data ?

Yes, the SPEAr platform AHCI code has been replaced by a proper PHY driver.

> In that case I think it would best to replace patch 1 with a patch just dropping
> the suspend and resume callbacks from ahci_platform_data, as they then no
> longer have any users.

I have this on my TODO but since the SPEAr changes are not yet merged upstream
this have to wait a bit.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
