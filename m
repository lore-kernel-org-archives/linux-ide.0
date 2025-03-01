Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8401BDAA0
	for <linux-ide@vger.kernel.org>; Sat,  1 Mar 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740820944; cv=none; b=DNHk0rbnMvpoE+JGZHhWcIBwdgeWdTztf9Kw1XHo6xoJC/kFLA7xw2yBCosXIzy+pDoNS/zHgFms+1kgSXD/+MCJNUk5zDFxu74MAkUvZJywO+G+JZ/teRIto7hLf3CRCdRexzNoOgpzeYfvhv0i8J3XsuZcRFi7AUzOFN+yCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740820944; c=relaxed/simple;
	bh=2XE/hAvbOuvNnxKcI3ylcmVq9ryxsvKTjZ0FFv77fDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YpciIlP+C4dpMn2PC/vprHf92ibioWSOdcSP7acU28GqHBio1LTfClRSVmjae2ZCbf+szcrgyr+b8LJh31HEdnkCaYozu+X+AIdRfInG5cf2TFo3X3GXk8TR2tjVa9forthC8ZxzXjpGnBkg7iOyrb4i8N5L1PHMAIn90gzFi0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCAehL/+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCAehL/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3EEC4CEDD;
	Sat,  1 Mar 2025 09:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740820944;
	bh=2XE/hAvbOuvNnxKcI3ylcmVq9ryxsvKTjZ0FFv77fDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VCAehL/+OTpWL34b9jPQi+5wxh9fqzHmWw+5eavJimRoDppgl9nLBxCW1aRAw5kWp
	 ZRr6VHEMlTwOz+pBqOJlDQ8NWZsFTR6uuA1Br+gicEkN22PTEWq6Z8xPnLRPbgy17J
	 SWdpiebvY0QYoV1IRUdlDQjG2LzQnuuinWvUfSf9Gugjvy+Slrg1hhorA90MKEakZU
	 KlV+rREzhozUF4e/7YiW1l9k49L9PzuQ1OvyB8Ar/Jg1ZV6kp2bHqQYpGYcFmpOV2B
	 Vjp+ySSQRg1pdVqQIzFHvthIYZjsDAlS6BfBz19VrROWMNn1pwrTxn5TeWPya845Xk
	 kB1VZ/oY9ftcQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Daniel Baumann <daniel@debian.org>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Dieter Mummenschanz <dmummenschanz@web.de>, linux-ide@vger.kernel.org
In-Reply-To: <20250228122603.91814-2-cassel@kernel.org>
References: <20250228122603.91814-2-cassel@kernel.org>
Subject: Re: [PATCH] Revert "ata: libata-core: Add ATA_QUIRK_NOLPM for
 Samsung SSD 870 QVO drives"
Message-Id: <174082094323.221409.1690012369871664061.b4-ty@kernel.org>
Date: Sat, 01 Mar 2025 10:22:23 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 28 Feb 2025 13:26:04 +0100, Niklas Cassel wrote:
> This reverts commit cc77e2ce187d26cc66af3577bf896d7410eb25ab.
> 
> It was reported that adding ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives
> breaks entering lower package states for certain systems.
> 
> It turns out that Samsung SSD 870 QVO actually has working LPM when using
> a recent SSD firmware version.
> 
> [...]

Applied to libata/linux.git (for-6.14), thanks!

[1/1] Revert "ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives"
      https://git.kernel.org/libata/linux/c/a2f925a2

Kind regards,
Niklas

