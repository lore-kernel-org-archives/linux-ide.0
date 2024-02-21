Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65D122F0C
	for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2024 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493505; cv=none; b=IzYITwWJIDoleTK0GzAOEEexT02MCYWtVfbXLZhFaNBhE6cyLIbT7yWBC4m+cc0x2ngZ6hY9bcu00iVyodEad8coTox3uOaLgEWwM67LtH4ZY3LZoZN0OEGpa/ffUoxLTF8HEhumjsNvUfe75rLeEfPPWlpJncR/ddXt1CuS8kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493505; c=relaxed/simple;
	bh=8Dv7nIuH8UsIQ1xV6QHyvSp0kXARfcCkLNHnobcwqx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tISHcJ6pPm5FqPLNd4+l5CtifvU38w9snIFk9Yhq9cPe+6FtgV8fWEo2Mezi5JLS6tibAcvf6/BhYk3042L4TXBHHUcC42kny9VoJF+BymaOsEgjQHw0Heehz+o5VWU1ew/dftT8K+9b8f69VycAOrKAtxlWV5IXV4toKeBjH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcaszAej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcaszAej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D703DC433C7;
	Wed, 21 Feb 2024 05:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708493504;
	bh=8Dv7nIuH8UsIQ1xV6QHyvSp0kXARfcCkLNHnobcwqx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gcaszAej6jxncdlr4p/odzYFbOIeoHXuIl1v/fIZUwYe90eUV2KeDhtl8stKkJx9R
	 phn8wNnEcHuUkaHD4Ad8XnrGOv86tadzUBvAWzocjvPgvqs28Rd9sihuIn2khhdLbm
	 MicNsiZ7Fi15sYbliajH3WTuxsX6eKpfa3m9I+g1lWZIfOJFTgkKihmUq3yQG9ZW3x
	 OFxk8lwoYVVzppYA6VJzBR8v3lyHE1zejOgmrV5XK9ISii8/wn7wCuuO8chCj5VdpS
	 eCHSCM55xSSYqQ7CXudHmUQC4vJfhzIJE9mx55dlAYgRN6XpKTqh9CGhwEt8w3g5Zr
	 EqnySd9v8AmFw==
Message-ID: <07c154cb-c869-4247-858b-002e36ed8f8a@kernel.org>
Date: Wed, 21 Feb 2024 14:31:42 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ahci: print the number of implemented ports
To: Niklas Cassel <cassel@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Andrey Melnikov <temnota.am@gmail.com>, linux-ide@vger.kernel.org
References: <20240219204744.1365567-1-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240219204744.1365567-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/20/24 05:47, Niklas Cassel wrote:
> We are currently printing the CAP.NP field.
> CAP.NP is a 0's based value indicating the maximum number of ports
> supported by the HBA silicon. Note that the number of ports indicated
> in this field may be more than the number of ports indicated in the
> PI (ports implemented) register. (See AHCI 1.3.1, section 3.1.1 -
> Offset 00h: CAP – HBA Capabilities.)
> 
> PI (ports implemented) register is a field that has a bit set to '1'
> if that specific port is implemented. This register is allowed to have
> zeroes mixed with ones, i.e. a port in the middle is allowed to be
> unimplemented. (See AHCI 1.3.1, section 3.1.4 - Offset 0Ch: PI – Ports
> Implemented.)
> 
> Since the number of ports implemented might be smaller than the maximum
> number of ports supported by the HBA silicon, print the number of
> implemented ports as well.
> 
> While at it, clarify the properties being printed, and add a separator
> (,), as that is currently missing, making it very easy to get confused
> if the number before or after <property> belongs to <property>.
> 
> before:
> ahci 0000:00:03.0: masking port_map 0x3f -> 0x2f
> ahci 0000:00:03.0: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x2f impl SATA mode
> ahci 0000:00:03.0: flags: 64bit ncq only
> 
> after:
> ahci 0000:00:03.0: masking port_map 0x3f -> 0x2f
> ahci 0000:00:03.0: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
> ahci 0000:00:03.0: 5/6 ports implemented (port mask 0x2f)
> ahci 0000:00:03.0: flags: 64bit ncq only
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Nice !

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

