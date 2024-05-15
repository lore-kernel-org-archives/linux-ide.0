Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765784D03
	for <linux-ide@vger.kernel.org>; Wed, 15 May 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793583; cv=none; b=gOts31sXSiFrpQK5sj+jRV9Uzk4Mh5B8sqTTTqWrmPSvP7WkWeBLbC+qLx4mACNfdx4K6oQdXKCxFyP+UeN6JikRZUKJDkIQrQ3sndidBkmzRG8lajq6oaWvoBYNaRyl23PMxKsaI8TzmpU+Q+E6FP4TnJqWWBBTDKAHHLU6d4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793583; c=relaxed/simple;
	bh=hwhCyyomBMRy6f3ziSe9YavavDUiIEA11jSWS+CrcEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwZqsEEq2UlR1awZxv7n3AYJNPd72oIvpd1+s+S8wdtWF9BQAVo67JRoJrNhTkAmB0zHW3jeDfkQgYWcrnP58+2iReNnORIKI2EM1a59zuTeCLDkZ8BGEQFJmSsWiqzp4rxYsyjBYshwQ0XBirX/oeLLzFD2mozJm8/WEuJ+CLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyWpQdD/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyWpQdD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD82C116B1;
	Wed, 15 May 2024 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715793583;
	bh=hwhCyyomBMRy6f3ziSe9YavavDUiIEA11jSWS+CrcEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyWpQdD/AXTA5UvyoxLus1jX0Z1m4kV9p4b58VxNOKrCX9SukNIPWW4hSWtX8BOYR
	 By24dwZZictrpHV4THjK3ebYw7fMjmok7HYPSIunru1H+WunQi/pUf4U+lY1D03GaX
	 BLw5hRDdE866X6JsRJWLJjmVekh1+WHU1015A36Dmk/1HWWw5AjX1R2REPGdJDg/di
	 nz4I5a9qNXC/UWoceZ6wXiasuZ538gcN/jP+wpdpM5S3+IF2LVhqRG/EB1F3cdueJv
	 H29+rMMf96pR9tHxnmm9fiJxL5/V4i9ledjf+slE3xSReMCpgOLgzNDmTD1NYZmIhB
	 GqBq37xUYBKpA==
Date: Wed, 15 May 2024 19:19:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: dev@kayoway.com
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: Revert "ata: ahci: Add Intel Alder Lake-P
 AHCI controller to low power chipsets list"
Message-ID: <ZkTuq0F_u0I57RDS@ryzen.lan>
References: <20240513135302.1869084-1-dev@kayoway.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513135302.1869084-1-dev@kayoway.com>

Hello Jason,

On Mon, May 13, 2024 at 10:53:01PM +0900, dev@kayoway.com wrote:
> From: Jason Nader <dev@kayoway.com>
> 
> Commit b8b8b4e0c052b2c06e1c4820a8001f4e0f77900f ("ata: ahci: Add Intel 
> Alder Lake-P AHCI controller to low power chipsets list") enabled LPM for
> Alder Lake-P AHCI adaptors, however this introduced a regression on at 
> least one system which causes the SATA ports to become unusable [1].
> 
> The original commit stated it is for Alder Lake-P, which I understand is a 
> mobile CPU, however the device ID added (0x7ae2) matches the one reported
> by my system which has an Alder Lake-S desktop CPU [2]. Searching for this 
> device on other websites points to 0x7ae2 being for the desktop "-S" 
> suffix [3] and not for the "-P" suffix, which is apparently 0x51d3 [4][5].
> 
> Reverting this commit restores SATA port functionality on my system [6][7].
> 
> [1] This Ubuntu bug report also appears to suffer from the same issue, so 
> there are more affected systems out there:
>  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2063229
> 
> [2] System details:
> CPU: Intel i5-12400
> Motherboard: Biostar B660GTN
> BIOS Settings: Intel VMD off, SATA hot plug off, CSM off
> >lspci -nn -s 00:17
> 00:17.0 SATA controller [0106]: Intel Corporation Alder Lake-S PCH SATA Controller [AHCI Mode] [8086:7ae2] (rev 11)
> 
> [3] https://devicehunt.com/view/type/pci/vendor/8086/device/7AE2
> [4] https://linux-hardware.org/?id=pci:8086-51d3-1462-1333
> [5] https://linux-hardware.org/?view=search&vendorid=8086&deviceid=51d3#list
> 
> [6] Kernel logs before revert:
> ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf0 impl SATA mode
> ata5: SATA max UDMA/133 abar m2048@0x80702000 port 0x80702300 irq 124 lpm-pol 3
> ata6: SATA max UDMA/133 abar m2048@0x80702000 port 0x80702380 irq 124 lpm-pol 3
> ata7: SATA max UDMA/133 abar m2048@0x80702000 port 0x80702400 irq 124 lpm-pol 3
> ata8: SATA max UDMA/133 abar m2048@0x80702000 port 0x80702480 irq 124 lpm-pol 3
> ata5: SATA link down (SStatus 4 SControl 300)
> ata6: SATA link down (SStatus 4 SControl 300)
> ata8: SATA link down (SStatus 4 SControl 300)
> ata7: SATA link down (SStatus 4 SControl 300)
> 
> [7] Kernel logs after revert:
> ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf0 impl SATA mode
> ata5: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802300 irq 125 lpm-pol 0
> ata6: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802380 irq 125 lpm-pol 0
> ata7: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802400 irq 125 lpm-pol 0
> ata8: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802480 irq 125 lpm-pol 0
> ata8: SATA link down (SStatus 0 SControl 300)
> ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

These logs do not make sense to me.

Why is lpm-pol 3 before and lpm-pol 0 after removing the entry?
Are you using the same kernel config?

Could you please take:
v6.9 + the following debug print:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6548f10e61d9..0a14a09070ea 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1733,8 +1733,10 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
         * Management Interaction in AHCI 1.3.1. Therefore, do not enable
         * LPM if the port advertises itself as an external port.
         */
-       if (ap->pflags & ATA_PFLAG_EXTERNAL)
+       if (ap->pflags & ATA_PFLAG_EXTERNAL) {
+               ata_port_info(ap, "external port, not enabling LPM\n");
                return;
+       }
 
        /* user modified policy via module param */
        if (mobile_lpm_policy != -1) {



And then:
v6.9 + the debug print above + the removal of the Alder Lake-P AHCI entry.
-	{ PCI_VDEVICE(INTEL, 0x7ae2), board_ahci_pcs_quirk }, /* Alder Lake-P AHCI */

And paste the same kernel prints as you did in this email?

Thank you!


Kind regards,
Niklas
