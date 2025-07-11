Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B476020B1F4
	for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2025 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222864; cv=none; b=HvSv2uWfJG/RfVnla7pjeUZFUxnEXaKGgLEKwt4TbbgneZetVyrGN10RMg81ax46EGu3+q+RT6D5ZA5L+L9hsWHnP86ekBmYq+anDwTAlPOOfyQINzO/KsrEyIPXiwjoSl4UwInMO9c863X44WSE/QHMsLx74Pjo/7Cj2UQHtGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222864; c=relaxed/simple;
	bh=18D49n9M6h9BCDTok/pliSN70Ea2ugN5yGmhBVCMv40=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aeyMxzw5M8YMhA6xfSCYbtss801U/lYVsl2fSO6L3bxnCT4f48KoXMDFOzxA8A958nLVPX+maUV+dQGHgOoT/AwzyTSat4FgJb1bDBmgkYvx+tGNq5sFa3PhsLQa/6byGCXb6SMsYw71LcCrAJLzIjr+fZsDO+3Rs8jmvoAHMDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdvrymSu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdvrymSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9717C4CEF5;
	Fri, 11 Jul 2025 08:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222864;
	bh=18D49n9M6h9BCDTok/pliSN70Ea2ugN5yGmhBVCMv40=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=tdvrymSui/Xu5U/1TEgkxPp+27AXIx+RFUOUbFXE3ctRS4+ZIEtFhBGO1ZKzTxLt8
	 rni+jEEowrVBJE+s+pLitQSxBrWOMcRoOL++3WSMwvl2npSV5d4MI3y98XuJVf9y6Q
	 LMcid/vm2z27RGvl8iVt4BJVtvUVi8HOxJXp6LCbrh1HDRUhtBZlMaTYIjDbehfYWe
	 l0ILq3SaGofQ++wBy5f3J1we0ZrlXSEw9jrOwc62xQ9cigV+kMeLgXMUTAF0JoNiZp
	 hDIHgR+dqn333303ms4tmNrAzglskIxwumVeRZ7dRzB/kDaYpu9Arcbma+7WRrfrl4
	 RhJ8GvdR8+2xw==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250711082158.220047-1-dlemoal@kernel.org>
References: <20250711082158.220047-1-dlemoal@kernel.org>
Subject: Re: [PATCH v3] ata: libata-eh: Make ata_eh_followup_srst_needed()
 return a bool
Message-Id: <175222286359.1669914.3459687324447156664.b4-ty@kernel.org>
Date: Fri, 11 Jul 2025 10:34:23 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 11 Jul 2025 17:21:58 +0900, Damien Le Moal wrote:
> ata_eh_followup_srst_needed() returns an integer used as a boolean. So
> change this function to return that type.
> 
> No functional changes.
> 
> 

Applied to libata/linux.git (for-6.17), thanks!

[1/1] ata: libata-eh: Make ata_eh_followup_srst_needed() return a bool
      https://git.kernel.org/libata/linux/c/5158ec25

Kind regards,
Niklas

