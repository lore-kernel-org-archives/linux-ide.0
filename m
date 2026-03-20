Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D133D4E2
	for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2026 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997799; cv=none; b=lXG7vXkxNaU0tzCmWSWL7LCW6aOoGxkYvjbfN7M5Xho5vv4SgwpndYlIZ2MFUZRBFnCBQnoY11m3951HLU4oZb73toBT3sKCq2DZxRcsvuxRt+IbsZNZC4zGInn6SMQ6mtBBp1R7poUB4ABwrzbHBtXkXNP1AqvavHIH1KzSLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997799; c=relaxed/simple;
	bh=yAyF/NDv3uWV2tPg4o4ZcCW0MHMVqn6Y3PvJ/LHUF9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KUkFL2Q4aXKfN1rMX5kAHVH31Zb0DUgZ/HSPQ80uH7F2IT3t/WfwnKSi+26BuUmtinrlyx8sGnNj5Qe1uXV4u1L02vqc+ecFpftS/sdng09+sg9ouqMI2uBohaCNbdhlDW7KpmkiyZT13MnuBKzkpu3kiWG5EfytrCehKo2oNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikn66okr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikn66okr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B274BC2BC9E;
	Fri, 20 Mar 2026 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773997798;
	bh=yAyF/NDv3uWV2tPg4o4ZcCW0MHMVqn6Y3PvJ/LHUF9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ikn66okr/Jw4OJeXVR7knrzUsbvj6XQuUuRdNWSA0iLfr1S3b3hBjyPdwvp0ii+C+
	 V3GRkBR4BwlXFNB+uuvKE7lzhJkJfkQThkT0b8B9CEzTUwOkXWvn/RwLBpgiFGzxPG
	 tg3g/XQmKRtdJdFEnfxg8mWVOTc4NiGbkGS2sSuqfvhhEwQ7/QsSYBAhhlEULjxoV+
	 dLyWYtUOFiKau+sSa0WlqDqGvdd4U10FJSIEgkZNHzSm50oRDgExIOLZkX2uhqJ4/A
	 1LiyjZiQIu7CPOcW/UjNCdZxSFwCkpnL38HulnTdFZpNyVPecHP+1OraegQ7QJo/II
	 FW8Uqe8TDxHlw==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20260320034801.529964-1-dlemoal@kernel.org>
References: <20260320034801.529964-1-dlemoal@kernel.org>
Subject: Re: [PATCH] ata: libata-scsi: report correct sense field pointer
 in ata_scsiop_maint_in()
Message-Id: <177399779745.24057.2693453401978790860.b4-ty@kernel.org>
Date: Fri, 20 Mar 2026 10:09:57 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 20 Mar 2026 12:48:01 +0900, Damien Le Moal wrote:
> Commit 4ab7bb976343 ("ata: libata-scsi: Refactor ata_scsiop_maint_in()")
> modified ata_scsiop_maint_in() to directly call
> ata_scsi_set_invalid_field() to set the field pointer of the sense data
> of a failed MAINTENANCE IN command. However, in the case of an invalid
> command format, the sense data field incorrectly indicates byte 1 of
> the CDB. Fix this to indicate byte 2 of the command.
> 
> [...]

Applied to libata/linux.git (for-7.0-fixes), thanks!

[1/1] ata: libata-scsi: report correct sense field pointer in ata_scsiop_maint_in()
      https://git.kernel.org/libata/linux/c/e6d7eba2

Kind regards,
Niklas

