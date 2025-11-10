Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F23A2FCC12
	for <linux-ide@vger.kernel.org>; Mon, 10 Nov 2025 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780282; cv=none; b=Mydz7RKLJ8ySTCQuq/cOJlgDZEj1Sh7JEb42KHRaopnB2xt/tHBTvonxDPqdv4FQKklrLVe3BplV700bfMcddeCbw0uGVBsiYXfYPJ75Ijl1Hjp1QDd30Fe2KGBF2kYuHoFFHVBsyn+ZKPrsS0IMOwvUFzHfl1RPT9u5MjYii3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780282; c=relaxed/simple;
	bh=g3am2ReR6DyB5DiKFT3//FiPS+woKcoZOc46rQ6rerg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smybxz6REFbvPJUxnu2d0R6noTA1pwDgCL1tQTxwvqN0IeQ89FvBIkRhu9+A+NmWGQUcstOijlimSPqGuKh8A6IVCIqWnLLGD5tuDzcRhs+7A5udTUffiI0/SiYQedXO4l81ffU6t6ONW5T+HwtlZtsRJ9c0Uwvvp2FALTwckqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paKkFBQ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paKkFBQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE03C116B1;
	Mon, 10 Nov 2025 13:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762780281;
	bh=g3am2ReR6DyB5DiKFT3//FiPS+woKcoZOc46rQ6rerg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=paKkFBQ/3j4rzAKDbwv5Z/elOM5rrCX4irZo+ojYfg2MbRQxS9+T38pBkX/m/ChL4
	 vp4oii0RMJ9rPzeLe2xU/3IUdC2I2LT9JyDzJC9bCHyuYPg5rn6zYAuptS2a8b++sI
	 lwsHha0y2y9ElTfhqxtN1X9DTqSmBDK0ZH6ugIJUjP46avv7ggPIF6V0uxNieKAsH+
	 ZNlmSkaflRbLHPRFXA32nvCqBpb/xLA7H9DbSRJHgYTuKDp0ZrEh3apd1ffbBeX4yR
	 odnVtPJt3RacZb1J/O19pxsz71o4Xlq+9oPUhtSdW+gyhOPrmGcRm5j7Tse+E47Eyv
	 nzEY0UiHpum/g==
Date: Mon, 10 Nov 2025 14:11:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-ide <linux-ide@vger.kernel.org>
Subject: Re: ata timeout exceptions
Message-ID: <aRHkdW6q94QVylVX@ryzen>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <aRD8OoDwE2fyP_JM@ryzen>
 <1d86c6d3-a944-422a-9b96-7a768d7e89d8@eyal.emu.id.au>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d86c6d3-a944-422a-9b96-7a768d7e89d8@eyal.emu.id.au>

On Mon, Nov 10, 2025 at 09:41:29AM +1100, Eyal Lebedinsky wrote:
> > > 2) Why do I get only one command_timeout counted (originally, with ncq active) and none when ncq is disabled?
> > 
> > You are right that even if it is only a single command that times out,
> > the whole queue will be drained and retried.
> > (Because we always do a hard reset after a command timeout.)
> > 
> > command_timeout is most likely increased only by one because it was
> > only a single command that timed out. (The other commands might have
> > been queued but were never executed/finished.)
> > 
> > I have no idea why a command timeout, when NCQ has been disabled,
> > does not increase the command_timeout counter. My expectation would
> > have been for the counter to still be increased by one.
> This is an older SMA disk, and I will not be surprised if the disk was not even executing the command yet
> but was doing some housekeeping when it was reset. After raising the timeout 30s to 180s I still had one
> case where a reset was invoked. I see (iostat was running) that there was no activity on the disk that whole time.
> 
> Or maybe it is just a fw bug in the disk (ST8000AS0002-1NA17Z from 2016)?
> Is it possible that a reset when a command is pending is not counted in the smart log?
> 
> Interestingly, after repeated consecutive resets the link speed was downshifted 6.0->3.0->1.5g.
> Now it boots at 3.0g when it used to always boot at 6.0g.
> There must be a real issue there which is why the disk will be replaced anyway.
> 
> Regardless, I now have a better understanding of the i/o path.

I'm not sure how the command_timeout counter in the smart log works.

But from the Linux driver perspective, if an I/O has not completed within the
timeout, we will reset the controller, and retry the outstanding commands.

This timeout is defined by Linux, and is by default 30 seconds, like you
mentioned.

Not sure how the drive FW counts a command_timeout, but it is possible that
this internal counter has a timeout that is different from 30 seconds.

For AHCI, performing a hardreset is done by writing a register, so it is not
actually a command that is sent down to the drive. (For a softreset on the
other hand, a command is actually sent down to the drive.)


Kind regards,
Niklas
