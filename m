Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE683DAAB9
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999099; cv=none; b=bj+qBBZHkqN48/qu3oxtgsjDd6Zpi2yawhVdxj0cnUK+bDRWEZ+/TdC9XUtv/GYog62YqsaguPlh1w7WdBBXbabSYWtZbctVrFXpS5mdnjgIoqUgjZKTi4wyBm+l9/R+3AKytDeid1u+wzm1CByFhM1B0YCJUYSS34pTFhr346I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999099; c=relaxed/simple;
	bh=vIi1ah21qk4qMTONwuew6DTt7ecKLmXBWazHe1g1s4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PFbnBRancVfJ084O7WAjV1JFkSAehsR3TcNMjKrmgcrIy81wXN/HHYED20jR6wIXuvxm0Q5HnuFUirnk5+nnpN5FqCfw60mO9JMjWec1hkZubZJYN0pejzKDje3OYQrkq3glxZbXJd2QIZfDGHAGCAoNg/m8AiMZEPEE5QE3mRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXf3kmrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXf3kmrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807961F000C6;
	Wed, 14 Oct 2026 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791999096;
	bh=OZDg0GX3erYc6NG/+82N94LHmjBN97IP/iLpDWTPf2I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OXf3kmrdSgIJj73aHU/lvOoaIXopOSJ3+tFJwV/7CNHfzOZqASyWeZbMubuX9DZCQ
	 PbVo37Fde4Y4s+YaQzakcm12XdTCwxx44cv74SQzrNbeJqHFXwYPWGQA0MrNDuzkU5
	 Hx4dzyIVH9lFNiHQdAA5siUBcS2UimWgZS28h1fTWPk8hJhOJkbUu5Hl94j4mW/B7S
	 q1geC0K1CvxKAodhQgPJ56Q6WMKam8gBepxBoSG9zMyOzLfDOdQw0nrMPnBV+qqf5f
	 7qaNlcCSZX/0hX8JtqsQkXuc5XmHxLZzPAVsN+TK+4EiE/FQIpFEfQuAAKv+Qf/h9W
	 OzPB9s2KV3fGg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
In-Reply-To: <20261013193915.174460-2-cassel@kernel.org>
References: <20261013193915.174460-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-core: Fix NO_FUA quirks shadowed by
 earlier quirk entries
Message-Id: <179199909525.528871.2044265196072045400.b4-ty@kernel.org>
Date: Wed, 14 Oct 2026 19:31:35 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 13 Oct 2026 21:39:16 +0200, Niklas Cassel wrote:
> ata_dev_quirks() uses the first entry in __ata_dev_quirks[] that
> matches the device and ignores all later entries. Commit 38d431229bfb
> ("ata: libata: exclude FUA support for known buggy drives") appended
> three ATA_QUIRK_NO_FUA entries to the end of the table, with model
> patterns meant to cover whole product lines. Earlier entries already
> match some or all of these drives, so NO_FUA is not always applied:
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: libata-core: Fix NO_FUA quirks shadowed by earlier quirk entries
      https://git.kernel.org/libata/linux/c/a9c6dc51

Kind regards,
Niklas

