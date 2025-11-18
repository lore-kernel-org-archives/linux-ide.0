Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4845370305
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2025 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763499642; cv=none; b=S7NLB4JQ5GWem5d/Ed8lUy+WEG5lBdLiszyXdujBkn0yoNITFlWQYUxaoc841yU0Vivs59RvLZhucJQn9SfvKUNihsjzxnS+8/t4meeQgb77z9xV38yX5bl6SSkOZfFxmvuaJjEoX7fkiQjIHmeLFvKRLJndL3mcNhlnuYJiTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763499642; c=relaxed/simple;
	bh=VMyuFlh+YA5l2NEszhtq08519J7HF5P7KG8fGbX7Smo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rey8jMCCNrgOXJ/53PfFUoomyKKsd1/faN+jBuTHbV1BNNllnyaBpA4fm8mXHbEmR5SV+sQySRoLY+ZNXSUFDXJLdTrC7PuGmxqtGLAkn/bRqM7tJWfvvVtLXtD7Qsjzl17c++Y+x2D87F/MCez+BVYmCA/ASAOZd+sgtaBjJnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKRXttUN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKRXttUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E60C2BCB5;
	Tue, 18 Nov 2025 21:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763499641;
	bh=VMyuFlh+YA5l2NEszhtq08519J7HF5P7KG8fGbX7Smo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qKRXttUNSP9p8W6l4IyVFcv51ROh3oIltMH3Egl2hh4PyiXWUNg7TqYvCwv5xiYX/
	 +3Z+LfarP2v39HEe6ULn676NfYtcMQJDzl0wWk142YvMfUGfbaX7pNvuLltV/vQ4/A
	 EXpBTN2O680ztyPc5qSrCikmULD/US3sMU/xBAFftnM5WISH5T6+WcoLoKbJGFMNzb
	 5GdBRla4sTHAeETJt+pLZQqVP8dwii6gZS2t15FWDphQ+Q3nr1ZO+5wHSYzU9iZfnC
	 kEsX+H75x6qdvZP/NEG1CTi2Mat62TC4zTvTTzVWwFtIbmArBhnCyHDzYnu1fgFrVL
	 AzZAWgI2ciMFg==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20251118.174654.1384716262322584447.rene@exactco.de>
References: <20251118.174654.1384716262322584447.rene@exactco.de>
Subject: Re: [PATCH V2] ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI
 Adapter
Message-Id: <176349964006.1797261.8564681636368188760.b4-ty@kernel.org>
Date: Tue, 18 Nov 2025 22:00:40 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Tue, 18 Nov 2025 17:46:54 +0100, René Rebe wrote:
> Add Iomega Clik! "PCMCIA ATA/ATAPI Adapter" ID to pata_pcmcia.
> 
> 

Applied to libata/linux.git (for-6.19), thanks!

[1/1] ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI Adapter
      https://git.kernel.org/libata/linux/c/1d779fa9

Kind regards,
Niklas

