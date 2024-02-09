Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D163FDF
	for <linux-ide@vger.kernel.org>; Fri,  9 Feb 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472866; cv=none; b=c/4lVI5RFz8tCZ0MJDozaDTByQh/7aaV8rqPWCVzyke3t3rbgkx6DgT8nVat0JwhdJrFfa83zyyXqpJMqpLimNL2RHkeKynDbOHoNmsOuy8yZE+CcM2+0MDZYcOeEg4flwugZs5LWonPD5b1dl98uNqOaSSd/5EvcA39CNbj3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472866; c=relaxed/simple;
	bh=HBb/n7wFCGhHsPAMUpLVnirehASy6pKs2PvblM1JVo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2Jd5wJoqYnE3jQocwvDhSZcTQGS0su5yhh9JaExeMzz0Nr6Eu7M+NX5Z4YtD5Zh3ZuCffARs4Y3FvwHlMzgDcTpojm1xQ+BoPysIpPEkpGDUT5Xs2VgT6UDY/lzHB8NHhd/viCDetH2kYCezQxl7dPxMbqXczBJzS/5twU066s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/9+roGk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/9+roGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781EBC433C7;
	Fri,  9 Feb 2024 10:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707472866;
	bh=HBb/n7wFCGhHsPAMUpLVnirehASy6pKs2PvblM1JVo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/9+roGkWT2UUvNWDxJb1UTGW+LVW8+eDXT1qNAb/sznxd2r06bvjFa0DHwfd93z4
	 zPxql4qbHY3dLXX6gSfoU+a2M0FFd/L56EvGvQw06uXiMycwOMvnoE+DaUFAf9Dyfs
	 MEwkw6zJ8x6vxCixMZ2UY3MXBkUqFI4P1FhpL3bzeDF4rJ7alNbBGasaNBUeXjOQ/F
	 pBdrk7aaiIw9DZPDsm4bdxpU5EfgTsw0GenUmoRxv7a5Qn3vNBSVs4/sXdyZd4fn/k
	 JGHi3tLjdL2WGDzQFrU1wdIqk+Wgk7Go7PsQpC1SQgmlxDfGN/OurSvc+Pf8vKWb2F
	 4Gh2lUCYypBtw==
Date: Fri, 9 Feb 2024 11:01:00 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 0/5] drop low power policy board type
Message-ID: <ZcX33BLsEnDGez0z@x1-carbon>
References: <20240206211352.1664816-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206211352.1664816-1-cassel@kernel.org>

On Tue, Feb 06, 2024 at 10:13:41PM +0100, Niklas Cassel wrote:
> The series is based on top of:
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-next
> 
> 
> Hello all,
> 
> This revives a patch sent out almost two years ago from Mario Limonciello:
> https://lore.kernel.org/linux-ide/20220524170508.563-1-mario.limonciello@amd.com/T/#u
> 
> The reason why we did not merge it back then, is because LPM and hotplug
> events are mutually exclusive.
> 
> The difference with this series compared to what was sent out back then:
> I've added a patch that checks if the port is external, i.e. either
> hotplug capable or eSATA. For external ports, we never enable LPM, as
> that will break hotplug.
> 
> For ports that do not advertise themselves as external (typically laptops),
> we set the LPM policy as requested.
> 
> This matches how Microsoft Windows does things, see:
> https://studylib.net/doc/10034428/esata---microsoft-center
> 
> Thanks to Werner Fischer for suggesting something like this at last year's
> ALPSS conference.
> 
> There might of course be some platform firmware that e.g. incorrectly marks
> its port as internal, even though it is external, but if we find any such
> platforms we will need to deal with them using quirks.
> 
> 
> Also note that we even if the user requested a certain policy, there is
> no guarantee that he will get all the features for that policy, see:
> https://github.com/torvalds/linux/blob/master/drivers/ata/libata-sata.c#L403-L414
> 
> However, I'd rather we not try to map all the combinations of
> partial/slumber/devsleep in to a single policy represented by a single
> integer, thus I do not try to "change" the requested policy.
> The user will get all the features that are included in the requested
> policy AND supported by the HBA.
> 
> Another difference (compared to an earlier version of Mario's series)
> is that we do not try to change the default CONFIG_SATA_MOBILE_LPM_POLICY
> value from 0 to 3, it will continue to be 0.
> If you really don't want LPM even if your HBA supports it, and your port
> is internal, one option is to leave the Kconfig set to the default value.
> 
> Damien: considering that the Intel VMD + ahci_intel_pcs_quirk() bug turned
> out to have nothing to do with LPM, it was simply the fact that the
> ahci_intel_pcs_quirk() was only applied if there was an explicit entry in
> ahci_pci_tbl. So since that bug is totally unrelated to LPM, I no longer
> think that this series need to wait for a fix for that bug.
> 
> 
> Link to v1:
> https://lore.kernel.org/linux-ide/20240201161507.1147521-1-cassel@kernel.org/
> 
> Changes since v1:
> -Picked up tags from Damien.
> -Moved the comment in front of ahci_mark_external_port() to inside the
>  function.
> -Modified the comment in patch 4/5 to more clearly state hotplug removal
>  events.
> -Rewrote the commit message for patch 4/5 to be more detailed.
> 
> 
> Kind regards,
> Niklas
> 
> 
> Mario Limonciello (1):
>   ata: ahci: Drop low power policy board type
> 
> Niklas Cassel (4):
>   ata: ahci: move marking of external port earlier
>   ata: ahci: a hotplug capable port is an external port
>   ata: ahci: drop hpriv param from ahci_update_initial_lpm_policy()
>   ata: ahci: do not enable LPM on external ports
> 
>  drivers/ata/Kconfig   |   5 +-
>  drivers/ata/ahci.c    | 135 +++++++++++++++++++++++-------------------
>  drivers/ata/ahci.h    |   9 +--
>  drivers/ata/libahci.c |   7 ---
>  4 files changed, 78 insertions(+), 78 deletions(-)
> 
> -- 
> 2.43.0
> 

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.9
