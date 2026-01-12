Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6A2236E8
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228800; cv=none; b=ftZkU/P+a2JQWEjrQtYeZwhsSpKIAz/vC9EA/xlPKCok5UpUdMYhVx8U8dr9wt2Y6+X6M6PaPV7ERhQ0JMZSijW5cPm9WBI3B+pYkQV9woRomdNAsBsyu0GVNFCty5fM7YS2kyhEuJOIYd8ULb6Ih69cT3G8UDd0EabewuJ6nXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228800; c=relaxed/simple;
	bh=1mg4sGRLNweK7oJtKDS45puNCFmala0x0OfzWDoLgqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPayWw4Cmv7PfX/hrAY9Usw7rkv9XFyEcF+r6ReWbPqm4YI8QZlD6Ho+UoJnaupZae4vmcSabg5vzBqPZMvJaf5OE8GWwZK7B4D3xGIyJNL31cpJ9CtsfYmlasPyR1Yhb4k8fhINTNA4It0UAusfVmvdE9Dmxrt6rXI+rJe4y+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvnOgB0L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvnOgB0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92409C16AAE;
	Mon, 12 Jan 2026 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768228800;
	bh=1mg4sGRLNweK7oJtKDS45puNCFmala0x0OfzWDoLgqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WvnOgB0LZ5xHkX+g9DgUBhpEmd0AXLmAn33dMmiz0QqkrhlAdQY5XrsiRpTzJsc7h
	 WKZgL/FSFSfs7bWUDyQIgiise3Bx0uverw9b11D4uIFFEYIVC4Mo+z5gVGnSJUV6Qe
	 t1ZfkmeeAgOz1bRFIPsuTkt5YvtxCKLUWkFIinnjAv3a8xx893vqtWHWDdIzFNhIhV
	 iP1qcsjkG62818iVavOgqzdDKTsvR+UXfbUWpWxXl9F6+ZzzCieKIWCbrD8xUhovGD
	 ZZFvmC7CRnYE5daEH140NjB8U9b17OqXrxlI+scbu3/1Gf8AOkcGUaDvslNl2rD8+2
	 3hsWAGwAUPbPA==
Date: Mon, 12 Jan 2026 15:39:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, wolf@yoxt.cc
Subject: Re: [PATCH v2 3/6] ata: libata-sata: Improve
 link_power_management_supported sysfs attribute
Message-ID: <aWUHvdhs8oIFVgvp@ryzen>
References: <20260112122044.143637-8-cassel@kernel.org>
 <20260112122044.143637-11-cassel@kernel.org>
 <5b945fcf-059d-409c-9475-630483c14a5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b945fcf-059d-409c-9475-630483c14a5e@kernel.org>

On Mon, Jan 12, 2026 at 02:17:14PM +0100, Damien Le Moal wrote:
> On 1/12/26 13:20, Niklas Cassel wrote:
> > The link_power_management_supported sysfs attribute is currently set as
> > true even for ata ports that lack a .set_lpm() callback, e.g. dummy ports.
> >
> > This is a bit silly, because while writing to the
> > link_power_management_policy sysfs attribute will make ata_scsi_lpm_store()
> > update ap->target_lpm_policy (thus sysfs will reflect the new value) and
> > call ata_port_schedule_eh() for the port, it is essentially a no-op.
> >
> > This is because for a port without a .set_lpm() callback, once EH gets to
> > run, the ata_eh_link_set_lpm() will simply return, since the port does not
> > provide a .set_lpm() callback.
> >
> > Thus, make sure that the link_power_management_supported sysfs attribute
> > is set to false for ports that lack a .set_lpm() callback. This way the
> > link_power_management_policy sysfs attribute will no longer be writable,
> > so we will no longer be misleading users to think that their sysfs write
> > actually does something.
> >
> > Fixes: 0060beec0bfa ("ata: libata-sata: Add link_power_management_supported sysfs attribute")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/ata/libata-sata.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> > index b2817a2995d6..04e1e774645e 100644
> > --- a/drivers/ata/libata-sata.c
> > +++ b/drivers/ata/libata-sata.c
> > @@ -909,7 +909,7 @@ static bool ata_scsi_lpm_supported(struct ata_port *ap)
> >	struct ata_link *link;
> >	struct ata_device *dev;
> >
> > -	if (ap->flags & ATA_FLAG_NO_LPM)
> > +	if ((ap->flags & ATA_FLAG_NO_LPM) || !ap->ops->set_lpm)
>
> Can't we set ATA_FLAG_NO_LPM for ports that do not have set_lpm implemented
> earlier when scanning ? That would be safer.

No, because ATA_FLAG_NO_LPM means force LPM policy max power:
https://github.com/torvalds/linux/blob/v6.19-rc5/drivers/ata/libata-core.c#L2851-L2855

So when port flag ATA_FLAG_NO_LPM is set, ata_eh_link_set_lpm()
will be called with policy ATA_LPM_MAX_POWER.

So in my opinion, setting ap->flags |= ATA_FLAG_NO_LPM
when there is no .set_lpm() would just add to the existing mess,
since ATA_FLAG_NO_LPM mean calls .set_lpm() with ATA_LPM_MAX_POWER.



ata_eh_link_set_lpm() on the other hand, looks like this:

	if (!IS_ENABLED(CONFIG_SATA_HOST) ||
	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
		return 0;

So this patch simply took inspiration from that function.


ATA_LFLAG_NO_LPM seems to mean something like: we called .set_lpm() on
the port, but the device disappeared from the port when doing so,
so make futher calls to set_lpm() for this link a no-op...
(No idea why it doesn't instead call set_lpm() with ATA_LPM_MAX_POWER?)

Yes, it is a bit unfortunate that the link flag and the port flag have
very similar names, but mean completely different things.


I'm not sure if we should set sysfs attribute
link_power_management_supported == false if ATA_LFLAG_NO_LPM is set
(Currently we don't). Because if so, the sysfs supported attribute could
potentially change value during runtime, isn't it supposed to be static?

If we really want to, I guess we could do something like:

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 04e1e774645e..1134943f49ae 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -913,6 +913,8 @@ static bool ata_scsi_lpm_supported(struct ata_port *ap)
 		return false;
 
 	ata_for_each_link(link, ap, EDGE) {
+		if (link->flags & ATA_LFLAG_NO_LPM)
+			return false;
 		ata_for_each_dev(dev, &ap->link, ENABLED) {
 			if (dev->quirks & ATA_QUIRK_NOLPM)
 				return false;


But if so, that should probably be a different patch.

This patch was mainly to stop lying to the user that dummy ports could
change/set lpm_policy.


For the record, not all libata drivers provide a .set_lpm() callback.

Right now, the only drivers providing it are:
ata_piix.c:     .set_lpm                = piix_sidpr_set_lpm,
libahci.c:      .set_lpm                = ahci_set_lpm,


Kind regards,
Niklas
