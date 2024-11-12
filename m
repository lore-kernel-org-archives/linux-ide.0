Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FD23099F;
	Tue, 12 Nov 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410712; cv=none; b=jADavnvC/XPNFpY0CcuDJsSoV1wlKMWtPqDSzOm2sLkLrU2mLoFXDXxaV0FxtwlsjiECIZUYHh+vDIoQksDbE8ahr/1kWfTG4/PrL+QrUwphzVU+3BHcRjijRFNmu8qYsh+GEn4IrYuZatOhvYKPi7XLaRLIJUWcBvfrU6uDCwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410712; c=relaxed/simple;
	bh=XlDTTHWw7KeaNRsoKYg7Sq9T/4InzW90Q+1dVA6MOlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luTELeXBvibQ0RmzLz3aNnWoSgAk7o1h7MVe0c79NmZHhx8c2jZGjs9encLBL0397ckeyymvuenT+sjevJ8/cAptHIJ+KY/y1iXb2G03xkELgMG0V3tfZSrGEBF3oEsqrTXLt3Jp936Llu+r3wyRaMyitQse9UATeupDHbnhwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8Nc876h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8Nc876h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBD3C4CECD;
	Tue, 12 Nov 2024 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731410711;
	bh=XlDTTHWw7KeaNRsoKYg7Sq9T/4InzW90Q+1dVA6MOlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8Nc876hSVMqolsakMd1Gkh6Wccb7p8k4FxLNEAUn97iBGzyhQQ1XeLqago7SmQFO
	 o/XuH/idG9vB8UO1eEXHxRvYt692/yV5KMVXtAMypS0ipnb1htnYk/gwbon2EEPMNA
	 CPVqRouPMZUhajExIQaRf4bNQwOu99JaLRuMiZz9Zq1V2TN2MEdr7WwYB+eD9FMLKZ
	 jbtsNySJ9stKtFoolhLwZF8THKTVlNXDBGXQLvuHAs//ljPw3U9378GMw/35rdkbma
	 dYSRGGDin3dmI7Wll9nWmPQ1YN624dP6dNz/hGvVMqYC+Tq4nlhEKSGcRTVg+tg8pa
	 4d24dQDV8TQAA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Wunderlich <linux@fw-web.de>
Cc: Niklas Cassel <cassel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v1 0/3] fix some binding check errors for marvell
Date: Tue, 12 Nov 2024 12:24:56 +0100
Message-ID: <173141034159.1636325.1565605503934630907.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241109094623.37518-1-linux@fw-web.de>
References: <20241109094623.37518-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=748; i=cassel@kernel.org; h=from:subject:message-id; bh=XlDTTHWw7KeaNRsoKYg7Sq9T/4InzW90Q+1dVA6MOlI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKNrTlCF3e+N1BKMmFJVy7sOBErsiZxa9bilTcPbLqfk Fe1pH1HRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZyI5GR4XHrnfi52/kixS36 nlaWPNE53dO1MDrgXNer1681dlbwTGBkWCB2uSh1spehZXMd1y2P7kmMBck3Pxq4zjjOtzwgMeE ZNwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Sat, 09 Nov 2024 10:46:18 +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Thies series fixes some Errors reported by dtbs_check. First part is taken
> from my old series [1] where i converted sata-platform txt binding to yaml
> because it wasn't picked up.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20220311210357.222830-1-linux@fw-web.de/
> 
> [...]

Applied to libata/linux.git (for-6.13), thanks!

[3/3] dt-bindings: ata: ahci-platform: add missing iommus property
      https://git.kernel.org/libata/linux/c/e8a2389e


Assuming that patches 1/3 and 2/3 will go via the Marvell tree:
git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git


Kind regards,
Niklas
