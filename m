Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176A3A3822;
	Wed, 10 Jun 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084415; cv=none; b=MP7dZB3Wb+pCXEKOc74jZmxPzlckYkm1COQs7NptY6f+4tWq1FzJccmVxWgANxURUt+uTYVS8aWgaBLdciiAdRBUqrT8+nHcSi2SXA4UP2c6865hp5GFZlH9Cf2nOzyuZ5EYv/qPLDDuLN/qBuR9ayvpD3m4lQIGt96NmeN/YfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084415; c=relaxed/simple;
	bh=E32UtgU9j465DsHQu35gdJFdBzRN7shm4rFHrpjvAUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y+KUZIp9LejpobhRyrJRWiaaR4feTpYMjAiJT7+DX6dommcz8RMe1RyMvWAmWb4zEhO2f6nvOpq4QQ1IHyhRG4I2CE3nRqXLL9oj8rnH4N5ceB5/nTnupolYjQcFvxA9F1UF+oxYa8qt/IRlAWD7ykFvAbJGPb31Oy6ChbtShIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov6mT7co; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov6mT7co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372191F00893;
	Wed, 10 Jun 2026 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781084414;
	bh=65Ap8CcHwVrT4B+TnYO2tUakmLw/QuAoakiZ4QkeAF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ov6mT7covv3c9fVpvQThcdlRrIT1psYLX1+jXXK75sm8cb7MupFGgsOO2ne0A90nB
	 VWG/VtOt23+ofSHY/K5qjZ878bk9gvb6Psphzva8tz4s2yLMamB7Ap/QvjKUqTKgc1
	 SaSWNRDxptIDHIVUA/tMinFLEZTwhGprA1+I32gpnkiiZE1MRmk7lJwzl17xQslFgW
	 UDPuAyYYVDAyIW0cjrMn/WSKACOmZi3jz2/NYCKW7RXc2tyN3zcUFkhQyDkmwugDRt
	 XRQrq7UWCbTlOc5A5SRt7llATD5OG6eJFt/1zy/jqB+EEVng5/O2BYQ7UJ5wv+Z+15
	 +Q3fUUflOfiOA==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, raoxu <raoxu@uniontech.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <71B4D0BBEC4F886F+20260610052835.1111181-1-raoxu@uniontech.com>
References: <71B4D0BBEC4F886F+20260610052835.1111181-1-raoxu@uniontech.com>
Subject: Re: [PATCH v2] ata: libata-pmp: add JMicron JMS562 quirk
Message-Id: <178108441294.661547.7459937781568017173.b4-ty@b4>
Date: Wed, 10 Jun 2026 11:40:12 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 10 Jun 2026 13:28:35 +0800, raoxu wrote:
> JMicron JMS562, as used in QNAP QDA-A2AR RAID1 adapters, may
> keep the exported ATA device not ready while the array is rebuilding.
> 
> In this state, libata may repeatedly try to softreset and classify
> the fan-out link.  On the affected adapter, this can time out, make
> PMP/SCR access fail, and eventually disable the fan-out link before
> the RAID volume is exported.
> 
> [...]

Applied to libata/linux.git (for-7.2), thanks!

[1/1] ata: libata-pmp: add JMicron JMS562 quirk
      https://git.kernel.org/libata/linux/c/c62aff11

Kind regards,
Niklas

