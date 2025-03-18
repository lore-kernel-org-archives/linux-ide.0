Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66BD38FA6
	for <linux-ide@vger.kernel.org>; Tue, 18 Mar 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285131; cv=none; b=TMB++85/05Y/aGfkTlSrNzCOlGuwOgrhA2eMhxrH7BUa7hTRFAMiEHiFd14ofWGK0AiFFYoMEb0lMw2kWerGdwC3+9WO7O9zMzTGvPKOH7nNDE5i+73wsulyihDbRrsAYPWVNvGE1xUibkyM9O94SBuiFDFm4pHCJ2y1Q/dEK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285131; c=relaxed/simple;
	bh=PzkGk0gS6skThJRqV84Ky8Pd0Ta9AvntpBEpP8FHJ8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MCbqwmwPmQ7HNnFYMT7mkmivM1lMMU5K5DZIoU+6r4++nYxmfoENIj0gGTtLREMy7YMbaoJSmdf1nbGqCByiVIqH2k7Bha63LMKHPNtzLyQJi886paWcKKdXrkySWwVxp4i2r6idI+APWKG4vcGY4y0hbdnkZs3omo6DK+pQlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p577ms+C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p577ms+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F7FC4CEEE;
	Tue, 18 Mar 2025 08:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742285131;
	bh=PzkGk0gS6skThJRqV84Ky8Pd0Ta9AvntpBEpP8FHJ8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p577ms+CHzARXK22tu2cWsLoFmiZ1XHELhsDNXG+Yg68/IcrlL70VoncqhA1Sv6WX
	 cGKO4MO/EsPYScbEwTshMgOTH04bAKXcTtuzQvaAyXH7MS5k7rMUi3CUcMHqiJ1gsd
	 xDlQppPM+2/miKrdgTdOmPLAdgvY2uK7ptmnQcVGdJMk+s5M9pPF9IASSp5vEzYO3/
	 vDKlU+EBdbufg2ozs3CkW310AeN184XAo3ASStYgxrI2l0gR/BmN1Knx2UW5pvyBlu
	 pnEWixt1M3dO8hSuwm62n/VDcxlMxVsXwzhtUHI2bbdc6xVklLGpVOUrt8RibsFAq3
	 lFbNizjR+t3Rw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250317111754.1666084-2-cassel@kernel.org>
References: <20250317111754.1666084-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata: Fix NCQ Non-Data log not supported print
Message-Id: <174228513007.1762247.2142317341089300168.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 09:05:30 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 17 Mar 2025 12:17:55 +0100, Niklas Cassel wrote:
> Currently, both ata_dev_config_ncq_send_recv() - which checks for NCQ
> Send/Recv Log (Log Address 13h) and ata_dev_config_ncq_non_data() -
> which checks for NCQ Non-Data Log (Log Address 12h), uses the same
> print when the log is not supported:
> 
>   "NCQ Send/Recv Log not supported"
> 
> [...]

Applied to libata/linux.git (for-6.15), thanks!

[1/1] ata: libata: Fix NCQ Non-Data log not supported print
      https://git.kernel.org/libata/linux/c/b500ee5f

Kind regards,
Niklas

