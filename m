Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A728D8C8
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296083; cv=none; b=ihFdkWF6eCOJt504z42ouMDLpbJtER/BEG2F4aTNkjWqFFraEGxQWQVCtDFnMZCBsyVVw/rpLwX0tpoqiFsWw2WISnTCZ2okN8qsoapdlDgxUM/524b9gUuQGAGLVVE3m5GeE13YEBdD2LnCNvqaRUamgYAqPVy4BbN2TOg+CNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296083; c=relaxed/simple;
	bh=VtSY89bmq3F9z7O9TUGSdONo8lFugY2SMhyPipK0zlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcHRN7ueC3vVOERnHYx3Lilr63tEF0hedngXxp47MD6eXfFRL76QU2KCcpwEMAC7Rz7b1rJB6uiKW7SCcjbQgWBHn0ZX2iiqYU5dWpPW5O0b1AtN5F3bccaDpNZSsKkI4CvHNbRvMxHtWX10TT20UZGcLyeeap574fJUaztmfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1zFRd6O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1zFRd6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5956DC4CEE3;
	Mon, 30 Jun 2025 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751296083;
	bh=VtSY89bmq3F9z7O9TUGSdONo8lFugY2SMhyPipK0zlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1zFRd6OyZoiBomQ12W0U1PguZ5hYsyDwVWmQ5IkQFW5LA1Q84HRRJiDD8F68TKyu
	 AIvisGJuYvpIIOsS2uGlr3PU0m+aauXGOwN70FI1h83NiQQN5GinM41n5c/C7j0nT+
	 q4x8IGCHnoM99E/vLWcQNXqRxzAAelthKL8r7fY+TyG/nnXowV7Spq+Jk82wTNloQF
	 BPFWV3I+45nelAKFbgILB6ztwMl7FZ/mRFcie+YZEIRYDPAwu+GAblAZTQ3he64umL
	 MSnCaJgDowoCaYlHZb9teGf1vQVPoiIsddm193gvgguGldd4JwHIKt9q40J0084AVq
	 R0dM4y35yYJig==
Date: Mon, 30 Jun 2025 17:07:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 08/10] ata: ahci: Disallow LPM policy control if not
 supported
Message-ID: <aGKoT3acZI_EXU2x@ryzen>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-9-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630062637.258329-9-dlemoal@kernel.org>

On Mon, Jun 30, 2025 at 03:26:35PM +0900, Damien Le Moal wrote:
> Commit fa997b0576c9 ("ata: ahci: Do not enable LPM if no LPM states are
> supported by the HBA") introduced an early return in
> ahci_update_initial_lpm_policy() to ensure that the target_lpm_policy
> of ports belonging to a host that does not support the Partial, Slumber
> and DevSleep power states is unchanged and remains set to
> ATA_LPM_UNKNOWN and thus prevents the execution of
> ata_eh_link_set_lpm().
> 
> However, a user or a system daemon (e.g. systemd-udevd) may still
> attempt changing the LPM policy through the sysfs
> link_power_management_policy of the host.
> 
> Improve this to prevent sysfs LPM policy changes by setting the flag
> ATA_FLOAG_NO_LPM for the port of such host, and initialize the port
> target_lpm_policy to ATA_LPM_MAX_POWER to guarantee that no unsupported
> low power state is being used on the port and its link.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/ahci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 34698ae39f55..737f5d1bde11 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1793,7 +1793,10 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>  	if ((ap->host->flags & ATA_HOST_NO_PART) &&
>  	    (ap->host->flags & ATA_HOST_NO_SSC) &&
>  	    (ap->host->flags & ATA_HOST_NO_DEVSLP)) {
> -		ata_port_dbg(ap, "no LPM states supported, not enabling LPM\n");
> +		ata_port_warn(ap,
> +			"No LPM states supported, forcing LPM max_power\n");

Do we really want this to be a warning?

I don't think there is anything wrong with an HBA that does not support any
LPM states, so it seems a bit excessive to give a warning about it.

e.g. [PATCH 06/10] ata: ahci: Disable DIPM if host lacks support
was only a at_port_dbg().


Or, if you really want to keep this warning, then perhaps we should move this
if-statement
(and the ap->pflags & ATA_PFLAG_EXTERNAL if-statement)
below the

update_policy:

label

And change it to:

if (policy != ATA_LPM_MAX_POWER &&
   (ap->host->flags & ATA_HOST_NO_PART) &&
   (ap->host->flags & ATA_HOST_NO_SSC) &&
   (ap->host->flags & ATA_HOST_NO_DEVSLP)) {


(and add the same policy != ATA_LPM_MAX_POWER &&
guard to the ap->pflags & ATA_PFLAG_EXTERNAL if-statement)

But I think that I prefer to just keep it as ata_port_dbg().


Kind regards,
Niklas
