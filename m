Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB933064D
	for <linux-ide@vger.kernel.org>; Mon, 23 Mar 2026 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262195; cv=none; b=VYir4mVSF9CKbwbAWezs4QVnIKW4hXJFG+8TPd8g6adDrOaqdxBFIVeiNMNMeglfU+vO5vqp3Z1REAmWdt1TMDuwzFOXpCefG3fcjrqHhGrbFYJoeQhFyTPCCUH6WVaLYoErBsaIw0hLtzIY8BkkjGZyYHLstnQrjlodec0cts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262195; c=relaxed/simple;
	bh=85Z4MhYqL3aFsYz7DMmjjLx5M6FMOmtfi5fkmgA6bD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZnMghihbbrlRqEXZLaCP3ODggSHeqIns/REyEW7eTCLNnADQ16SvJwZsAK3l7fMoakm1SpCHP8AZ5MuDNWp0CEHByg5kVad+M1tWQbRDgoOUDqXQAqwPhSigOawL5r3MQLpcjNwV9si3O9mfx1gwKrH/+45h6zSLqVqy0lKPEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNDFN5Dz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNDFN5Dz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4732EC4CEF7;
	Mon, 23 Mar 2026 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774262195;
	bh=85Z4MhYqL3aFsYz7DMmjjLx5M6FMOmtfi5fkmgA6bD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TNDFN5DzDXD8JEJctpS6vgda2nF1A5lByjJAsthm7dTNTE0FKJaD4Kzm8Wh7hKK39
	 6xfIjRTc1uE5lg61bPuLOEGXLeq5uYVhfOcacUaprKtiArunDHfyuyNkLMFtFSZTD8
	 IVjbghmkBklQPTCtifADO9GrpD98ynslK511inXVcVs92nJxthojUcfNvpOhvzhqIh
	 YdLPtD80a14+QFMXz323sC7LLLeN5zGFtNLtXiP8AxFPw3XxpjIGlDQf5YXn80Rzo7
	 uBaV5xhR4cNW76euMc+6nV/ehBDCVWeMkmL7awA039He6qrGYsgKvDgM71QPuhhg/u
	 2oWLEzHcR3QrQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
In-Reply-To: <20260320105950.286341-2-cassel@kernel.org>
References: <20260320105950.286341-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-scsi: refactor ata_scsiop_maint_in()
Message-Id: <177426219300.612649.8257056526688786208.b4-ty@kernel.org>
Date: Mon, 23 Mar 2026 11:36:33 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 20 Mar 2026 11:59:51 +0100, Niklas Cassel wrote:
> ata_scsiop_maint_in() is currently quite confusing to read, because it
> currently only implements support for the service action REPORT SUPPORTED
> OPERATION CODES.
> 
> Thus, when this function is checking for "invalid command format", it is
> not very clear if it is an invalid command format for the MAINTENANCE IN
> command itself, or an invalid command format for the (currently one and
> only) service action/subcommand implemented for this command.
> 
> [...]

Applied to libata/linux.git (for-7.1), thanks!

[1/1] ata: libata-scsi: refactor ata_scsiop_maint_in()
      https://git.kernel.org/libata/linux/c/a6ac0af4

Kind regards,
Niklas

