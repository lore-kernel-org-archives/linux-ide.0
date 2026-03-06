Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ECA371050
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785423; cv=none; b=G4NDmQdGvpLd1SVE0uL4CiSQvpopy4vcARS4+vzJXeKTJlx7kPxb0KOQDgujAa00+lXQIxvNMuij6xCeJnBHIvyh61wE8zLkV1q0yY1PCgHC81xJeqriN2D9u/i5JguZALF+n/bCKbbxrTAWnMMhZ+oR2wM3ujQmpAkMwjiqe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785423; c=relaxed/simple;
	bh=oSdMXNHFWFTjs7eA2ZZWssIagt7xltWEI8r/SNpcS8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3NC7E4Cb/JcRSjekn3aH7RBgeacZozuRP6FpttScmaNarKWyUp91+cO7vzklOUyfdKpJDu7ZRi7mP1OC3Ava45YDr0Ji4llufs6QZ53fJzAEN5wE9+iIAlMqwTwTSsOxotW/INjXMpCcDaTqVfuY3Oy6B1Aqr6ybPcYqcn3odE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4FHexeK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4FHexeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE49C4CEF7;
	Fri,  6 Mar 2026 08:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772785422;
	bh=oSdMXNHFWFTjs7eA2ZZWssIagt7xltWEI8r/SNpcS8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4FHexeKNWunuT6ZT7PQgA/pB/6Set/NGrn/lNbHxM6HSPjVsUkKFsI4+CK6IQAma
	 bZs9iXqEGWL24l3jGVbHz3eHRiNXI6B4i2++UO/eg3XYjV4IB5ZuBp2ljZVjhgML6u
	 5fLlFMh3xmNxfLcjlzR/z8tjUcHD4aGtI8F0TH0u5i0NF65xBaejdpYDrogsKfOxyX
	 ZWco11jHX5d3xUAuR8XZEwhdrGqVGVYBHPHTJAhjJAXf8WGbMunp3v1QY3VzHX9Haf
	 oVSOnDEwxkPwahS3hyC5HPnCxqDYRbFZtf/UBWFQLkkswZpQTrJQKvotlPkxwEmplG
	 cxZvJbQVQbd1A==
Date: Fri, 6 Mar 2026 09:23:39 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
Message-ID: <aaqPC3IzGKVA1WBl@ryzen>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-2-dlemoal@kernel.org>
 <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
 <CFD23A2E-145E-4901-9160-72A91A5C3A9E@kernel.org>
 <dd7763d3-1822-404e-b763-ae25f68b21ae@kernel.org>
 <f04a275f-8c7d-4867-b5c6-464fdc69e22d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f04a275f-8c7d-4867-b5c6-464fdc69e22d@kernel.org>

On Fri, Mar 06, 2026 at 09:59:38AM +0900, Damien Le Moal wrote:
> On 3/6/26 09:11, Damien Le Moal wrote:
> >>> Could this mistakenly intercept a command that completed normally after a
> >>> SCSI timeout, returning a timeout error instead of success? Would this
> >>> also incorrectly clear `ap->deferred_qc`, dropping the deferred command?
> >>
> >> I think the AI is partially wrong here.
> >>
> >> If you read the comment below it if (), we know that ap->deferred_qc is only
> >> set until that command has been issued. So if it is set, that qc has not
> >> been issued, so it can't have successfully completed.
> > 
> > The request for the qc/scsi command was started from the block layer perspective
> > and so can still timeout. So this is all valid.
> > 
> > BUT ATA_MAX_QUEUE qc (last in the loop if there is no match) is the one reserved
> > for internal commands issued from EH. Internal QCs do not go through the
> > deferred issue path, so even without checking for the index when there is no
> > match, we have:
> >  - qc is still a valid pointer (the array of QCs is ATA_MAX_QUEUE + 1 sized)
> >  - We can never have qc == ap->deferred_qc.
> 
> This second part of my comment is obviously wrong. I need more coffee :)
> 
> The first part stands: a deferred qc that has not been issued can timeout.

Yes, did someone claim otherwise?


Kind regards,
Niklas
