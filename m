Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281BA6EB74
	for <linux-ide@vger.kernel.org>; Thu, 14 Mar 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431924; cv=none; b=sc9OEFxRPHCRa4FH+7mzilgtVdq5KkOg9PkwMoCba3bfR+/QPdYoK+TcV9vmhgt/gA0LY8yma7LmjqcShyYwuh0UTR7IuY+1jWyjv5SUZL9gKEP8YsIahTy/xKDLS1vaRqR0Lu9KlxEArKUyoIX5KWX1a4RRSj9NyfCqJhwlVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431924; c=relaxed/simple;
	bh=oCFirtwhxvWtqP4B3zbRKTVRfzOF6/0s+0xxOvl/64U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXXoZedEPjn4RYkv0d9galaQ8xO/8X+j/qCkS982Rr5zrqxPb+wNNnR4GB7B7KnHwxNMkRRklkIzRItadqbj0OgtiWxC1WP3Jg5R6WXhL9vPw83zrraobCJglvtE4jrNEqBPPfH23AMUmPluanmiWy5JoZBB4YdDskDLldpOkjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bqd6HUVu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bqd6HUVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8955C433F1;
	Thu, 14 Mar 2024 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710431923;
	bh=oCFirtwhxvWtqP4B3zbRKTVRfzOF6/0s+0xxOvl/64U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bqd6HUVuWAsqdsE0UZvc6Vz4XrUWuNnagkcAzkcFJulkh/AeoQe6aSfIbubs6U6sT
	 AyKFK2Hhaa5buBZQFv4R1XLrjdGm9J1FlBXMrTd3WQjE4G2e4No8a+ClrkH6Ts1aix
	 dOn0qhHteikKucsMXR1iYc3dKAM2eqvYuSSEup8+0s4AC9+GkVqOILtSF1IkBuruKZ
	 COhby0XJ/iQSb7adxzovKkBOhiXX2K3mJVjI4LbaZ7VGMwZ6Oc+TdyfmlZdJhrrnST
	 w5Vr+zrMDZt697DSwORJmWyPLHEns8g9MCF9nKcYvCGlYoJ20rOEyb17I/1a59GGKE
	 gXSxJxA5eo/QQ==
Date: Thu, 14 Mar 2024 16:58:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Cryptearth <cryptearth@googlemail.com>
Cc: Andrey Melnikov <temnota.am@gmail.com>, linux-ide@vger.kernel.org,
	conikost@gentoo.org, hdegoede@redhat.com
Subject: Re: ASMedia ASM1166/ASM1064 port restrictions will break cards with
 port-multipliers
Message-ID: <ZfMerqAmWoyu66/5@x1-carbon>
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OVLE9cSqenZ7yC7n"
Content-Disposition: inline
In-Reply-To: <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>


--OVLE9cSqenZ7yC7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Matt,

On Wed, Mar 13, 2024 at 06:37:56PM +0100, Cryptearth wrote:
> 
> As for why the ASM chips report 30+ ports: A wild guess in the blue:
> They were designed with port multipliers in mind and likely report the
> max number of drives they can handle when combined with multipliers.
> From what I get the "fix" is supposed to reduce boot time - well, from
> my logs I see it's not the enumeration of the empty ports which takes
> time but of course the initialization of the detected drives.
> To me the initial report that lead to this changed just should had
> been marked as won't fix or even as invalid - as looking thru the
> history of ahci.c litterally noone seem to have bothered about it
> since the ASM IDs were added.

Well, that is simply not how PMP works.

For PMP to be supported the HBA needs to set CAP.SPM (Supports Port Muliplier).
(This also implies Command-based switching is supported.)

The HBA can additionally set CAP.FBSS (FIS-based Switching Supported),
if CAP.SPM is set.

If CAP.SPM is set, you can plug in a PMP to each of the ports.
Each PMP can support a max of 15 ports.

If PMP is enabled, you fill in the port number behind the port when
queuing the command:
https://github.com/torvalds/linux/blob/v6.8/drivers/ata/libahci.c#L1424
https://github.com/torvalds/linux/blob/v6.8/drivers/ata/libata-sata.c#L154


Looking at your SATA HBA:
> [    0.608537] ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
> [    0.608540] ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst

We can see that it does not support PMP at all.
There is no "pmp" in print, which means that CAP.SPM was not set.

So your HBA does not support PMP, sorry.


Yes, we can see that it claims that it has 24 ports from the print, so it
appears that they have implemented their own version of PMP that is not
compatible with AHCI. Lovely :)



I think this brings more questions than answers...

What is the PCI device and vendor ID for this device?

You said that this is a PCIe card with a ASM1064 and two port multipliers
on the same PCIe card?

From what we've heard before, a ASMedia card with 4 physical slots,
like this card:
https://www.newegg.com/p/17Z-0061-000B5

Has PCIe device and vendor ID:
{ PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },   /* ASM1064 */

But you have a PCIe card with the same device and vendor ID,
but your card also has 2 port multipliers with 4 ports each?

Well, I guess it should be fine to use the PCI device and vendor ID
for the underlying HBA... considering that devices connected to the
ports are supposed to be discoverable...

If they only claimed that the HBA supported PMP, the Linux device
driver would try to enumerate the devices behind the PMP according
to the standard.

See AHCI 1.3.1, section 9.2 Port Multiplier Enumeration.
Or
SATA-IO - Port Multiplier 1.0, 7.4.2 Device Enumeration.

The PMP standard also describes how you read the device and vendor
ID of the PMP.


Right now, they AMedia? seem to have their own home-made PMP implementation.


Could you try the attached patch on top of v6.8, to see if Linux
can detect the devices behind the two JMB575 PMPs?

If that works, we could still support PMP (according to the standard),
and people with a ASM1064 PCIe card that does not have any port multipliers
on the PCIe card would not suffer from significantly increased boot times.

I guess a second step would be to see if ASM1064 also supports
FIS-based switching.

https://www.asmedia.com.tw/product/A58yQC9Sp5qg6TrF/58dYQ8bxZ4UR9wG5

Simply says "Supported port multiplier command based switching",
it doesn't seem to mention FIS-based switching... so I guess not?
(If it did, libata already has a AHCI_HFLAG_YES_FBS for other broken HBAs.)


Kind regards,
Niklas

--OVLE9cSqenZ7yC7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-add-hflag-to-force-PMP-cap-on.patch"

From a5001fd7b19d3a6a9abd42a19b58e2aaee1b83e2 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Thu, 14 Mar 2024 16:36:34 +0100
Subject: [PATCH] add hflag to force PMP cap on

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c    | 2 ++
 drivers/ata/ahci.h    | 1 +
 drivers/ata/libahci.c | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 682ff550ccfb9..a99de94075a1a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -676,10 +676,12 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 		case 0x1166:
 			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
 			hpriv->saved_port_map = 0x3f;
+			hpriv->flags |= AHCI_HFLAG_YES_PMP;
 			break;
 		case 0x1064:
 			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
 			hpriv->saved_port_map = 0xf;
+			hpriv->flags |= AHCI_HFLAG_YES_PMP;
 			break;
 		}
 	}
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index df8f8a1a3a34c..f9cae26848480 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -230,6 +230,7 @@ enum {
 						      error-handling stage) */
 	AHCI_HFLAG_NO_DEVSLP		= BIT(17), /* no device sleep */
 	AHCI_HFLAG_NO_FBS		= BIT(18), /* no FBS */
+	AHCI_HFLAG_YES_PMP		= BIT(19), /* force PMP cap on */
 
 #ifdef CONFIG_PCI_MSI
 	AHCI_HFLAG_MULTI_MSI		= BIT(20), /* per-port MSI(-X) */
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1a63200ea437b..9a1d10205de85 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -493,6 +493,11 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 		cap |= HOST_CAP_NCQ;
 	}
 
+	if (!(cap & HOST_CAP_PMP) && (hpriv->flags & AHCI_HFLAG_YES_PMP)) {
+		dev_info(dev, "controller can do PMP, turning on CAP_PMP\n");
+		cap |= HOST_CAP_PMP;
+	}
+
 	if ((cap & HOST_CAP_PMP) && (hpriv->flags & AHCI_HFLAG_NO_PMP)) {
 		dev_info(dev, "controller can't do PMP, turning off CAP_PMP\n");
 		cap &= ~HOST_CAP_PMP;
-- 
2.44.0


--OVLE9cSqenZ7yC7n--
