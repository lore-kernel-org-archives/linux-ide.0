From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 17/86] pata_efar: fix register naming used in
 efar_set_piomode()
Date: Wed, 25 Nov 2009 17:25:41 +0000
Message-ID: <20091125172541.1267490f@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170422.5446.10637.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759319AbZKYRXk@vger.kernel.org>
In-Reply-To: <20091125170422.5446.10637.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> Rename 'idetm_port' and 'idetm_data' variables to 'master_port'
> and 'master_data' respectively to match register naming used in
> efar_set_dma_mode() and in ata_piix.c.

Probably better to do the reverse to match the docs ?

> -	u16 idetm_data;
> +	u8 master_port		= ap->port_no ? 0x42 : 0x40;
> +	u16 master_data;

Please don't drop undocumented type changes in. And btw it uses unsigned
int here as all over the kernel because it produced better code in many
cases

These patches seem to spend a lot of time renaming everything in drivers
which is usually pointless churn (eg the atp grand renaming), but the bug
fixes all look good
