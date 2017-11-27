From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch] lewisburg map/pcs register handling
Date: Mon, 27 Nov 2017 11:25:26 -0800
Message-ID: <20171127192526.GI983427@devbig577.frc2.facebook.com>
References: <CAF2xp_HuE+aV3ZhrC0E9CQopYgTQ4AHcK15v248AVgxXn8A0pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45916 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbdK0TZ3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Nov 2017 14:25:29 -0500
Received: by mail-qt0-f194.google.com with SMTP id r37so32518259qtj.12
        for <linux-ide@vger.kernel.org>; Mon, 27 Nov 2017 11:25:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAF2xp_HuE+aV3ZhrC0E9CQopYgTQ4AHcK15v248AVgxXn8A0pA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Chang <dpf@google.com>
Cc: linux-ide@vger.kernel.org

Hello, Peter.

On Tue, Nov 14, 2017 at 03:55:12PM -0800, Peter Chang wrote:
> From 62ccc6118960204769809a1ea9d162cf2c1c95e1 Mon Sep 17 00:00:00 2001
> From: peter chang <dpf@google.com>
> Date: Tue, 14 Nov 2017 13:43:15 -0800
> Subject: [PATCH] ahci: lewisburg MAP / PCS register handling
> 
> registers are now 32-bits and the existing offsets mean that the
> wrong registers are being updated.
> 
> Change-Id: I992b31bc9e789f9dfbeb29afeb0b7777e325ea71

Can you please drop Change-Id and add Signed-off-by?  Also, the
earlier part of the email where you explained what's going on was
actually easier to understand.  Maybe put that in the description?

> -		pci_read_config_word(pdev, 0x92, &tmp16);
> -		if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
> -			tmp16 |= hpriv->port_map;
> -			pci_write_config_word(pdev, 0x92, tmp16);
> +		if (hpriv->flags & AHCI_HFLAG_32BIT_MAP_PCS)
> +			pci_read_config_dword(pdev, 0x94, &tmp32);
> +		else {
> +			pci_read_config_word(pdev, 0x92, &tmp16);
> +			tmp32 = tmp16;
> +		}

The coding style says that we always add {} to both if and else bodies.

> +		if ((tmp32 & hpriv->port_map) != hpriv->port_map) {
> +			tmp32 |= hpriv->port_map;
> +			if (hpriv->flags & AHCI_HFLAG_32BIT_MAP_PCS)
> +				pci_write_config_dword(pdev, 0x94, tmp32);
> +			else {
> +				tmp16 = tmp32;
> +				pci_write_config_word(pdev, 0x92, tmp16);
> +			}

@@ -523,6 +524,24 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>  		port_map &= hpriv->mask_port_map;
>  	}
>  
> +	if (hpriv->flags & AHCI_HFLAG_PCI_PORT_MAP) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		u16 disabled;
> +
> +		if (hpriv->flags & AHCI_HFLAG_32BIT_MAP_PCS) {
> +			u32 tmp;
> +
> +			pci_read_config_dword(pdev, 0x90, &tmp);
> +			disabled = (tmp >> 16) & 0xffff;
> +		} else {
> +			pci_read_config_word(pdev, 0x90, &disabled);
> +			disabled = (disabled >> 8) & 0xff;
> +		}
> +
> +		dev_info(dev, "port_map:%x disabled:%x\n", port_map, disabled);
> +		port_map &= ~disabled;
> +	}

And the patch description doesn't explain the above chunk.  Can you
please explain this part too?

Thanks.

-- 
tejun
