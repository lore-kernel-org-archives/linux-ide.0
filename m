Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D950250
	for <linux-ide@vger.kernel.org>; Thu,  8 Feb 2024 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435285; cv=none; b=tvxYSq098cDTagbfFndBMVtH7t4bb7BAr6YfZK/QOIf/Bk5lHZJTz8G1XC8Ad9K3fp31qKhw0SyN79YbbOeuChBRgnT3PokG4n8MWrE56Y+Q1dvrmlkESY24WyU1wMjYo6iFARuuXQgPWWW3p/VqzOS10F1hzh3iJy6/KTq8P8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435285; c=relaxed/simple;
	bh=MDbn7WK5E+8AWaxd6fOkdDBmNwGRmkf2muUs1YfbfE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWOR7EbHCokKJyLV7TNgD60rSHjIETc/glAvJk7pegm3L3yJXXt1+ixS0cFA24R/e7CmeaWMbRm673vgPNufLsZh3OUHs7Auj+pmwFknCD8rCdGLpLyN2iQzUY4SNi0o4KX6MBMyaOrYwvfnMXzeseL3BFxJIuiuna+jCBDBuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptolQ5+c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptolQ5+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55112C43399;
	Thu,  8 Feb 2024 23:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707435284;
	bh=MDbn7WK5E+8AWaxd6fOkdDBmNwGRmkf2muUs1YfbfE0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ptolQ5+csf8rhmyxL2B42tv9+op04dDqixfblswzu3I2jQNxmKM7GjIzJK2fBaMXL
	 gPAcE+jPYWmlREPd0H5ZIwiyghi4lSWJSZcqSXKe7JSGTr0sYlrW6ULwukpMmF4FJL
	 5kbbCYj+8DDVKLv+Kb0qgK8dLKRembktLVGrDl/YpkJlLA/4gtn0mO9xx8EAJ+/6RJ
	 YQAk5MuaV2/YQa/fQ6QfquSfhJJ1vnjTVuXRyjsBh3EYLqASlQexhRQppWtvrqMv9u
	 eO7XEuiG55sppglnXDhAcdQZHLuhUpimimAOnSV8Kp9TYzODnukbxWlXELK6I3dZyG
	 ezYQS/r3dbCKQ==
Message-ID: <84197a2e-cdee-468d-b736-93bb993e3c75@kernel.org>
Date: Fri, 9 Feb 2024 08:34:42 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ata: ahci: do not enable LPM on external ports
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz
 <dmummenschanz@web.de>, Mario Limonciello <mario.limonciello@amd.com>,
 linux-ide@vger.kernel.org
References: <20240206211352.1664816-1-cassel@kernel.org>
 <20240206211352.1664816-5-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240206211352.1664816-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/24 06:13, Niklas Cassel wrote:
> AHCI 1.3.3, 7.3.1.1 Software Flow for Hot Plug Removal Detection states:
> "To reliably detect hot plug removals, software must disable interface
> power management.
> 
> Software should perform the following initialization on a port after a
> device is attached:
> -Set PxSCTL.IPM to 3h to disable interface power management state
>  transitions.
> -Set PxCMD.ALPE to ‘0’ to disable aggressive power management.
> -Ensure PxIE.PRCE is set to ‘1’ to enable interrupts on hot plug removals.
> -Disable device initiated interface power management by issuing the
>  appropriate SET FEATURES command."
> 
> Further, AHCI 1.3.3, 7.3 Native Hot Plug Support states:
> "The HBA shall set the PxSERR.DIAG.X bit to ‘1’ when a COMINIT is received
> from the device. Hot plug insertions are detected via the PxIS.PCS bit
> that directly reflects the PxSERR.DIAG.X bit. The HBA shall set the
> PxSERR.DIAG.N bit to ‘1’ when the HBA’s internal PhyRdy signal changes
> state.
> 
> Hot plug removals are detected via the PxIS.PRCS bit that directly
> reflects the PxSERR.DIAG.N bit. Note that PxSERR.DIAG.N is also set
> to ‘1’ on insertions and during interface power management entry/exit."
> 
> ahci_set_lpm() already disables the PxIS.PRCS interrupt if setting a
> LPM policy != ATA_LPM_MAX_POWER, so we cannot detect hot plug removals
> when LPM policy != ATA_LPM_MAX_POWER.
> 
> We do have PxIS.PCS interrupt enabled even for LPM policy !=
> ATA_LPM_MAX_POWER, so we should theoretically still be able to detect
> hot plug insertions even when LPM is enabled.
> 
> However, in practise, for LPM policy ATA_LPM_MED_POWER_WITH_DIPM,
> ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MIN_POWER, if there is
> no link enabled, sata_link_scr_lpm() will set SControl.DET = 0x4,
> which will transition the port to the "P:Offline" state.
> 
> The P:Offline mode is described in SATA Gold 3.5a:
> 4.1.1.103 Phy offline:
> "In this mode the host Phy is forced off and the host Phy does not
> recognize nor respond to COMINIT or COMWAKE. This mode is entered by
> setting the DET field of the SControl register to 0100b. This is a
> mechanism for the host to turn off its Phy."
> 
> So in the P:Offline state the PHY does not recognize the unsolicited
> COMINIT which is sent on a hot plug insertion.
> 
> While we could change sata_link_scr_lpm() to never power off an external
> port for LPM policy != ATA_LPM_MAX_POWER (in order be able to handle hot
> plug insertions), we still would not be able to handle hot plug removals.
> 
> Thus, simply modify ahci_update_initial_lpm_policy() to not enable LPM if
> the port advertises itself as an external port, as this function is
> already being used to set/override the initial LPM policy.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

