Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4793BBFAE
	for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989719; cv=none; b=BQ+FrVvfe/pHiz1IX5svUWmKXF3E3kApFGdlNc6oZORWKGeaGtfNuub2Bj2Q+RzQOyTigqRgjKhqhcLfwrkwFRaiL77aPrIMmbE07P0QMmcTivLMD2FBto4k6KONNdyjHkjU3ZdoGhdIPKDpkAdQImlY/b3lDEfprhz2xZxk4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989719; c=relaxed/simple;
	bh=YP0cSzYNHGEWp8ihvkg4jto/OpEdtS0lGyxK3x2KlS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TCKGpHSGGw5NRnh1J1klWG54rNIkJoNlU11vrFFa8CHU1iZwqVafdfUx/qv6W0jT9paGmJ1bPcunsStnEU/06s/dcWy8frK3fsAA/jnUSY2ooG1sa3UpqWer6RxWYMFXZjAbrPrE52KMNO2HW6uSgyKODTT0Tj+QiAYSfj+SzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0UwvAGl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0UwvAGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C5F1F000FF;
	Mon, 21 Sep 2026 11:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989717;
	bh=Uz/ENCkzJXUwxM2ofRoHQuHn3edOD96r37vS7dCHV9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=B0UwvAGlgtXzV3WWCVhJD/NG/Go+9U/5VHDvrJISO+2yoYUtxySol1LPYXDxO1zkK
	 NghQKWpV6kbZZ6gcMsIecizK83qLlyEwFYTYZBmppPo2LCESX8tidwU9rPbKBfDjkx
	 MlJX9jVQ1/a/3rvaezomItc9fbjVwIxzWTWbKMU0U5bdGGlBr0U6I0WEieTQ2xrMze
	 AaQUiZrlexBtcR89KFP0X+34EHEZVcYKFi3lO+OuDmOCzZRwos9RO22Kvr0JNyD5iI
	 0n+PurRkAmFz+R6WCNy9t1XfV9MYK0g9tR9vAWndcAeVCt8WPhymUz1ITdyIJZhxZ8
	 GKj9infW6ypBA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, grandmastertriplej@gmail.com, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Natikar, Basavaraj" <basavaraj.natikar@amd.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20260918124030.1962773-4-cassel@kernel.org>
References: <20260918124030.1962773-4-cassel@kernel.org>
Subject: Re: [PATCH 0/2] ata: Extend Samsung LPM quirk to AMD and fix force
 documentation
Message-Id: <178998971606.2899154.7965847103809977123.b4-ty@kernel.org>
Date: Mon, 21 Sep 2026 13:21:56 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Fri, 18 Sep 2026 14:40:31 +0200, Niklas Cassel wrote:
> A user reports that a Samsung SSD 870 QVO 8TB connected to an AMD 600
> Series chipset SATA controller times out on STANDBY IMMEDIATE during
> system suspend with med_power_with_dipm enabled. The command completes
> with max_performance instead.
> 
> Patch 1 extends the existing Samsung LPM quirk from ATI to AMD
> controllers, renaming it to ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD. It keeps the
> same drive model matches and leaves the NCQ quirk restricted to ATI.
> LPM behavior on other controller vendors, including Intel, is unchanged.
> The underlying controller/device interaction has not been root-caused.
> 
> [...]

Applied to libata/linux.git (for-7.3-fixes), thanks!

[1/2] ata: libata-core: Extend Samsung LPM quirk to AMD controllers
      https://git.kernel.org/libata/linux/c/e6bae503
[2/2] ata: libata: Correct libata.force parameter documentation
      https://git.kernel.org/libata/linux/c/88a0474d

Kind regards,
Niklas

