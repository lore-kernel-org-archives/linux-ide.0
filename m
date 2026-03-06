Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E492E2DDD
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758780; cv=none; b=TiVgRUSBRlbsvKP3ciU5Y7YVFiICLnTAoI5EpwpOJYk0A7RZ05TBFQKNy3IiyWBV0Bo85e7LxPu5NAlnu2BLrE6VXZdzpsPpsRUkp7wG6xEwNDkErl7T+/GcJ1P/rdEDRHG3JFdoyxyR68E9+CXBnsn7DkwDpYBtiTPGWU0MwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758780; c=relaxed/simple;
	bh=f8uwHz9Ep1lDnPiHEy1eQJlOMMQ6YgRZT7YRwQ+uKSM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gns3embJ75guDJbyuUQAsNmp66Kg4ZaPRRORK2k6hpQXVWK6gb9IV8Z60ovOl7Pl1hWYW1g4il+p5b3I4UxRGbDcLmybM4+5pziNMfRhCe7jAntJdTYGLHEHfMjn6xL8gDcOyeUtXRz2JuTZEIdwhx9G678zU0pQs0Ce807Ulx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbT01KCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbT01KCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073A3C116C6;
	Fri,  6 Mar 2026 00:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772758780;
	bh=f8uwHz9Ep1lDnPiHEy1eQJlOMMQ6YgRZT7YRwQ+uKSM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=AbT01KCIqTWIEAaNFj5iHFvxm/T2MyWTIxEOtG4sT4vpb76a/bYOwAJ7sPPr+z0/C
	 AnODo2LE+BD4jSi6aYkDicuMJvuP1zOw0+4+qtxnZysumN0mCfJbL6ixBLRnysCDud
	 jQh7k5r3d5U/W2hbCiDWrUWA/ZEZaqkOmKQ+sGJ6XdRKYFwrwf34VYDawFuG+5nGY+
	 tuTATSgVHjUX9x4h6n7EBp2S/JkGY0wXPSSVK7p6nTozVYJ3ExXas2lmxEL20dsTgG
	 UsCIWR9T6qhXyhErrzHp79HAqoTLN45vKHkW0vzDqVfuVSeu0QcL9kUCjLosnwDWvc
	 Nq7tsVjEF3gOQ==
Message-ID: <f04a275f-8c7d-4867-b5c6-464fdc69e22d@kernel.org>
Date: Fri, 6 Mar 2026 09:59:38 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
From: Damien Le Moal <dlemoal@kernel.org>
To: Niklas Cassel <cassel@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-ide@vger.kernel.org
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-2-dlemoal@kernel.org>
 <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
 <CFD23A2E-145E-4901-9160-72A91A5C3A9E@kernel.org>
 <dd7763d3-1822-404e-b763-ae25f68b21ae@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <dd7763d3-1822-404e-b763-ae25f68b21ae@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 09:11, Damien Le Moal wrote:
>>> Could this mistakenly intercept a command that completed normally after a
>>> SCSI timeout, returning a timeout error instead of success? Would this
>>> also incorrectly clear `ap->deferred_qc`, dropping the deferred command?
>>
>> I think the AI is partially wrong here.
>>
>> If you read the comment below it if (), we know that ap->deferred_qc is only
>> set until that command has been issued. So if it is set, that qc has not
>> been issued, so it can't have successfully completed.
> 
> The request for the qc/scsi command was started from the block layer perspective
> and so can still timeout. So this is all valid.
> 
> BUT ATA_MAX_QUEUE qc (last in the loop if there is no match) is the one reserved
> for internal commands issued from EH. Internal QCs do not go through the
> deferred issue path, so even without checking for the index when there is no
> match, we have:
>  - qc is still a valid pointer (the array of QCs is ATA_MAX_QUEUE + 1 sized)
>  - We can never have qc == ap->deferred_qc.

This second part of my comment is obviously wrong. I need more coffee :)

The first part stands: a deferred qc that has not been issued can timeout.

-- 
Damien Le Moal
Western Digital Research
