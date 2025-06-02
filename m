Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCE4A1A
	for <linux-ide@vger.kernel.org>; Mon,  2 Jun 2025 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748863109; cv=none; b=q57TwTdlqzpq3crDFVqkzZYBVJdX5dBZYzzJBDOC98vxtF9fIN5Vd51niKpqygueHvNr/TRoH9eGdAh7kNf017tO9WIA/lxpvDx8L9qZI0K4ZlxeblWNqCBRjT0nQnpGuGyS+Rcu1r8mT4xc1ADVRo850quiAdnN/z0iCpY7A4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748863109; c=relaxed/simple;
	bh=GViYXusQ5gEgLkWhAOmLhDyUEEHrrdSdowrcD1iZH+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmGWZuHSzdBqpQIVgNKyUHml/RJQ/O0M6CD2s+HIoWBTKhKSDmBc/3jZv4q8jZ+pG+YLjTtMWz7U9NV3naeczxe0OtkckxzQlJxL/+WZwXVNZyv+BQzLdF31MfhYFacDC2mIvPpUFH9pssQczSpp7x1NBTZ7rfeU8YhZx/SH99A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVyxF2M3; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVyxF2M3"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7db6aaef22so3194700276.0
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2025 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748863106; x=1749467906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=73R+IsieEm9ZNPYuD1doOv65SNEtsmHDr09k2pQBiO0=;
        b=OVyxF2M31mNsw+A+rGWBV/t4Byg9Aee5yuOwaI5l/zAE6bx+Q1Ef3nyeicEI81cnOp
         QQEsoe87imWowCq1qhusB4GoCJsVleC8TgE0qj06Y+rnlIidCtGCxZmZNu9e4W6DsRHX
         lhEkrNfNVKESJ7ClYgAZWLV7Bsv3hiJn6gKIY17sKrsHafklIPCDuxEQOfIIEMq2PcV/
         K48ZcnAeBj3Ib8Oh1/ucvOXcGF6OhJhDnshMCoSuF87HGSLJYpuS97pxmo0vBUalFNhQ
         zQ/JXQFgi/AYx0vsA/WQ3zFKDds3x1E0wTzd1VvdgpkqUnXrgmnfFULXOORNUvfRHJfG
         ApaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748863106; x=1749467906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73R+IsieEm9ZNPYuD1doOv65SNEtsmHDr09k2pQBiO0=;
        b=a4KZibZ/HXD7o/O4JQiJ0kyH+aaq4M8c6fF2VH3FJ54JBvXvq9t4xSDSk9So/iOrqv
         OK8L/UEp2WiWQpTnl6qJsApRdEcjdXrehK7U0nebOuZkTPbdAA1P/CLrllN8u/qTrsUM
         pxA+2SDCYHPqfXiS9psD3/OGgA9uonDQLMn6AtYhSGjQQrlKJMQppv6tEhPOgDns/me6
         I25cww1X94ngs/PCBp+PhPtD4g9cnq3xF1Bv+MCEBHIw8lvaadYUXHT1luL9ICtWbZ5y
         YtEcttdTxLS3FGBOUKVdKLAAilw4V/CBCvclZhI+7pBXDf20kEJWqW9n2YaFJ2RsYkcc
         o8JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOBQirH+TEHd6dQa3WgmgKxAFjXZ4XhZ2nlffJex2c283dUL/NG1v2uvLvSeLn0vooKehC6n1S8aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK6w3HIY1DuH5OR/4nJAYVO5or1XArVEpIjrHAn53Q2fdy4bC4
	pfdDT8VSuzlbF0hLzpC3Iz5GuOj5XhTMnAH3da6kpwklBz2xQfgzt16j1joXIdWttj42u7vtWLI
	1VP5Rqcde2mFgPBrt63kvu386K9xCtXg=
X-Gm-Gg: ASbGncuUu3yFKOFM0nAxpojl1q/GsC6gB5WgWhhmPu8HPgCcvAiZkx8qifJrzKI3iLB
	D+9fPY2mFSty7IIPNsCg9qS/bNogQi4q4G0TPCJd5jGQpj6g7Y56nMVv0J1SNKi7U8Vt52I0OjC
	Sn0/CjvumLfNYA+3PVnIFBuFIXQAHCXGizKAbpgGEdHgDR
X-Google-Smtp-Source: AGHT+IGl6sVj3uLyMGyNt/pZoqKt/ik0aK05hDxN6mzzXwgmrbIhaujrCo4cQT/Ug9MgwMCbGIKrmf6JXACvZfZwihA=
X-Received: by 2002:a05:6902:4791:b0:e81:22c8:d217 with SMTP id
 3f1490d57ef6-e8122c8dbc3mr11353026276.8.1748863106406; Mon, 02 Jun 2025
 04:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aB8_rITWsMzkTiyE@ryzen> <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com>
 <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org> <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
 <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org> <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
 <aCG-gS2f3uXKaQPj@ryzen> <CAAZ0mTfqE+w8BBCyVSg0KKQ6fYZwKaqvh_ND8dLCANg-oMaphA@mail.gmail.com>
 <aCHZg4tj6YwS9vph@ryzen> <CAAZ0mTeiVqZQvkWzJ8aFH4FUPCZwy5O+9hPBgDPhSgNNz+t6HA@mail.gmail.com>
 <aCTZkV5mRjDsYyeE@ryzen>
In-Reply-To: <aCTZkV5mRjDsYyeE@ryzen>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Mon, 2 Jun 2025 14:17:49 +0300
X-Gm-Features: AX0GCFu9QgJG29lnNPnGNG659LhcyV9XfaelRrBLhx3GgWxbqvuORbOH5qnOtIo
Message-ID: <CAAZ0mTcge55H4Ow0JG8PE5Wpgtz6TG60uvGxRUXrq-aVH4k9aQ@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ke 14.5.2025 klo 20.57 Niklas Cassel (cassel@kernel.org) kirjoitti:
>
> Hello Mikko,
>
> On Mon, May 12, 2025 at 05:16:14PM +0300, Mikko Juhani Korhonen wrote:
> > >
> > Yes, but for some reason now I get different results. I wonder what's
> > different now. The earlier results were on configuration
> > sata ports 5,6 -> WDC WD20EFAX-68FB5N0
> > so LPM had to be disabled (it's impossible to run anything) but can't
> > remember what kernel version and which variation I used to disable it.
> >
> > Now with vanilla 6.14.5 and configuration:
> > sata ports 5,6 -> WDC WD5000AAKX-001CA0
> > sata ports 3,4 -> WDC WD20EFAX-68FB5N0
> > I get:
>
> Well we still see:
>
> > /dev/sda:
> >
> > ATA device, with non-removable media
> >     Model Number:       WDC WD20EFAX-68FB5N0
> >     Firmware Revision:  82.00A82
> > Commands/features:
> >     Enabled    Supported:
> >        *    Host-initiated interface power management
> >        *    Device-initiated interface power management
>

Hello folks!!

> This drive supports both HIPM and DIPM,
> and has both enabled. (Which makes sense since lpm-pol 3 includes DIPM.)

Yes.


> > /dev/sdb:
> >
> > ATA device, with non-removable media
> >     Model Number:       WDC WD20EFAX-68FB5N0
> >     Firmware Revision:  82.00A82
> > Commands/features:
> >     Enabled    Supported:
> >        *    Host-initiated interface power management
> >             Device-initiated interface power management
>
> This drive supports HIPM and DIPM,
> but only HIPM has been enabled. (Which does not make sense since
> lpm-pol 3 includes DIPM...)
>
> I have no idea what is going on here...

It seems I can no longer reproduce this, DIPM is always enabled on
this configuration.

>
> I would add some debug prints around:
> https://github.com/torvalds/linux/blob/v6.15-rc6/drivers/ata/libata-eh.c#L3512-L3520
>
> To
> 1) Make sure that we actually send down the SET FEATURES command for
> to the drive.

I confirmed this, at least ata_dev_set_feature(dev,  SETFEATURES_SATA_ENABLE,
SATA_DIPM); gets called.

>
> 2) Check the return code (err_mask).

Error code is zero. However now DIPM is enabled so I guess this is expected.

> Did you do something with this drive?
> Was this perhaps the drive that got timeout? and for some reason
> the timeouts caused DIPM to get disabled?

Just reminding that the answer is no :)

> Did you get any timeouts on the other drive of the same model (/dev/sda) ?
No, as this is configuration where they are on ports 3-4..

>
> > /dev/sdc:
> >
> > ATA device, with non-removable media
> >     Model Number:       WDC WD5000AAKX-001CA0
> >     Firmware Revision:  15.01H15
> > Commands/features:
> >     Enabled    Supported:
> >        *    Host-initiated interface power management
>
> This drive appears to only support HIPM, it does not support DIPM.
> It has HIPM enabled, because that is the only feature supported by
> the drive.
Yes

> Looking at what you told before:
>
> WD5000AAKX-001CA0 works with LPM enabled (lpm-pol 3), on port 5-6.
> WD20EFAX-68FB5N0 gets timeouts with LPM enabled (lpm-pol 3), on port 5-6.
>
> Would again suggest that your controller has issues with DIPM.
> The reason why you don't need the "no lpm" quirk on the
> "WDC WD5000AAKX-001CA0" drive is most likely because it doesn't support DIPM.
Yes most likely.

>
> Remind me again, without any quirks, do you get timeouts for the
> "WDC WD20EFAX-68FB5N0" drive on all drives, or just on port 5-6?
Only on ports 5-6, never on 3-4.

>
> I would really like to know why DIPM is not enabled on your device,
> even though it claims support for it, and you are using lpm-pol 3.
Yes, but now I can't reproduce it. Any ideas how could we debug this
further? I don't have.

Or shall we just disable dipm on ports 5-6 along lines of:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 163ac909bd06..65dadac93461 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -52,6 +52,7 @@ enum board_ids {
       board_ahci_ign_iferr,
       board_ahci_no_debounce_delay,
       board_ahci_no_msi,
+       board_ahci_no_dipm_ports45,
       /*
        * board_ahci_pcs_quirk is for legacy Intel platforms.
        * Modern Intel platforms should use board_ahci instead.
@@ -152,6 +153,12 @@ static const struct ata_port_info ahci_port_info[] = {
               .udma_mask      = ATA_UDMA6,
               .port_ops       = &ahci_ops,
       },
+       [board_ahci_no_dipm_ports45] = {
+               .flags          = AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM_PORTS45,
+               .pio_mask       = ATA_PIO4,
+               .udma_mask      = ATA_UDMA6,
+               .port_ops       = &ahci_ops,
+       },
       [board_ahci_no_msi] = {
               AHCI_HFLAGS     (AHCI_HFLAG_NO_MSI),
               .flags          = AHCI_FLAG_COMMON,
@@ -466,6 +473,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
       { PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /*
AMD Hudson-2 (AHCI mode) */
       { PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
       { PCI_VDEVICE(AMD, 0x7901), board_ahci }, /* AMD Green Sardine */
+       { PCI_VDEVICE(AMD, 0x43EB), board_ahci_no_dipm_ports45 }, /*
500 Series Chipset */
       /* AMD is using RAID class only for ahci controllers */
       { PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
         PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b990c1ee0b12..de4e058401a5 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3432,7 +3432,10 @@ static int ata_eh_set_lpm(struct ata_link
*link, enum ata_lpm_policy policy,
       struct ata_eh_context *ehc = &link->eh_context;
       struct ata_device *dev, *link_dev = NULL, *lpm_dev = NULL;
       enum ata_lpm_policy old_policy = link->lpm_policy;
-       bool no_dipm = link->ap->flags & ATA_FLAG_NO_DIPM;
+       bool no_dipm = link->ap->flags & ATA_FLAG_NO_DIPM ||
+               ( link->ap->flags & ATA_FLAG_NO_DIPM_PORTS45 &&
+               ( link->ap->port_no == 4 ||
+               link->ap->port_no == 5 ));
       unsigned int hints = ATA_LPM_EMPTY | ATA_LPM_HIPM;
       unsigned int err_mask;
       int rc;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e5695998acb0..467a91362d2d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -218,6 +218,7 @@ enum {
                                             * led */
       ATA_FLAG_NO_DIPM        = (1 << 23), /* host not happy with DIPM */
       ATA_FLAG_SAS_HOST       = (1 << 24), /* SAS host */
+       ATA_FLAG_NO_DIPM_PORTS45= (1 << 25), /* host ports 45 not
happy with DIPM */

       /* bits 24:31 of ap->flags are reserved for LLD specific flags */

or for all ports (Damien's patch earlier in this thread) ? I don't know.

best regards,
Mikko
