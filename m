Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02E272E7C;
	Wed,  9 Jul 2025 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068981; cv=none; b=Ijmsb4uJBKprg//U2QeuUdrsBjq9KIaJnL3UhXm/m3d5Deo9uBk42xM8BqQNHzrsowdwf7NHuLv8uUFHBkHiSCszkpUg6SEsNitP3ZrWro95mxb80V1a6pxCLPmjDRr+6cTnbjqspiNhbkx6DDcz5gazMnrdT7Xaf6JEEEmmLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068981; c=relaxed/simple;
	bh=aCprawoDSLPBBi2Eo9Ssh/Z6RI7VTvcZxxrfDFZi8cE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tjKOwq6fiQsLt+38bNzb5W1cZZYVsR9qePgOhxKbQnlkk/8LWXfKino2v5LCyLiFt3gBLBx5Iw2isJ9EGiAEqJruJL9NVce9T1y7zBLXfehBtHz8Owfa+kPd7Jdvbw+sN//XAsK9FMyDtNLESuCXbgkIcZA52VSFV7up8DwQhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvPiI1RO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvPiI1RO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14479C4CEF1;
	Wed,  9 Jul 2025 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752068981;
	bh=aCprawoDSLPBBi2Eo9Ssh/Z6RI7VTvcZxxrfDFZi8cE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OvPiI1ROrxSnV3OQKbl6bBg8FyQswwjy22V8EFUUMFal1NUz1TcTSNIr2f1mePF5r
	 wear7KgcqE2Uwbh4z+GVj+AJcdZEi7d5S/bUJJEC2Cc4Q9Tu+n6hVVHFO5p50093PC
	 TgD1baifyxJ5LU6WgcwZ1MZc6uIlnsfeF+zdJ22naA5csKq2TR+G38G1Y60n7UqLRk
	 1qvl2j7zqU+uD/aNh5vHoCNl5NqemBjr1Log2xa3R93OiuPuPX+BToXQB24RIhIDUI
	 jAEN1LiI0lQFS72iDpnk2+WoYmjYCncUwPFlKVXDNCUtDUri7HOPFxmcJAG+rbfuEp
	 w5gTMYXNDDr7A==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, Jonathan Velez <jonvelez12345@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 shuah@kernel.org
In-Reply-To: <20250709133330.3546-1-jonvelez12345@gmail.com>
References: <20250709133330.3546-1-jonvelez12345@gmail.com>
Subject: Re: [PATCH] ata: libata-transport: replace scnprintf with
 sysfs_emit for simple attributes
Message-Id: <175206897980.965177.5326786325935383585.b4-ty@kernel.org>
Date: Wed, 09 Jul 2025 15:49:39 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 09 Jul 2025 13:33:30 +0000, Jonathan Velez wrote:
> sprintf, snprintf, and scnprintf do not consider the PAGE_SIZE maximum
> of the temporary buffer used for outputting sysfs content and they may
> overrun the PAGE_SIZE buffer length.
> 
> To avoid output defects with the ATA transport class simple attributes,
> use sysfs_emit instead of scnprintf().
> 
> [...]

Applied to libata/linux.git (for-6.17), thanks!

[1/1] ata: libata-transport: replace scnprintf with sysfs_emit for simple attributes
      https://git.kernel.org/libata/linux/c/48925ba7

Kind regards,
Niklas

