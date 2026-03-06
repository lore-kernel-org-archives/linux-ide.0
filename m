Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD337754C;
	Fri,  6 Mar 2026 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786221; cv=none; b=JEjnPqUXCptXHCscWw3JNpy2Ax4lugc83EXIdUNdr72nivaVFE3Do+aFTNovmWmXsYWdUAGkzjUPecBGds3ObFDjFRU28u97xJCbh5V9NattnyFqlpmUeZimLaPJde6l1D0dKx2s2Zhuns19LT0mULoewIZ0g7au0oMlIACH2pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786221; c=relaxed/simple;
	bh=vBMsJByLpgZ6jKtk30Li3vAaQYsInfogu6yuuOHAxXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjB3S30rvFSCqlhdwbKC0yFWp+CE171rUvnz/vTGB9IhDz/FpW3lFgDKur7VF3U2UjGUBKR4ZDgl+fdZ1AjuydsJzaA1t4hz7UWmvKRkmiQEsbZVxBtuQR2g3lFQPbfInq4rXi+fokQut0Oswx8HBrbJB9RycAx1fOhmvokPoTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+YJhbj9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+YJhbj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CD5C4CEF7;
	Fri,  6 Mar 2026 08:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772786221;
	bh=vBMsJByLpgZ6jKtk30Li3vAaQYsInfogu6yuuOHAxXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+YJhbj90Wsx5W1SrqPgAOTX73hlDo5F7EFXai86L/+T13FmobxDQfbfI1PL5K4Mv
	 dQG4J7AuRuMQslJmBwkoos5wfvXKKEZUrqykQaSYXOsX4egTnWOZYxXFil2N2k4pOd
	 ckssH0CD23y31LHytQzRMVk1bbA+YQAb9QC4utbfCKgbu5wIgRNw4lTlROEBlYQohO
	 aGVVN4qoWfdmA9D0xatPzyQOffSKIutVfhTqr6eqMi1eD/RQ2frfRb8gN0kwbBLMwZ
	 cCxdC5wuqAOnjceqLN5Wm9VVMJtL+6p1LWighzczZwD5dUY/BAe75yWpoHzcrWJEo/
	 L+GMxD74xWwYg==
Date: Fri, 6 Mar 2026 09:36:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: Fix detection of deferred qc timeouts
Message-ID: <aaqSKaxrA7QKmZi7@ryzen>
References: <20260306024805.2877513-1-linux@roeck-us.net>
 <58d258e3-c76e-41da-bb3b-7fa0cde9d8a8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d258e3-c76e-41da-bb3b-7fa0cde9d8a8@kernel.org>

On Fri, Mar 06, 2026 at 12:33:21PM +0900, Damien Le Moal wrote:
> On 3/6/26 11:48, Guenter Roeck wrote:
> > If the `ata_qc_for_each_raw()` loop finishes without finding a matching
> > `scmd`, `qc` will hold a pointer to the last element examined, which is
> > accociated with `i == ATA_MAX_QUEUE - 1`. This element can match
> > `ap->deferred_qc`. If that happens, the condition `qc == ap->deferred_qc`
> > evaluates to true despite the loop not breaking on a scmd match.
> > In that case, the error handler mistakenly intercepts a command that
> > completed normally after an unrelated SCSI timeout, returning a timeout
> > error instead of success.
> > 
> > Fix the problem by checking for i < ATA_MAX_QUEUE in addition to
> > qc == ap->deferred_qc.
> > 
> > The problem was found by an experimental code review agent based on
> > gemini-3.1-pro while reviewing backports into v6.18.y.
> 
> Please remove all the quotes:
> 
> If the ata_qc_for_each_raw() loop finishes without finding a matching SCSI
> command for any QC, the variable qc will hold a pointer to the last element
> examined, which has the tag i == ATA_MAX_QUEUE - 1. This qc can match the port
> deferred QC (ap->deferred_qc).
> 
> If that happens, the condition qc == ap->deferred_qc evaluates to true despite
> the loop not breaking with a match on the SCSI command for this QC. In that
> case, the error handler mistakenly intercepts a command that not completed yet

Could even write:
"that has not been issued yet"

(while it is true that it has not been completed yet, it has not even been
issued to the drive yet.)


> and that has not timed out, and thus erroneously returning a timeout error.
> 
> Fix the problem by checking for i < ATA_MAX_QUEUE in addition to
> qc == ap->deferred_qc.
> 
> The problem was found by an experimental code review agent based on
> gemini-3.1-pro while reviewing backports into v6.18.y.
> 
> > Assisted-by: Gemini:gemini-3.1-pro
> > Cc: Damien Le Moal <dlemoal@kernel.org>
> > Cc: Niklas Cassel <cassel@kernel.org>
> > Fixes: eddb98ad9364 ("ata: libata-eh: correctly handle deferred qc timeouts")
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> With the above, feel free to add:
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Thanks !
> 
> -- 
> Damien Le Moal
> Western Digital Research
