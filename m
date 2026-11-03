Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740854;
	b=1aRqwkdxCBrXHBztd+u6i5be3+9BMPgweGtE8iDXYrUA7gZTpjvHNg/qevWHoxMVwgwf
	 MVxSCsYYNa3IQ+LJT4xSIehsLkMFwpQE+D4sh9wtRUIWGrZP0CILf7bjMyVjloCb5fUbA
	 f1wqBeBOHxoRSSJv+S9xtUfJ+zYSfNzr3U08Xw6WiEulOED+vR8psa97M+jLgQ8y/fhhb
	 Jqd1ONK0TOedZBXvTzYFwDl6todtI5fjIAj2iZ7cgPaTQbHbiqHp6HvNDJw6q0iv794vw
	 dfTtF5rXB7vJWIBbIiFMeopRnrNOhgKaDyE0qeW4XSA8vlvQp27hGybgQBHv7/HqUPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740854;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uM9zgqW0wLSCUXP5DdfBLOFHymxEaqJM6y5uXGUDaj0=;
	b=Cje56lDqamIRibexeEoeKV8Tz+0N5wBgZ6YKN6BnYqtDPzTYX5s9obTOY/+iOUEP0XHc
	 ItnjzTzF2gvKxSxqL5MIWYn1WklXY/5urr+tsaoLJAk7B5qdsAH57x/57y2qWJEOAcUuk
	 IjLR0lsJJlUNRtsvZUVHGycizz5INV0c69xy/n0YryRGS+HUbXzQi6h2AGyDvhdsFtXDV
	 +LpoXC+USuDLChsnc2dkgtePYCWYn5Qto3uBNxkNNpiH10tlHyiyxK/ca84BTC1sVS9+5
	 /3bybmWvzFLrE1zzk9ARREZeML4RaDp0b/Q94h/AWqdB6JsMLh2DB74Nicrd6npdW7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZwO+Uo9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C38606A31B
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZwO+Uo9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EAF1F00919;
	Tue,  3 Nov 2026 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793740854;
	bh=uM9zgqW0wLSCUXP5DdfBLOFHymxEaqJM6y5uXGUDaj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AZwO+Uo97HLkPLPB+O7XmX+WVCrWoFc+ga3T+QIXGk6MrI2efHtr/NreoZon3fylM
	 m02ZafYAqGf7oWEzjU6BuzeFufWvB28AcjM6UDrzvPYaqJ3hJrg6u7tmi4uLGty/RS
	 LKwoxZQa7SPhGOLiaQUJBHybn7HiAGRy53cAkVB6ZWzIiKQbk9x01iyrqJxxGuaiy5
	 OxwgHC0QyhYLX56vBHAt8oaHMJ+JHjsMDIdHBBioOCTzZGoqy5gz7KcSkd371v2jbO
	 wVqzdTREvMzDGIMAWMlWGNzwPxtnpWVXJ2iHcH22XdWFXln6Mm0JOwBX+j6Ku+IoqL
	 T/tkN1MHAH4Mg==
Message-ID: <710c0ece-7462-452f-a438-2cfcd0159140@kernel.org>
Date: Wed, 4 Nov 2026 06:20:52 +0900
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] ata: libata-scsi: do not accept subpage code FFh in
 MODE SELECT
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Shao Mingyin <shao.mingyin@zte.com.cn>, Hannes Reinecke <hare@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
 <20261103205448.931471-12-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261103205448.931471-12-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 05:54, Niklas Cassel wrote:
> When the SUBPAGE CODE of the mode page in a MODE SELECT parameter list
> is FFh, ata_scsi_mode_select_xlat() rejects it for the control mode
> page, but accepts it for all other mode pages, i.e. for the caching
> mode page, the only other mode page that it supports.
> 
> However, FFh is not the subpage code of an actual mode page: SPC-7
> (7.5.2) only defines it as the MODE SENSE request code for all
> subpages. SUBPAGE CODE FFh only means "all subpages" in requests, i.e.
> in the MODE SENSE CDB for mode pages and in the LOG SELECT CDB for log
> pages (see SPC-5, 6.8), while the SUBPAGE CODE of a mode page in a MODE
> SELECT parameter list identifies a specific mode page. Also, SAT-2 and
> later versions of SAT define the Caching mode page with the SPF bit set
> to zero (see SAT-6, 10.4.9), i.e. without a SUBPAGE CODE field.
> 
> Remove the ALL_SUB_MPAGES case, so that SUBPAGE CODE FFh is rejected
> like any other unsupported subpage.
> 
> Fixes: 1b26d29ccd59 ("[libata] scsi: implement MODE SELECT command")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
