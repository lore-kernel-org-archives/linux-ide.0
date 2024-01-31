Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3378B6D
	for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701755; cv=none; b=Xoufh7Qqq/5UzBKi12Z+BsYs81l4BX5Bpz2fpDinmn1CeSgqOPG5NVo/43WzUpThQvYSkUbRjLJrIsmkCiBHllDmpkrs0rH2DuzQWKWsAGdbDUGQP4QikwjOkNDOUr8zxdJzoJsWgINE7N6+3AhNbvI71p6Hw836JN6X6Qx6WMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701755; c=relaxed/simple;
	bh=gC9YKnmkUnfdLduxmOFP8qj6blKCMcayz9kUGRub37Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQZfHzoRdeaOH36Udo9omT/9XAJRmNayKOP43QrZJ7PL4Jp8LjD/KGSe5BZSNZoZ2AN6URAvx/HoJ5TPmIXb4Xcu9SmuUQE1oCePT/blgv1JWoRDJyrCMQPuI6Y6xWk0eDQph2Drd20bp0AgQADw/hfbhGtUeQfH8ukeQ06jv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3Teh9/e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3Teh9/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284FAC43390;
	Wed, 31 Jan 2024 11:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706701755;
	bh=gC9YKnmkUnfdLduxmOFP8qj6blKCMcayz9kUGRub37Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3Teh9/eZVFSYyAbAH7kln77xkeDe4Z3Mgnfj8UR+F8OkropCJSP6xdMFbOvwfMR2
	 OS6lAarSLANcHTJGkEmcvexk4JS8WYW3q/PgbOYG7K50peg8RKjzN3TTuovTFYKkry
	 lGZuEtH6l4Dr48haTkMKtxkMCzj4048wmgt5J/lnXrr09oleMaN1NfUxYc7mUP0ZbC
	 N6S84QejMoQAV/q5H08RSBbn4TmDNJaYwYVslclY9JskgyJuQeQoOqTUYlg12IaW9q
	 L0N2aHzLz2Qdi+S0puUTkr35bXpD14n4KU5qWk/7zqMXqqz+S64E3flFh/X55ijZDk
	 VxVM4zIQcINDg==
Date: Wed, 31 Jan 2024 12:49:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Dieter Mummenschanz <dmummenschanz@web.de>, linux-ide@vger.kernel.org
Subject: Re: Aw: Re: Re: [PATCH 0/2] Power management fixes
Message-ID: <ZboztvrqKKdLQ1mt@x1-carbon>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
 <345be856-8959-4148-bcae-00b3fbcd0d08@kernel.org>
 <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
 <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
 <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
 <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>

On Wed, Jan 31, 2024 at 04:38:28PM +0900, Damien Le Moal wrote:
> On 1/31/24 16:29, Dieter Mummenschanz wrote:
> > Damien,
> > so I've applied the patch to 6.8-rc2. Interesting thing is that the behaviour is 
> > exactly the same as before (w/o the patch). Besides not 
> > honoring CONFIG_SATA_MOBILE_LPM_POLICY=3 after boot my system refuses to 
> > transition into lower power states > pc2 after resume even after letting it sit 
> > idle for 10 minutes. Transition is only reached after issuing hdparm -Y. So if 
> > the patch restores the original behaviour then why did it stop working?!

Hello Dieter,

Just to confirm,
while testing Damien's patch on top of 6.8-rc2,
did you still do:

for foo in /sys/class/scsi_host/host*/link_power_management_policy;
  do echo med_power_with_dipm > $foo;
done

It should be needed until we add (or modify the existing entry, if any)
your PCI vendor and device id to use "board_ahci_low_power" instead of
"board_ahci", see e.g.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata/ahci.c?id=b8b8b4e0c052b2c06e1c4820a8001f4e0f77900f


Kind regards,
Niklas
