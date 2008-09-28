From: "Jeffrey W. Baker" <jwbaker@gmail.com>
Subject: Re: [patch 1/2] allow user to power off unused ports via sysfs
Date: Sun, 28 Sep 2008 14:58:34 -0700
Message-ID: <1222639114.12062.10.camel@hannibal>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:51394 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbYI1V7D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 17:59:03 -0400
Received: by wa-out-1112.google.com with SMTP id v27so853377wah.21
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 14:59:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kristen.c.accardi@intel.com

I tried this patch and it doesn't work on ICH8 because it violates AHCI
protocol.

kristen.c.accardi@intel.com wrote:
> --- linux-ahci-phy.orig/drivers/ata/libata-core.c	2008-06-27 13:32:51.000000000 -0700
> +++ linux-ahci-phy/drivers/ata/libata-core.c	2008-07-01 16:33:00.000000000 -0700
> @@ -162,6 +162,19 @@ MODULE_DESCRIPTION("Library module for A
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(DRV_VERSION);
>  
> +static void ata_phy_offline(struct ata_link *link)
> +{
> +	u32 scontrol;
> +	int rc;
> +
> +	/* set DET to 4 */
> +	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
> +	if (rc)
> +		return;
> +	scontrol &= ~0xf;
> +	scontrol |= (1 << 2);
> +	sata_scr_write(link, SCR_CONTROL, scontrol);
> +}

On AHCI, you can't change SCTL.DET when the port is running.  This
version of ata_phy_offline changes SCTL.DET without regard to CMD.ST.

I would propose something more like this:

static void ata_port_offline(struct ata_port *ap)
{
        u32 scontrol;
        int rc;
        struct ata_link *link = &ap->link;

        if (ap->ops->port_stop)
                ap->ops->port_stop(ap);

        rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
        if (rc)
                return;

        scontrol &= ~0xf;
        scontrol |= (1<<2);

        sata_scr_write(link, SCR_CONTROL, scontrol);
}

I tried the above on ICH8 and by poking around in /dev/mem I believe it
works.  After I set the ALPM to power_off in sysfs, the port shows
CMD.ST == 0, CMD.FRE == 0, and SSTS.DET == 4.  So I think this is the
way to go, at least with respect to AHCI.  I can't say whether this
makes sense generally for the other users of libata-core.

The problem is I didn't save any power this way :(  ThinkPad X61t was
using minimum 7.6W on a one-minute average before power_off, and same
power after power_off.  I'd been led to believe that disabling these
ports would have a substantial power saving effect.

-jwb

