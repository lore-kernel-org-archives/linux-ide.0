Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302202931D5
	for <linux-ide@vger.kernel.org>; Tue, 18 Aug 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046710; cv=none; b=Hr++sY7UQtm060Rr/9AocwPSgZBb5cldOWG7Faq66i0aYKj565lt9trPyKl12WPTuyTXE+R6SUHxPa+EtkwAMV7UeNH8Xu7VGwTEfiBf+BrpNIiEwWL/M/9f3BaNZXzZ8TpQ97LMo+dnKNSe0hXuK6RZe1VQtz6MkR7ShRL8J0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046710; c=relaxed/simple;
	bh=XlIkmSdS1CZX15aBj9TGObV501thlhin7WGRZ0r27oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p7AuytwBWpTOYIF/LGa/35n6nR/CPtlJ8CL8Ts29G7GqRXzOh8Hk5T4wSPHJiyQiDKYS/eIBGqUwtl69NGLfxCQW8h4EEhyxLWP5fd2KMOESV2CqhRR37eOXfcl0/gFw2uEe63L2YWNGuqqEAjTEytD/fKb0SqNwH+NKhK3o4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJNn6OdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJNn6OdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8010E1F000E9;
	Tue, 18 Aug 2026 09:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787046708;
	bh=9Sajats7M2fJpY6a8g4Eh1vQiQVJ34cb35yiW8lbxDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WJNn6OdDFvMJQWKzzMyDJYtYcvfdByuYbtnIrW7H8A88eVehyCI9b6k1t6OIu9plM
	 czzjOMMENICSItLWXlAZMCLPqqfNTH67wyOu5UPetvBsiFTQq+aSoOls+EKhoeqGfL
	 CNvQ4X3PBX+c0rinGL/3wi5RsK5qs8CCiWAvXlfiHQzdl36Ihjk247gz6+4enysjpo
	 iOAu9o0ktx+BtepErY6mhrS8Vf2XM8Xzz3UvATsvTfeQBqMuKts60YZmW4sHvPgvwo
	 JDfdyzEFihgDDJMK82IUijg1tZTbYAjhqvC9lmRKzABj+WfwpxTkd/d+zni2DhZdZ8
	 e/t9fz0G/f5zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: ata_generic: Do not bind to devices that are not
 IDE controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260818094205.2672967-2-cassel@kernel.org>
References: <20260818094205.2672967-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 09:51:48 +0000
Message-Id: <20260818095148.8010E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting Use-After-Free in `generic_set_mode()` when an IDE dev=
ice is bound via sysfs `new_id` and the ID is later removed.
--

--- Patch [1]: [PATCH] ata: ata_generic: Do not bind to devices that are no=
t IDE controllers ---
commit 6571983234fdb7767d7bb9ad7f55e962d8eec259
Author: Niklas Cassel <cassel@kernel.org>

ata: ata_generic: Do not bind to devices that are not IDE controllers

This commit prevents ata_generic from binding to devices that are not IDE
controllers unless explicitly listed in the ID table. It resolves a fatal
synchronous external abort caused by force-binding to a virtio-blk-pci
device.

Link: https://lore.kernel.org/linux-ide/6a82bc54.10853dc7.22f513.001b.GAE@g=
oogle.com/

> diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
> index e70b6c089cf17..f57db4480ad3f 100644
> --- a/drivers/ata/ata_generic.c
> +++ b/drivers/ata/ata_generic.c
[ ... ]
> @@ -172,6 +175,19 @@ static int ata_generic_init_one(struct pci_dev *dev,=
 const struct pci_device_id
>  	};
>  	const struct ata_port_info *ppi[] =3D { &info, NULL };
> =20
> +	/*
> +	 * A device matched through driver_override or through an ID added
> +	 * with new_id does not come from our ID table, so pci_match_device()
> +	 * hands us a synthetic ID with no driver_data and none of the checks
> +	 * below apply. Probing maps BAR0 and BAR1 as the ATA command and
> +	 * control blocks and writes to the device control register, so only
> +	 * continue for devices which report the IDE class or which we list
> +	 * ourselves.
> +	 */
> +	if (!pci_match_id(ata_generic, dev) &&
> +	    (dev->class >> 8) !=3D PCI_CLASS_STORAGE_IDE)
> +		return -ENODEV;
> +

[Severity: High]
This is a pre-existing issue, but does this bypass still leave the driver
vulnerable to a use-after-free when a dynamic ID is removed?

If a device with PCI_CLASS_STORAGE_IDE is bound via the sysfs new_id
mechanism, the PCI core passes a dynamically allocated struct pci_device_id
pointer to ata_generic_init_one().=20

This bypasses the new -ENODEV check and eventually passes the dynamic ID
pointer down to be stored in the host private data:

drivers/ata/ata_generic.c:ata_generic_init_one() {
    ...
    return ata_pci_bmdma_init_one(dev, ppi, &generic_sht, (void *)id, 0);
}

If root later writes to the remove_id sysfs attribute, the PCI core frees
the dynamic ID without unbinding the device. Subsequently, if an ATA link
reset occurs, the freed memory is dereferenced:

drivers/ata/ata_generic.c:generic_set_mode() {
    ...
    const struct pci_device_id *id =3D ap->host->private_data;
    ...
    if (id->driver_data & ATA_GEN_FORCE_DMA) {
    ...
}

Could the driver avoid storing the synthetic ID in private data, or copy
the ID contents to prevent accessing freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818094205.2672=
967-2-cassel@kernel.org?part=3D1
