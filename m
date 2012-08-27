From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH v2] ahci: implement aggressive SATA device sleep support
Date: Mon, 27 Aug 2012 10:36:05 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E107E1BAEB@SCYBEXDAG03.amd.com>
References: <1345761072-2123-1-git-send-email-shane.huang@amd.com>
 <503647B3.6050706@pobox.com>
 <43EB3AB3EEFE8D43B525F4D2EAF507E107E1A41A@SCYBEXDAG03.amd.com>
 <50379F65.3070009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:35322 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751632Ab2H0KgY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Aug 2012 06:36:24 -0400
In-Reply-To: <50379F65.3070009@pobox.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>, "Huang, Shane" <Shane.Huang@amd.com>

> To avoid attempting to enable on older devices, you will need an 
> appropriate test (ata_id_has_ncq perhaps?)

So far I don't find better method to exclude old devices than yours.


> As you figured out in the other email, I was referring to sata_settings

I'm going to modify both sata_settings and ID[78].


> I just do not like programming the device, when power policy may 
> indicate otherwise.
> 
> Most conservative is to leave devslp feature in reset state and not 
> touch device or host until power policy dictates it is time to program 
> host + device.

OK, I'll move setting feature back to ahci_set_aggressive_devslp().
I'm trying to avoid setting feature each time for every sleep to
improve performance.

Adding pp->device_devslp_enabled with the code below does not make
much difference because it is still called for every sleep.
Do you have good suggestion?

Any should we also call setting feature to disable device DevSlp
for each !sleep?


static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
{
...
        /* disable device sleep */
        if (!sleep) {
                if (devslp & PORT_DEVSLP_ADSE)
                        writel(devslp & ~PORT_DEVSLP_ADSE,
                               port_mmio + PORT_DEVSLP);
                if (pp->device_devslp_enabled)
                        pp->device_devslp_enabled = false;
                return;
        }
...
        ahci_start_engine(ap);

        /* enable device sleep feature for the drive */
        if (!pp->device_devslp_enabled) {
                err_mask = ata_dev_set_feature(ap->link.device,
                                               SETFEATURES_SATA_ENABLE,
                                               SATA_DEVSLP);
                if (err_mask && err_mask != AC_ERR_DEV)
                        ata_dev_warn(ap->link.device,
                                     "failed to enable DEVSLP, Emask 0x%x\n", err_mask);
                else
                        pp->device_devslp_enabled = true;
        }
}


Thanks,
Shane

