Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7C270EC3
	for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637880; cv=none; b=MaCnv/6T2Tj1kOOkFGikNhWYXZpYvH5T1laPhNBix4QRTTseuSXOdsfPFbHSpqcORmtL/TCYSk9iAZcDXqeLSf36zCRFzfuHfcOk28AzDQmUqVQMjHdC1NIc3cUm6unugHX5Jc1KQDwT9egaVY34tgDs6d1MxLxqeKgj9zwqwW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637880; c=relaxed/simple;
	bh=imzJMbb19ZsZvS0UVNJ9SxAe2yYnC1N02exIvDcZ+0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vav1wffqkzYwIf1Bs4GA072NizKmsMa8JbMtweQmhN4bFSZmFwl3rMhEAQ4pYRfWs/caz0069ilBab13jWY1A00BdxImbkFtsSiFElz0AS0+fDT1P0cSKlUSvfoyYbiCySfjZE+zxx7COug++t/KTt3Obr+i8ILBj9d1fDT/4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpNDhxEx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpNDhxEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D9AC4CEF1;
	Wed, 11 Jun 2025 10:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749637879;
	bh=imzJMbb19ZsZvS0UVNJ9SxAe2yYnC1N02exIvDcZ+0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UpNDhxEx/BIvv4burop7rfsDzBk14gydupZiU9XjCPeViS6bfnNa44r4Sll2Xgaby
	 yYHYXcgn91ncGQ2PLWXWU/qSO0pQWTSNoZwGynYXK91cg4ZEMqnpBeecQ+lxcVW2oi
	 x7SjdkdPWwI7runB9Ozb+Ah3CLm6cQueUtsPrvEwCxLwJ+dHP4/6lVCRHGat83g/bb
	 uM5S0TjK2NQ/RQmP0zQbfv6d7BmMoAuqrutQsxMFZjcD146xjy2ZLYe02jD7cPu6wZ
	 OTehuEIsMhJDCANRKWOWFlPQXgB+PkpjceUQBWpccU+zHw3pm0Z3hwD4dWPfxEwRV+
	 X5QnjJWGvA2Qw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me, Hans de Goede <hansg@kernel.org>, 
 Andy Yang <andyybtc79@gmail.com>, 
 Mikko Juhani Korhonen <mjkorhon@gmail.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 linux-ide@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250610110757.1318959-5-cassel@kernel.org>
References: <20250610110757.1318959-5-cassel@kernel.org>
Subject: Re: [PATCH v2 0/3] Cleanup ahci_broken_lpm()
Message-Id: <174963787767.1635114.11613333221647910549.b4-ty@kernel.org>
Date: Wed, 11 Jun 2025 12:31:17 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 10 Jun 2025 13:07:58 +0200, Niklas Cassel wrote:
> This series cleans up ahci_broken_lpm(), and adds ASUSPRO-D840SA to the
> table of boards with broken LPM.
> 
> 
> Kind regards,
> Niklas
> 
> [...]

Applied to libata/linux.git (for-6.16-fixes), thanks!

[1/3] ata: ahci: Use correct BIOS build date for ThinkPad W541 quirk
      https://git.kernel.org/libata/linux/c/6f29d393
[2/3] ata: ahci: Refactor ahci_broken_lpm()
      https://git.kernel.org/libata/linux/c/e3ea4ae4
[3/3] ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
      https://git.kernel.org/libata/linux/c/4b151c71

Kind regards,
Niklas

