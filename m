Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDEC1AA78A;
	Mon, 11 Nov 2024 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357374; cv=none; b=D6Z8GrR4DmZJJASddQ9YpYa5LKkwYlYWJXG0zin/J6gM9iUpksoo57R2DjlTTSgzyOHSiCCebpnbUsSPJ+YxiC11d7Vnpyv7UdSJ2sSAbMK9Xl4KcnxmaaZJYkE0vWh+XYCC+mRfj3/SEWiu84vi/mRSLZQR4nF0Zeiw0KtkffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357374; c=relaxed/simple;
	bh=Kr4rn7O6C9i3ftwAxRuTUF7vUGPIBqmjEbRAesXeZA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRRPwI4ZFYdCHZp+bBzcnZCgg9ATX+Axsea9KhtyoIXCAwXaaGoumD9Q5HcauYNWzUNrVWT9yBDOkKei8tlJn/lyZIijnnwshec1K2bKvtLuxBpCiRX33MpqB8jasJThWXBoq4tMZ9NXg/ZLTQALFaQxl4y9msgAvLFKEKAT4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltodrAhT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltodrAhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79185C4CECF;
	Mon, 11 Nov 2024 20:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357373;
	bh=Kr4rn7O6C9i3ftwAxRuTUF7vUGPIBqmjEbRAesXeZA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltodrAhTZo3aVvGPd8qqNAmbPPeqsf5Z5hwMHgWfqAvLxDN9asXFbBBuhgrTXy2mD
	 UTlG0QMEP/Dk4ZvI0GM4pOU7e12ZHsRqg+o5ZwZSwDYa3PXLIbHFGstsRts1mAxLaS
	 L88Q02gLedHV+OGFXmp2ZHoHTj2FrFjI7P4T7JVUK6z+px33enOmMLlSr1hVdvjX5+
	 I4ThDBdH4fXvhC2Wtk4jm0BXEYimtVVLe9fyag02Ncq+SK/mjKhf16dSr2l9hd4Sne
	 1wZYpRYHi5ADQbVojOY1+3Q6GO9Rwrk/PRDWbjTolKDGzHMyoxTuWE2BJJURMmEpvU
	 1ED5ci85HG+CQ==
Date: Mon, 11 Nov 2024 14:36:11 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional failed
Message-ID: <20241111203611.GB1887580-robh@kernel.org>
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109094623.37518-2-linux@fw-web.de>

On Sat, Nov 09, 2024 at 10:46:19AM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>

Thanks for reviving these.

> after converting the ahci-platform binding to yaml the following files
> reporting "'anyOf' conditional failed" on

Here and the subject, "fixing anyOf" isn't very specific and is just an 
implementation detail of the schema. "Add missing required 'phys' 
property" would be more exact.

Rob
