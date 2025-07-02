Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE77237172
	for <linux-ide@vger.kernel.org>; Wed,  2 Jul 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450775; cv=none; b=dZCu1j1ox/O20wyJiMZE5KxRmETkN29vDJ9Y8Jl02x2xKaaJh5RKh/OoBcVUF89I+fZHIPYe+OKcytZlpjQgq9DgsxzPQgmbl+AHgUfOD7IRkDGRz3GYHNUQcbKR7et9vAFr6nQltBfnMUBWvVRdc/tfGN6lXYlI5SfsRLLYljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450775; c=relaxed/simple;
	bh=zDFNgWAIcqOkYNR2CQTXOKyHBN7Sc9+tpTNAVU2dWjo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OvN57HEeeJY3VyXT8cBXHhBy0pg1lCn9Gn6BXqKA85V7txkRdDpZBOdA1BTP7uvv5rae13TdMjDIURhPOdvuEi03jNIiqGDkmRrs79WEy0+E0+OsreKgk5STG1uvH2HiieXZr66S0WDLBmrL4Zuv1+VhoR3PkySFmmx+ZBtbLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYmWuYYJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYmWuYYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E258C4CEED;
	Wed,  2 Jul 2025 10:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751450774;
	bh=zDFNgWAIcqOkYNR2CQTXOKyHBN7Sc9+tpTNAVU2dWjo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=DYmWuYYJTpU9sWckF84vOEsZYb3i70JswpBKqCU87GK1ec1XKEodDrLFogA9yhFSD
	 OTidGemsANG/76HYW3xEXuutISc5l5hLxoq+R/Q39V+jZWAezQuk7va+/7xfmnyZAb
	 VADaT/rAbST1cuUP8mrqEMb4Z2GwQix+WVOfAyUyZbF8082+eXQysEUnrPs/Hu10B2
	 tuZdjp2ExWWEgKfiKaDc+pRhIJOJE64ZiwDMgCCP0ifhRipYYY56HqS904pNZfaiwa
	 k8q0XppNsEpaWmv3gpqo8BU/oFfEcfLwHnV7hXfVLOUdHJXngl5CrMJwDe5meDnZoe
	 LbWK2vjH5mWeg==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250701125321.69496-1-dlemoal@kernel.org>
References: <20250701125321.69496-1-dlemoal@kernel.org>
Subject: Re: [PATCH v3 00/10] Improve link power management
Message-Id: <175145077391.2195681.147024509774531965.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 12:06:13 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 01 Jul 2025 21:53:11 +0900, Damien Le Moal wrote:
> This patch series improves ATA link power management, mainly for the
> AHCI driver. Follow-up patches will address libsas and AHCI platform
> adapters.
> 
> These patches are a mix of code cleanup and LPM management improvements
> around the application of an appropriate initial link power management
> policy and preventing users or system daemons from changing a port link
> power management policy through sysfs when the port or the device does
> not support LPM policies or the port is an external port (and using LPM
> would break the port hotplug capability).
> 
> [...]

Applied to libata/linux.git (for-6.17), thanks!

[01/10] ata: libata-core: Introduce ata_dev_config_lpm()
        https://git.kernel.org/libata/linux/c/d3601218
[02/10] ata: libata-core: Move device LPM quirk settings to ata_dev_config_lpm()
        https://git.kernel.org/libata/linux/c/d99a9142
[03/10] ata: libata-core: Advertize device support for DIPM and HIPM features
        https://git.kernel.org/libata/linux/c/b1f5af54
[04/10] ata: libata-eh: Avoid unnecessary resets when revalidating devices
        https://git.kernel.org/libata/linux/c/4371fe1b
[05/10] ata: libata-sata: Disallow changing LPM state if not supported
        https://git.kernel.org/libata/linux/c/413e800c
[06/10] ata: ahci: Disable DIPM if host lacks support
        https://git.kernel.org/libata/linux/c/f7870e8d
[07/10] ata: ahci: Disallow LPM policy control for external ports
        https://git.kernel.org/libata/linux/c/4edf1505
[08/10] ata: ahci: Disallow LPM policy control if not supported
        https://git.kernel.org/libata/linux/c/65b2c92f
[09/10] ata: libata-core: Reduce the number of messages signaling broken LPM
        https://git.kernel.org/libata/linux/c/3b50dd4c
[10/10] ata: libata_eh: Add debug messages to ata_eh_link_set_lpm()
        https://git.kernel.org/libata/linux/c/cb35d3b6

Kind regards,
Niklas

