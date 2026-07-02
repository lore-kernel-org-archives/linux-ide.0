Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB730ACFF;
	Thu,  2 Jul 2026 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007043; cv=none; b=r278SdKuzD4eB9LhmRSvccQs+/BEX3Qg1z+3sk5FufLITQJyN2z9ISLlet3Z4FAgcXw+iKmjKWF/StyZ9qomgbXGRGrx7RYXs4SPdPHOominyAV6zgAPQOEuT94GJg9y1rPz2tdmeZrbjObs13KZwAXjh2c7q140ILnNFsXxuhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007043; c=relaxed/simple;
	bh=uP9SqeeWNjJhts9ZgvJunksMD+SZH2js2+fby8DjpqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjkDWL5GhOCDF+aICDFYI/PUD+MQmrx+iRCFfnH/1X6UhcqrYehEltjIsPfC48ftiB2PqNptHo70H1jepsyku75mxkMzGroXS+ubHt2Kl00Au6l393PGYGft1khzTAWM7Ipenh5S3W9XyTJA0cY5GRguI+WOQlCs+C8q29ZSWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHCtDA8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHCtDA8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB6C1F00A3A;
	Thu,  2 Jul 2026 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007042;
	bh=ue02QyK0g/hTZQ3wx6g2ZhCd8bfRmLHyW+2Q3lRIR5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UHCtDA8SJ3eOnflwg92NKvHK7LYtkncNLDrnjq8IJCUGbUmCEM9xeAhyRmvYPpglW
	 rVPJeE7DwZ7N2dMcF4HdRs7OflqloGCWIhRIB6fDzhwy/RhDAznzr25d/76CeD0Ehf
	 cIUKQlG9rIrdHNIhdIemr4Y6M0VXyRvOJh1wxAYql24ZtlYYwn4F0WnhpjoRYZetK8
	 Whx4NyQU9F/Y2LIZKw/gGrzvI9FKZFFabtrA+6019sT0GOC/dYeQeySukFmXtcrmHL
	 ETq6hBtXjR86Ruza8vWHjuGbMd8VbwnKw82mRygdQkG6wpTS8ZwcKTTcBCbd2REeGX
	 PFukE+vWW7YwQ==
Date: Thu, 2 Jul 2026 17:43:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: TJ Adams <tadamsjr@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Salomon Dushimirimana <salomondush@google.com>
Subject: Re: [PATCH] ata: libata-core: Allow capacity transition to zero for
 locked drives
Message-ID: <akaHPScetfl1VbF8@ryzen>
References: <20260622182844.2795777-1-tadamsjr@google.com>
 <ajvny2mkowNmu81Z@ryzen>
 <CAL54JgfakNzRSe8QosjAdBtQnDpiJqjOYFZvuOPjM1RphKEw4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL54JgfakNzRSe8QosjAdBtQnDpiJqjOYFZvuOPjM1RphKEw4A@mail.gmail.com>

Hello TJ,

On Wed, Jul 01, 2026 at 04:16:49PM -0700, TJ Adams wrote:
> On Wed, Jun 24, 2026 at 7:21 AM Niklas Cassel <cassel@kernel.org> wrote:
> >
> > On Mon, Jun 22, 2026 at 11:28:44AM -0700, TJ Adams wrote:
> > > Commit 91842ed844a0 ("ata: libata-core: Set capacity to zero for a
> > > security locked drive") introduced setting the device capacity (n_sectors)
> > > to zero in ata_dev_configure() if the drive is security locked.
> > >
> > > However, during runtime revalidation, ata_dev_revalidate() compares the
> > > new capacity (now 0) with the old capacity (>0) and detects a mismatch.
> > > Since it does not consider the locked status, it returns -ENODEV.
> 
> 
> Hey Niklas,
> 
> Sorry for the delay in response. I had some difficulty recreating the
> issue outside of our specific test suite.
> 
> > Please explain how you reproduce this.
> > As far as I can see the local n_sectors variable will be 0,
> > and the function call to ata_dev_configure() will set dev->n_sectors
> > to 0, so this should, AFAICT, never get a "n_sectors mismatch" print.
> 
> Here are the steps to recreate it:
> 
> ```bash
> TARGET_DEV="/dev/sdy"
> TARGET_NAME="sdy"
> 
> # Lock Device
> hdparm --user-master u --security-set-pass TempPassword "$TARGET_DEV"
> 
> # Disable SSP
> sg_raw "$TARGET_DEV" 85 06 00 00 90 00 06 00 00 00 00 00 00 00 ef 00
> 
> # In another terminal set active I/O
> dd if="$TARGET_DEV" of=/dev/null bs=1M status=progress
> 
> # Do an active reset (then wait for scsi eh)
> echo 1 > /sys/class/sas_phy/phy-X:Y/hard_reset
> 
> # You can end the dd command in the other terminal and then run this:
> # You should see it fail immediately
> dd if="$TARGET_DEV" of=/dev/null bs=512 count=1
> ```
> 
> Some things to note:
> - Disabling SSP. I had some attempts to recreate the bug but didn't
>   realize SSP was enabled. I would lock the drive but on reset the
>   drive would actually come back up unlocked, masking the bug.
> - The active I/O. This is so there are I/Os in flight whenever the
>   drive gets reset. They should timeout and then trigger the error
>   handling path which will cause the ata device revalidation. Without
>   it the revalidation might not occur and you might not see the bug.
>   I also experienced this.
> 
> > Since you seem to state that the old capacity (local variable n_sectors)
> > is > 0, it seems like the device wasn't locked during the initial boot /
> > ata_dev_configure() call.
> 
> Yeah that's correct. To recreate the issue you should boot unlocked but
> lock at runtime.
> 
> Also here is a dmesg snippet showing the capacity mismatch:
> 
> ```dmesg
>   [76834.784699] ata36.00: status: { DRDY }
>   [76834.784708] ata36: hard resetting link
>   [76834.940530] ata36.00: supports DRM functions and may not be fully
> accessible
>   [76834.940537] ata36.00: Security locked, setting capacity to zero
>   [76834.943566] ata36.00: n_sectors mismatch 15628053168 != 0
> ```
> 
> Let me know if I didn't explain something well or if something is
> missing. Thank you!

Ok, thank you for the information.


Perhaps mention more clearly in the commit message that this happens
when doing a reset of the PHY for a controller that has I/Os in flight.


I think a simpler patch would be:

@@ -3959,7 +3959,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 
        /* verify n_sectors hasn't changed */
        if (dev->class != ATA_DEV_ATA || !n_sectors ||
-           dev->n_sectors == n_sectors)
+           dev->n_sectors == n_sectors || ata_id_is_locked(dev->id))
                return 0;
 
        /* n_sectors has changed */


I don't see why we need the additional dev->n_sectors == 0.
If the drive is locked, no need to contiunue, just return.

Perhaps you could test that change instead?


Also, I think we should have a patch 1/2 (or 2/2) that does:


@@ -1338,7 +1338,7 @@ static int ata_hpa_resize(struct ata_device *dev)
        /* do we need to do it? */
        if ((dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ZAC) ||
            !ata_id_has_lba(dev->id) || !ata_id_hpa_enabled(dev->id) ||
-           (dev->quirks & ATA_QUIRK_BROKEN_HPA))
+           (dev->quirks & ATA_QUIRK_BROKEN_HPA) || ata_id_is_locked(dev->id))
                return 0;
 
        /* read native max address */


To fix the problem Sashiko complained about.


Kind regards,
Niklas
