Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F870830
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767316471; cv=none; b=TRYFG5+VLFp2XraQdJHDw8Tt9lhscUiO3JKHOCehi+mOFXRG0URneNZ/qDifNPgs01IWdFIdrQpv4RvN4lmHr+HD4FR3IE2RO2k8toIDyQRt6JL/6QfQqvkBEsQar0n3FCrJqyOZqsHR5g4u5OGe07iaO1Ui2fSO7uDIgPoJ3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767316471; c=relaxed/simple;
	bh=KMkhhZqnKJNPiqcAnT3vvev0RqIlqkwlOye9cBSnPx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOYAcYUzA4/Htrzf8+uXZaRelhfD2Jwh4NTDjNC6jvu2JMt/tQMsW22zwRffTWyV90iZ2WDnI8VcKcdoDxpqAowb+Brfdh9hYesjO54gl+o1wNG1hSy5fXMQcoM9JIh4bk96u4WOJ6jjzjOu2T9JRZt8tLPUtP2H3yNCOXURmWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzOtUw1x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzOtUw1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FE8C4CEF7;
	Fri,  2 Jan 2026 01:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767316470;
	bh=KMkhhZqnKJNPiqcAnT3vvev0RqIlqkwlOye9cBSnPx4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mzOtUw1x/74dGSRSvgxB7e9OeoolqV/0Q2RdajNSlZFqeKumBdnssfau1e0oC/4Jp
	 6lkO1BS4RcgB6KXAhRlLl1aqA3I1aPxNaZim6wkY+PTaAkURsWsd2lRZP186kMQOHM
	 iXIN8wQ6jbNNnnaPco+1M7fnzDs9iYJDhePs6kiu9SVciyyR0m/Myb/7lkPPRhFQz/
	 6gO9pUEfzmFeHOptcytE2eNCtIAXzk+neAJxQVGedKFPVZ2cjDZxIXEMQcdLqTgmKg
	 0TlF+z5z8YJEjIXsBEsqo3P33/aqIQOJPDeVxIC8/jrgXvL7FQtb/Vf4M3/Sjzn9Ck
	 KncjnOvZMDAkA==
Message-ID: <1b279430-e3e7-4712-9c21-c8d4da43d34a@kernel.org>
Date: Fri, 2 Jan 2026 10:14:29 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Prevent non-NCQ command starvation
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Xingui Yang <yangxingui@huawei.com>, John Garry <john.g.garry@oracle.com>
References: <20251220002140.148854-1-dlemoal@kernel.org>
 <aVT1QdEZq09kAjS-@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aVT1QdEZq09kAjS-@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/31/25 19:04, Niklas Cassel wrote:
> On Sat, Dec 20, 2025 at 09:21:38AM +0900, Damien Le Moal wrote:
>> This small patch series addresses potential command starvation issues
>> with non-NCQ passthrough commands issued to a device accessed through
> 
> Here and everywhere else:
> s/non-NCQ passthrough commands/non-NCQ commands/
> 
> The problem is really not related to passthrough commands,
> but rather the mix between NCQ and non-NCQ commands.
> 
> E.g. you can perform a ioctl with the REQ_OP_DISCARD command,
> for most ATA devices this is a SCSI WRITE SAME 16 CMD, which gets
> translated to either a NCQ or non-NCQ command depending on if the
> device supports NCQ encapsulated Data Set Management (DSM) commands,
> and specifically if the device has the QUEUED DATA SET MANAGEMENT
> SUPPORTS TRIM bit set or not, which is not a given.
> 
> TL;DR: the starvation problem is not directly tied to non-NCQ
> passthrough commands, but any command, even commands that goes via
> the block layer, that happens to be translated to a non-NCQ command.

Yep. I corrected that.


-- 
Damien Le Moal
Western Digital Research
