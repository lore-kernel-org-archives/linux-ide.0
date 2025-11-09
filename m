Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BA26C3B6
	for <linux-ide@vger.kernel.org>; Sun,  9 Nov 2025 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762720830; cv=none; b=Jko7h6/uAGNn8XS51EtMAFJot039vRtiYBnrLIhmPPKQN0V9zFxP0Kb4IUmRkaH2Mh09qipcfAAJvkxOcl6r4uxb+edPyFEPJECx2FobuYkEZDPWmF2xNCJ2MXf4nGWc/eRTiAIVUWxALlyw2lV6q7uv3aK4Z0rYo1fNi+56oyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762720830; c=relaxed/simple;
	bh=8HYZbO/c0mrjlsMCmCs9DL1lw6hTPZMsotnpRBgJ5HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXmSlast9iMu4Gdv1XmsRJBbz3HoGdrAtywx6S4sc1BbcWrZur+54CT7OWfFPvcw5pDW/Ebxe0yLdYVptTSSDQf/6CNiJKLC9hGBxprr2x0kFLiInmyLO+4i9EDjFbwrKrs+xD9d9RdVGC/od19Ejfor7+As0ihFuXzqvRRDxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBQ9f4je; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBQ9f4je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3D8C4CEF7;
	Sun,  9 Nov 2025 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762720830;
	bh=8HYZbO/c0mrjlsMCmCs9DL1lw6hTPZMsotnpRBgJ5HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBQ9f4jeetPC9PAFjOJqKBZZWqYAIR5lL0jnt1Q5ff3Mi+Riw9cGll3myaRejFAih
	 j93sobF36hYrCQ0IaoyNZcTyy3IgKPNH9V3wD3GS9jFfcoYSLfFyzb3fOe/W2olNKJ
	 xtenw5heoPTxSa0Vf0CYm+Be8SswKCz//1X8+/8O2//AKEqegh3XbSUs0yn88BzF8E
	 5kzN+dyGZtdDk9uxSzCP5dOxZHZ1qHOBjbrNNgT3mfqVadXoJ/0OHMHlLbo5Ee2PM9
	 BBigNyaWhB4fFsnB/cR4M1fLso3WD7b+nFYDEIxLe7VF1eyEh53ErGqbLETjwuTZnw
	 hsC3cO0BBNt/w==
Date: Sun, 9 Nov 2025 21:40:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-ide <linux-ide@vger.kernel.org>
Subject: Re: ata timeout exceptions
Message-ID: <aRD8OoDwE2fyP_JM@ryzen>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>

Hello Eyal,

On Mon, Nov 03, 2025 at 03:13:34PM +1100, Eyal Lebedinsky wrote:
> 
> I want to understand what is going on:
> 
> 1) Why do I not see an I/O error and the writes to the disk (rsync) seem to complete?
>    Which layer absorbs the errors, hiding them from the application?

SCSI layer.

For a timed out command, libata will set DID_TIME_OUT:
https://github.com/torvalds/linux/blob/v6.18-rc4/drivers/ata/libata-eh.c#L652-L654

For most commands SCSI layer, SCSI will set cmd->allowed to sdkp->max_retries:
https://github.com/torvalds/linux/blob/v6.18-rc4/drivers/scsi/sd.c#L1411

which by default is 5:
https://github.com/torvalds/linux/blob/v6.18-rc4/drivers/scsi/sd.c#L3962

Thus, most commands will be retried up to 5 times:
https://github.com/torvalds/linux/blob/v6.18-rc4/drivers/scsi/scsi_error.c#L2225

Thus, the user will only see the I/O as an error if the command failed
6 times.

(Note that if the command returns sense data instead of timeout, depending on
the sense data returned, we might report an I/O error to the user immediately.


> 
> 2) Why do I get only one command_timeout counted (originally, with ncq active) and none when ncq is disabled?

You are right that even if it is only a single command that times out,
the whole queue will be drained and retried.
(Because we always do a hard reset after a command timeout.)

command_timeout is most likely increased only by one because it was
only a single command that timed out. (The other commands might have
been queued but were never executed/finished.)

I have no idea why a command timeout, when NCQ has been disabled,
does not increase the command_timeout counter. My expectation would
have been for the counter to still be increased by one.


Kind regards,
Niklas
