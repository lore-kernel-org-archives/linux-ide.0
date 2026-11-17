Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921943;
	b=zGCrYW7IkgtfoXfJLhoFsLzPGeUL24MBCl9WYE6iP0AICUPKc02b+w3F/6trH2MbmtiP
	 GehvnCBWOm4HXyfKAa+ZtbKt8RndeFjEX1/yXNoPBRdV5DDBZjjO3JW+f3sOq5tKMasau
	 slMd5F6WrF+ihiMW25IXA5Xyt8WDto+1rtA9WJY9uZFAiav5mXVHe7gfW3PE4br7iBOTu
	 qVLBHQKBSMXHngxj9eWWTEl1W2epkB5M+2GDW4s50R7M3Z0h/n6mbrv3jjc1hW49nUg7e
	 7YdpTrAyVMPnFof0SBqfXW4SB2jMQbVYi+xt3+vvjb9OwEvp5KbmUG2eexcJh/ddOiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921943;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=iSb/v1zYs8p1HSbeyXVMJ2Yw64KBQQw7WUT+uYE4SlE=;
	b=Y8S2jiCfcMhroM8r+w1lW8q3ZoWKqyFEarraNWWMcWZLMvUqmTxd2BfMufwQ1CJ6FOsD
	 hVlS/F12Kfpw5dxGXpFzZLZeQTWfVEBQXmpzXrQA91CIpYkt49WQl2+nsvNpiThDp96yy
	 6q8iWuT9Qg44PKLYwS1+2WKNWrrESfmIQJlOliViwvxhGCjK5rCVy+tBhbJOwi27HOBVr
	 Qt89v7n4+HN/X91QSTVKrFEmoOsRA+J/4rKC1TN4g9RcK6OvbWeHE4W6nXd0ENtz3L4wx
	 XHX+z3kQObSAFSWJ9lRcKr4ot4LZePrAR1J67mb6hXRQL2SD03vGmc9hNXw0jP/JOgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijn4NomM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39CE606A323
	for <linux-ide@vger.kernel.org>; Tue, 17 Nov 2026 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijn4NomM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03321F000C4;
	Tue, 17 Nov 2026 13:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794921943;
	bh=iSb/v1zYs8p1HSbeyXVMJ2Yw64KBQQw7WUT+uYE4SlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ijn4NomMUkWiUV7lV5d2juSDlZxmzsFtOptdy5g3V3GkLsV4NgHaE3FXXAKIfGJAe
	 s6uKOPxNmtbb5Y805lSUD5zUPLgfAKh6TgSgD8SNwYaTUDJcczgzfo4FiGqwuhGshn
	 bLlIlq7zPII0pz6M75SInHDftHLEwwBdr1z3XjZZPWrm5LH3/dGREEtnLxnh4bkCn2
	 iy6b7Il1bnngOhc3UYhNWKXHQXgOSzPSXO9iUWoEjpSCt5JqGmoVjzTlEaYhUZP7uE
	 1/PpH5azsd6ysLX0888z3gZdJGI4VF3X9vBmH6Taqrgz6EaZ0s4d3mvOijPH2hNko4
	 NbWM0Pt+cBbog==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
In-Reply-To: <20261117130238.3472718-2-cassel@kernel.org>
References: <20261117130238.3472718-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-core: remove two WDC BROKEN_HPA quirks
 that never match
Message-Id: <179492194257.3479490.1921940477268272673.b4-ty@kernel.org>
Date: Tue, 17 Nov 2026 14:25:42 +0100
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 17 Nov 2026 14:02:39 +0100, Niklas Cassel wrote:
> The second field of a __ata_dev_quirks[] entry is matched against the
> firmware revision of the device, which ata_dev_quirks() reads into a
> buffer of ATA_ID_FW_REV_LEN (8) characters. The ATA_QUIRK_BROKEN_HPA
> entries for "WDC WD3200JD-00KLB0" and "WDC WD2500JD-00HBB0" instead
> contain "WD-WCAMR1130137" and "WD-WMAL71490727", which look like drive
> serial numbers. Without wildcards, these 15 character patterns can never
> match a firmware revision, so the two entries have not applied to any
> drive since they were added in commit 16c55b038033 ("libata: implement
> BROKEN_HPA horkage and apply it to affected drives").
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: libata-core: remove two WDC BROKEN_HPA quirks that never match
      https://git.kernel.org/libata/linux/c/3391ac40

Kind regards,
Niklas

