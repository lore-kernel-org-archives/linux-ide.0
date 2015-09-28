From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] ata: ahci: find eSATA ports and flag them as
 removable
Date: Mon, 28 Sep 2015 12:28:34 -0400
Message-ID: <20150928162834.GE2589@mtj.duckdns.org>
References: <1443179101-9870-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34097 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922AbbI1Q2i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Sep 2015 12:28:38 -0400
Received: by ykdg206 with SMTP id g206so183900334ykd.1
        for <linux-ide@vger.kernel.org>; Mon, 28 Sep 2015 09:28:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443179101-9870-1-git-send-email-manuel.lauss@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Linux-IDE <linux-ide@vger.kernel.org>

Hello, Manuel.

On Fri, Sep 25, 2015 at 01:05:01PM +0200, Manuel Lauss wrote:
> If the AHCI ports' HPCP or ESP bits are set, the port
> should be considered external (e.g. eSATA) and is marked
> as removable.  Userspace tools like udisks then treat it
> like an usb drive.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> --
> This is a crude hack, but works fine on my laptop. If I plug something in
> on the eSATA port, KDE pops up a windows asking me what to do with the
> new drive(s), just like it does for any random usb stick.
> 
> I didn't know how else to communicate to userspace that the drive is
> removable other than adding it to the removable-bit-test of ATA IDENTIFY data.

It'd probably be better if you include the above two paragraphs in the
patch description proper.

Heh, does a port being marked external indicate that it should be
treated as a removable device?  Hmmm... maybe.  I'm not sure either
way.  The other thing is that marking a device removeable cause
internal behavior changes in the SCSI layer.  It constantly checks to
detect media change events which should be fine but noteworthy.

> @@ -1484,6 +1485,11 @@ static void ahci_postreset(struct ata_link *link, unsigned int *class)
>  		writel(new_tmp, port_mmio + PORT_CMD);
>  		readl(port_mmio + PORT_CMD); /* flush */
>  	}
> +
> +	/* mark esata ports */
> +	if ((tmp & PORT_CMD_HPCP) ||
> +	    ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)))
> +		ap->pflags |= ATA_PFLAG_EXTERNAL;

We probably should do this during port initialization rather than in
the reset path.

Thanks.

-- 
tejun
