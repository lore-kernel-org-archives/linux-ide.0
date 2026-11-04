Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798093;
	b=gqGynOwEEfNiIFYTnb05E424fMo18+f3Xe6KnPjxGsJrIbrXnN0wW06CiLlsx98Rsc1e
	 9jH7iwp9+n2oqtWCTED6FyulWr64YwhnvttAwyLNqbCBo0ysFx7qjmyZ2G+GfNPQwqDUc
	 pii8O5TVlWweO5CECfWMaNnUjtOJahKCFoerCEc2ftb50TExHqhk0Qg0HEAcRvROlopuH
	 kT6/A5FKHP+Of3m8FZieA0tFVjIm+DAp+uIZw9qvGRxutQNfxdUeQJbQzv0ClHxEogkr5
	 6AUAUimaUKv9lPTzDM5ApaXY0jjtpjatxwTjfA4Wx69/78KExsfFi70+0XtUPBXqh3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798093;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=DxT2ZLUeW2NIbDjvztXpHdeBzgiR/nP0952gzwh2P3E=;
	b=Bt76J/OnMZ2zPfFmQ58vpH8qCQEThZxPD49i09Dq54T6h24YFy+plfN2ihKdpy4UPSAq
	 sQ4zXrhygmoE6mXnA+4qv9GnNbRR9dcc3SdGdc57lxtkdgdKpx9c1HjwE7shbNjOd4A/5
	 Laf+2DCcbcSflaFzxmwujRWfoalBrrESXy9jjo+tcAqRz4PfPbIoKUeA2U/qJAzi3lFnb
	 WrhRBnxDMtyH9cNkthr0XLLn95jG18mZbzFGfi591nGMwGJx7EZ3Dy+4TNtfxPkN+jXl0
	 TeXgalKRNZ7PR1RWlOchb0Rdv/bgP882VBpu5y9/fHi451G/+5l/8/PV9bimkh39csQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECFB606A330;
	Wed,  4 Nov 2026 13:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ECFB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jKQrq5lnKz57HS1;
	Wed, 04 Nov 2026 21:14:35 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A4DEU0V088196;
	Wed, 4 Nov 2026 21:14:30 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 21:14:32 +0800 (CST)
X-Zmail-TransId: 2afa6aeb2fb827b-f71a2
X-Mailer: Zmail v1.0
Message-ID: <20261104211432688UOs4v84BESagMmLFH30Er@zte.com.cn>
Date: Wed, 4 Nov 2026 21:14:32 +0800 (CST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <hansg@kernel.org>,
        <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvM10gYXRhOiByZW1vdmUgZGVhZCBjaGVja3MgYW5kIHJlZHVuZGFudCBjb2Rl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A4DEU0V088196
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 21:14:35 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB2FBB.000/4jKQrq5lnKz57HS1

This series removes two checks that the surrounding code already
guarantees and folds five duplicated cleanup paths in
zpodd_get_mech_type() into one.  It was found while reading libata.
There is no functional change intended; every patch is independent and
can be applied on its own or as any subset.

Patch 1 drops a test that is constant-false at compile time.
SATA_PMP_GSCR_DWORDS is 128, so "SATA_PMP_GSCR_DWORDS & 3" is zero and
the loop already terminates every fourth dword with a newline.

Patch 2 drops a dead rc check in ahci_platform_get_resources().  The
branch is only entered when IS_ERR() is true, so PTR_ERR() is negative
and "rc != 0" always holds.

Patch 3 rewrites zpodd_get_mech_type() to use one exit label instead of
five "kfree(buf); return ..." pairs.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
