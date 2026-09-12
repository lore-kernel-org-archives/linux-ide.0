Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096CF1A9F83;
	Sat, 12 Sep 2026 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212714; cv=none; b=mFOG9vedAcAh8YQ+riPEzBmMeNLIxiEdIkfIdnxMPZi0UNtR84JphlrxgGDS+8ynPryZ5V+CKREKq8nTuhB+z+WihBmgm85y5W+juVo2vEyaJXTRC6Aa6FngvBJmXIjosZL+cASGMGfSqSlamw5CKAeikQp+Y52n2R7xlOJ0UA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212714; c=relaxed/simple;
	bh=iyNBaDHAN2ObnLMELuezRkXBWlQACEAkqe9806CIGr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fr4hT04IvWSXlmuezqzMN8VS+jhgqfAgqujf/LByewKXnhmCMKoJjXK8tzE5ZH7yDgWhyU811iH4fQE8Mzq5z3Lg8hs5Hoa9NDVcVPDduUqO+Phg9qgWcqXzsid2Af9bZKB6F0kmVmuhs3ZbSZr4Vn8JuYz29pcXQj3aFsOX4K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkphYdMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkphYdMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6621F00893;
	Sat, 12 Sep 2026 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212711;
	bh=yg9/3XY31/YMxjrU6ZZFlVK5IWDN0nMoxRshpwkPsUU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JkphYdMTWvbZ4V7px+JOI+i9lVP/FRsTeNLniziOc1t3CF8VLiR7HsG7aKSZZFfNn
	 zr8euxyJq0vW5zD1Te5FeI6WVzVMuu/iB2YcShGZ8zdrlVk2LdxhiCWGXhB0HKEu5+
	 JWAgJb4RWfOQd37nTuiYn8ZLIw1AFRH6JoE5w2JsRGarLce6BhWKi0KoPHLI+MHO0v
	 masbCbgEz84ITAtxUHb1FAcXRAO9vV0iWiulDbMo3ZQQ5K+EIoB/eaXY6XH+Q4tKGp
	 rgk7VaM+Ei5BOycZ1+Yc3WntbRMPo6KUh4zmBjPlyIHrRX59qzkV2VE/PqYMdzJtoJ
	 /ded/n85zu+2Q==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260912101215.86413-1-kmehltretter@gmail.com>
References: <20260912101215.86413-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] ata: libata-scsi: Fix ata_scsi_hotplug() reference in
 kernel-doc
Message-Id: <178921270988.151873.346161353379685897.b4-ty@kernel.org>
Date: Sat, 12 Sep 2026 13:31:49 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sat, 12 Sep 2026 12:12:15 +0200, Karl Mehltretter wrote:
> The ata_scsi_remove_dev() comment misspells its caller as
> ata_eh_scsi_hotplug(). The caller is ata_scsi_hotplug(). Correct the
> reference, which predates libata's move from drivers/scsi to
> drivers/ata.
> 
> 

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: libata-scsi: Fix ata_scsi_hotplug() reference in kernel-doc
      https://git.kernel.org/libata/linux/c/5915ab52

Kind regards,
Niklas

