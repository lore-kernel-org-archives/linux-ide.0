Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20798346A06;
	Fri,  6 Mar 2026 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772768004; cv=none; b=SDHDVV8xU4V1ue17ivhGJnVZXhYdi2IbCXu2x7C8ZjUUEigAYBSDzAJ1pjLEwdyNlxUQei7uxq7iNXD5kMPoL84QdrETUlX6WEQUNtusNxS7qHP+rL1fr6Mgz6W8mNHS2qpwo4vR/W/roEiZRcMpxrTZrN0K1J1u0+5zUrKecOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772768004; c=relaxed/simple;
	bh=/+5eGCgzyEIhgaJAjdpZ9BQzbOFik0bPO7hv9ozzuRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhgLaUlx3La+L+MbmATX2P+Qy2Yf8n/9APTrB17vx/Brmzz6bOVuFG98gj1XnMdPuK9sZlvVTHRx2GLk+fzruRnw33bPfVla67elSElFcGqEtQBO7QQbIlCU80vWJ5eSNdpW7Gw5m7oxVPOSXCMqpkY/tl32fKwpBO7867DrCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL/8l80W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL/8l80W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16690C116C6;
	Fri,  6 Mar 2026 03:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772768003;
	bh=/+5eGCgzyEIhgaJAjdpZ9BQzbOFik0bPO7hv9ozzuRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oL/8l80W8HnI3Ym+dV53XM3AJW6x8p+df0AkZ/Gi4Nd2M6f7XRqSyjGYadtA62Jz2
	 Yk8lT84PI9jnkffB4oRk7hg2cuNcTP6I2gxYgCUe4+mxIFMDICLPnzsCA3sq6gwjNB
	 I/9L/PjCPywJvKwDz6Ob7UcSTGAOUF9eSffAaiqcH1VM1e4RMILN1Df8SpdkclJx5Y
	 HC08V2jT6Xnz8SIqUoySGLWCW2EH7/5MvWLYXQsRL9VkmUVCeZqzS9EcgRLUlptWjl
	 Y+8CTBwg55280MMOc0dLUXc/PbftEnuFZBdVLsKzSQlbNnPgIN/sRIkg9uB/HrQvno
	 phVHb7Mcx9nrg==
Message-ID: <58d258e3-c76e-41da-bb3b-7fa0cde9d8a8@kernel.org>
Date: Fri, 6 Mar 2026 12:33:21 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-eh: Fix detection of deferred qc timeouts
To: Guenter Roeck <linux@roeck-us.net>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260306024805.2877513-1-linux@roeck-us.net>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260306024805.2877513-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 11:48, Guenter Roeck wrote:
> If the `ata_qc_for_each_raw()` loop finishes without finding a matching
> `scmd`, `qc` will hold a pointer to the last element examined, which is
> accociated with `i == ATA_MAX_QUEUE - 1`. This element can match
> `ap->deferred_qc`. If that happens, the condition `qc == ap->deferred_qc`
> evaluates to true despite the loop not breaking on a scmd match.
> In that case, the error handler mistakenly intercepts a command that
> completed normally after an unrelated SCSI timeout, returning a timeout
> error instead of success.
> 
> Fix the problem by checking for i < ATA_MAX_QUEUE in addition to
> qc == ap->deferred_qc.
> 
> The problem was found by an experimental code review agent based on
> gemini-3.1-pro while reviewing backports into v6.18.y.

Please remove all the quotes:

If the ata_qc_for_each_raw() loop finishes without finding a matching SCSI
command for any QC, the variable qc will hold a pointer to the last element
examined, which has the tag i == ATA_MAX_QUEUE - 1. This qc can match the port
deferred QC (ap->deferred_qc).

If that happens, the condition qc == ap->deferred_qc evaluates to true despite
the loop not breaking with a match on the SCSI command for this QC. In that
case, the error handler mistakenly intercepts a command that not completed yet
and that has not timed out, and thus erroneously returning a timeout error.

Fix the problem by checking for i < ATA_MAX_QUEUE in addition to
qc == ap->deferred_qc.

The problem was found by an experimental code review agent based on
gemini-3.1-pro while reviewing backports into v6.18.y.

> Assisted-by: Gemini:gemini-3.1-pro
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Fixes: eddb98ad9364 ("ata: libata-eh: correctly handle deferred qc timeouts")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

With the above, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Thanks !

-- 
Damien Le Moal
Western Digital Research
