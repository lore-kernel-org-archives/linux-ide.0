From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Fri, 08 Jan 2016 11:59:53 -0800
Message-ID: <1452283193.4028.84.camel@perches.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:34431 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755266AbcAHT76 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jan 2016 14:59:58 -0500
In-Reply-To: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, tj@kernel.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, 2016-01-07 at 14:53 -0600, Brijesh Singh wrote:
> AMD Seattle SATA controller mostly conforms to AHCI interface with so=
me
> special register to control SGPIO interface. In the case of an AHCI
> controller, the SGPIO feature is ideally implemented using the
> "Enclosure Management" register of the AHCI controller, but those
> registeres are not implemented in the Seattle SoC. Instead SoC
> (Rev B0 onwards) provides a 32-bit SGPIO control register which shoul=
d
> be programmed to control the activity, locate and fault LEDs.

trivia:

> diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
[]
> +static ssize_t seattle_transmit_led_message(struct ata_port *ap, u32=
 state,
> +					=A0=A0=A0=A0ssize_t size)
> +{
> +	struct ahci_host_priv *hpriv =3D ap->host->private_data;
> +	struct ahci_port_priv *pp =3D ap->private_data;
> +	struct seattle_plat_data *plat_data =3D hpriv->plat_data;
> +	unsigned long flags;
> +	int pmp;
> +	struct ahci_em_priv *emp;
> +	u32 val;
> +
> +	/* get the slot number from the message */
> +	pmp =3D (state & EM_MSG_LED_PMP_SLOT) >> 8;
> +	if (pmp < EM_MAX_SLOTS)
> +		emp =3D &pp->em_priv[pmp];
> +	else
> +		return -EINVAL;

This is generally done using a inverted test that
returns immediately

	if (pmp >=3D EMP_MAX_SLOTS)
		return -EINVAL;

	emp =3D &pp->em_priv[pmp];


