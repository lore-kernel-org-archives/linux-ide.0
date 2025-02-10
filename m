Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A974690
	for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2025 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207804; cv=none; b=XdcRMZeGIO8uAiR37EzAHrc1zCUzk6f95YQZmj31zr5w6kFC/ftX+DHFlLmiiM/4/iYksp/c0pgBtWWHl44X/ZGihsmUUjoaV9tkfstGxd4eOmJRnMpQgk8b0QneJPqfhrCqUrlpCJ4UIRMcfjtWCUznDJEEy5yVqlLL7eRrZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207804; c=relaxed/simple;
	bh=MN6TgmmHIKWaTO9moHMH8UTMOCTYrsHBlf8eHAyQP8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h137nuAKGvqM2ce2gq0SrdEs5okYEBReICs+lsBUhEF92xqmoS+PmH8cHnMBQnmxdG125liQNA4EYmAL2XgfUs6UVM53YLe/Btm0TgAXWi+WCVaylNrb7XRzsBm13H81+oC01DIYIaQ8r+Aee+SLfJD7QdBdKjOayU2lOhCar2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=AiGG9mun; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="AiGG9mun"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:Content-ID:Content-Description;
	bh=MN6TgmmHIKWaTO9moHMH8UTMOCTYrsHBlf8eHAyQP8U=; b=AiGG9munPCckZxXxduZNqpeigM
	Z3sb9/mNptMgP1lpdm6XrIOX25k6GgFdM3rSf4swYhriqAVFAsPG793ZXoorHjEamK+M1Tq/U6tn+
	aY/+B/WLRsfncy3U81UbDEzIkHQt8iaHifSe348N1qyGHMuObCfDmzrj77u9lNz2oZpZlW8iqeDPh
	n4zgvUhLJ9q3ila/HGdK2CoyQwvimDAI6j4u0UDnCr6cKhqW4k3ZpVSCV6HqxUOHb7XrnpsXLIkUB
	kqH3KqpEmT4EgQtyQGI9uuGV6ewR8dBsf/tWfjv8dyj6JJGS2J+v4rsWZ0kVzzqSTPK7udrs07zgT
	XEWpKqHA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.94.2)
	(envelope-from <daniel@debian.org>)
	id 1thX8i-006FHE-Av; Mon, 10 Feb 2025 17:00:08 +0000
Message-ID: <bca345e0-391c-432a-a294-5da36bfcede0@debian.org>
Date: Mon, 10 Feb 2025 18:00:07 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: daniel@debian.org
Subject: Re: Samsung SSD 870 QVO LPM issues
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <Z6MjZ1Nniwn_uldf@ryzen> <Z6nePJ38aL92agTW@ryzen>
Content-Language: en-US
From: Daniel Baumann <daniel@debian.org>
In-Reply-To: <Z6nePJ38aL92agTW@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Debian-User: daniel

Hi,

On 2/10/25 12:08, Niklas Cassel wrote:
>> Dieter is using 'Samsung SSD 870 QVO 8TB', rev 'SVQ02B6Q'.
[...]
>> Daniel claimed that enabling LPM for his Samsung SSD 870 QVO drive,
>> caused them to stop working.

We have different firmware versions and all of them don't work for me
with enabled LPM, however I don't know the versions offhand.

I'll check and report back on Wednesday morning (not in office tomorrow,
sorry).

Regards,
Daniel
