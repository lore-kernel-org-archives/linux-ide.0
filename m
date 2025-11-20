Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85142824A3
	for <linux-ide@vger.kernel.org>; Thu, 20 Nov 2025 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763641093; cv=none; b=chxKJI0RloZosfXHbLjx0bZoQT0kTrDf3ooRIdTP840Zs8ABqHVkaVP+LMtIdqgI8w/BChnh/3L1jxGYI3OAKvC+CNVLv4L+TJabpjqxVK6WRTKwuHlhFNBeXRHRBKlLo7DGc3vcmaIV3BJFPekWEn+slOiF4Lfuiu8qbsR3Qmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763641093; c=relaxed/simple;
	bh=C8TrmpYAhT1SDh/y2/yEiKb/wjMrTIGPv6qHbYvZk/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFBdoBuMFkkRHuhCcbqvCI/+FUF62Pnp6l6jvb5fn0D0vJkfpLYUzlXe6aw52GosJRW0ADSs+kHjbbXh01IZH6oIae9IyUl4mEeWX8XdGoADJsAcanlE/1pvOnEhyRyRqViWi7dW40OaOJR5Yeb/DUwUK2GmyE7Y12UaKG3aP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjAcomUZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjAcomUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8356CC4CEF1;
	Thu, 20 Nov 2025 12:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763641090;
	bh=C8TrmpYAhT1SDh/y2/yEiKb/wjMrTIGPv6qHbYvZk/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RjAcomUZdVUojE5oHqEpPWPPtto4Hxz4tub/KqWG78iZ8JRxNsj7m5KQePwRUPo3V
	 HYME3iap4LsUEamz1mUaEZ8zSdYuc0E8qidg21LRSC+D8Upq8Gy82/pj/tv9JLXhIb
	 d8xdYkDgMOmd8Tesg2RQ4nu82st1eHEKrZMqsbi2zSp8ECA8bPzLhQZiFUVYPKWHUE
	 UHkvLI7CrXy5unzpWZhN2gSE9R27TClNd+rVZnC80QduR0p9ytpS5EEBBbdzGYoVt5
	 SwqBDLeB2tdlkqnRl54FR8wXsM2u3cAhAEos31Q4Jp7Xzg1wWbQeRbiSpqOnkUsoQS
	 xgbbwieEtKsQA==
Message-ID: <df236b8e-f514-4139-a4a4-1ebf5df9b22b@kernel.org>
Date: Thu, 20 Nov 2025 21:18:08 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ata timeout exceptions
To: eyal@eyal.emu.id.au, Niklas Cassel <cassel@kernel.org>
Cc: list linux-ide <linux-ide@vger.kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <4f0fa70c-b259-4998-bf94-c6c6fd8c733c@eyal.emu.id.au>
 <aRyOFRCQ_nSWtmsh@ryzen>
 <f8eebba8-176b-44b8-877c-75de8b00db38@eyal.emu.id.au>
 <7cf8b035-c884-4691-a35b-ee8a2e149e03@kernel.org>
 <5f690ea7-5e10-4129-87be-ba4b618e65b8@eyal.emu.id.au>
 <3accb08b-73bd-4281-9cad-069f512c7f9c@kernel.org>
 <4f30c170-e5c8-4961-94a7-d903acdb9633@eyal.emu.id.au>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4f30c170-e5c8-4961-94a7-d903acdb9633@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 20:38, Eyal Lebedinsky wrote:
>> Ah ! This is a drive-managed SMR drive ? I missed that point. Yeah, with these
>> drives, the performance profile (throughpu & command latency) can be all over
>> the place depending on the internal state of the drive. So all bets are off in
>> terms of timeout... In your case, this seems extreme though, so there is likely
>> a head going bad and lots of internal retries going on that make latency even
>> worse than usual. Maybe have a look at SMART output to see if you lots of bad
>> sectors remapped ?
> 
> Nothing bad in smart report.
> 
> Another positive: After setting a lower max_sectors_kb as suggested, the drive is
> running smoothly. I also added --fsync to the rsync which probably also regulated
> the pace a bit.
> 
> So far today there was no reset required, and also no pause at all.
> 
> Maybe after the disk was used for a long while, and as a large amount of data was
> replaced regularly, the data is now distributed wildly.
> 
> Is there an equivalent to 'trim' that can be used to tell the drive what blocks
> can be discarded (and reused)? If so, worth a try?

If you drive shows a non-zero value for:

cat /sys/block/sdX/queue/discard_max_hw_bytes

then you can run fstrim against the FS on the drive to trim (discard) the unused
blocks. If the value is zero, then the drive does not support discard/trim.

-- 
Damien Le Moal
Western Digital Research
