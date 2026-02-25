Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088D28850E
	for <linux-ide@vger.kernel.org>; Wed, 25 Feb 2026 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772000564; cv=none; b=ZJ2+3U3Y02W+E6x391aGJE6LNAKTyPbf3qIaxjpiwSgc+ubo6Y0dP1Z9P7RL59i3p67jvq1tNg5dU2j4vwUp09x52LsbwEjBO7bSe9D6H0P2Ye1c3J9KRepnAoYyldKhDMil8G7kWdKxFp1vrUVc0OTlAh2V3wpQcSl+fARPjf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772000564; c=relaxed/simple;
	bh=YgMD+5q1azk+rD//FXva/i5l7KLUMr0LUlkzsB9plVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGEkt5G80zHvYzheDyF6TBffq7mIONlAV1s2wqJP6fz3+Cye6kqkTm0xsyXcNiGu1Ukcm3I8nQz9iJerKwdfWFe0kHczBXRjAm7BRQ2aQaPjBdylcvQdT0zfbAJhuTjgsvAKS8fAek5NHC0ob0zT9L+SKYgspuqODHCCA2ut+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmYfUAcK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmYfUAcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C261FC116D0;
	Wed, 25 Feb 2026 06:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772000564;
	bh=YgMD+5q1azk+rD//FXva/i5l7KLUMr0LUlkzsB9plVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmYfUAcKte6DhLFGuE294jp1mVrfe4SBbUVUWCfoV+lP4a4bo6mmx4Kas0nNz2k4p
	 gCQ6akRxvN6FzYqc2oYViGemBGtrk1016AD5tnWbTKOgov4F/iGln1uMd4XIqZDR9S
	 NAm/TWASjyHYPPWSJu/NJJn79W3eXMtATJVNiFOZoUGdCs22zka+AuCJ3252UcCaC5
	 H3nnPgfbrlceYiSYSvtQjcIKusYcs7Y6l6Yu/cGVyd5u1t4PPjAedc/N4BaCnegZ2E
	 T97M1vbMltpSEaRZTu4Vsq2Vx8i50lYW8tEk7cDRBz68BWS77WPGHkjuKVfK+QVLSY
	 iDJDQQwujS+Ng==
Date: Wed, 25 Feb 2026 07:22:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: avoid unnecessary calls to
 ata_scsi_port_error_handler()
Message-ID: <aZ6VKXgj2sNPTOu4@ryzen>
References: <20260224020638.1194842-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224020638.1194842-1-dlemoal@kernel.org>

On Tue, Feb 24, 2026 at 11:06:38AM +0900, Damien Le Moal wrote:
> When handling SCSI command timeouts, if we had no actual command
> timeouts (either because the command was a deferred qc or the completion
> path won the race with ata_scsi_cmd_error_handler()), we do not need to
> go through a port error handling, as there was in fact no errors at all.
> 
> Modify ata_scsi_cmd_error_handler() to return the number of commands
> that timed out and use this return value in ata_scsi_error() to call
> ata_scsi_port_error_handler() only if we had command timeouts, or if
> the port EH has already been scheduled due to failed commands.
> Otherwise, simply call scsi_eh_flush_done_q() to finish the completed
> commands without running the full port error handling.
> 
> 

Applied to libata/linux.git (for-7.1), thanks!

[1/1] ata: libata-eh: avoid unnecessary calls to ata_scsi_port_error_handler()
      https://git.kernel.org/libata/linux/c/46a9d970

Kind regards,
Niklas
