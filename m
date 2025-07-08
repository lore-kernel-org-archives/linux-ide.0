Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0926B08F
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976177; cv=none; b=l8776TZj9vbp2TaMe6Om8ujaPc7tiuiI9WcfSfQcbosInib8ef2nAi564SeQ9xVobF6aXFLWuFxkBJ+kYIoKMkAjsm/S5ctriPRCQNTiwL4YkOznb8IHKpOGcFXkG5+ywtURfg7u8uhMeMKC/bNzSyk6bdY59fKzlTREIQ3xb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976177; c=relaxed/simple;
	bh=YauMBvOM3ziOLYWWQYIZOgqeG86EEoPHo7CX7oyVegs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/SRRHooYVjKGjNOZe2kn7Act85tLzW1jPLlexQYNiG7cQErfbzoJwbZ2TIy/kSpD5NVOR/wzwQ34rZKhuBIxnqjC3wLZzryMWM7t2gL3AJySKd8lF8+P1hDwnZHe4owaDPGNcY/mPTiHBrPAiAZkrNVBHJ8IswtkcFMrwFlMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0xLDs/9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0xLDs/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90780C4CEED;
	Tue,  8 Jul 2025 12:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751976177;
	bh=YauMBvOM3ziOLYWWQYIZOgqeG86EEoPHo7CX7oyVegs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0xLDs/9jKmxbiRhCSoLjHotdej+QWgZ19ny7KYXq+E0kWrBeiKuQf2Zzn6BxY3Sw
	 6t7oMAZwO6vnXGhf0hGTkQAJY98veTo4OIp0tgnKU5ZXdqYZveCzhBDAF1dml3JokO
	 9ORpkCLbNrXzjCX0NKbAPE0YeBPtRgEq/qVqWV5oN7zSt5e9lSO4gkvRoIZC4xkSO2
	 ETbdUIMGruxknqucetG+qgYIRARZHoa8AzbiLMjSlX7UcNUc8oM1oic4jbaZuiujl4
	 7MKaEX1XK6f0g4sT2xYxDR45UiDplzZONZA+FTug5+/XrGH08GZGvIIVXKLUnczaE3
	 D2EM1aq2nYQ9w==
Date: Tue, 8 Jul 2025 14:02:52 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ata: libata-eh: Make
 ata_eh_followup_srst_needed() return a bool
Message-ID: <aG0I7AeZBNZTafEl@ryzen>
References: <20250708073648.45171-1-dlemoal@kernel.org>
 <20250708073648.45171-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708073648.45171-2-dlemoal@kernel.org>

On Tue, Jul 08, 2025 at 04:36:46PM +0900, Damien Le Moal wrote:
> ata_eh_followup_srst_needed() returns an integer used as a boolean. So
> change this function to return that type.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
