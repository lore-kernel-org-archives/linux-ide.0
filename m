Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757365;
	b=MB/qtQ0D5vXxNu05+euldwq/MZtd8blFsSPOv9nY/M7iTrUjo0ad0buDcBHJ3x6g3s4P
	 sxXB9H/MOagMet7Tkt8rfh6fwIiz1YK8jRtCKse4yUNs1bGe1Gb/iD8QMDxb1V45uRAc5
	 4yaimTQ6JK6gvigajiunAwrvoPsl0q/Cx0BxYYgwRu40eMihwTbzK4GS7+qCasuIRTRpx
	 1iftit3cibpZhLWTqqQmWwbqa/9f7um7NgZNIQNdJN8BNvkzyAvHKA5QHBi5PgivXhSPN
	 U99DqaOEGQl3u3d1wFrAF7bgei2NQsFb75RlEvToMHafeVspOsv+7056YY0LEiKkgzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757365;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=ZQHHJRTk2K/ApYyquLb2H+bdSrgxDB/jh51KP9eMDug=;
	b=aUyEJRe97Q+yODclPWOQUoK14z/poxws6UbtxVeb+FS0bF6oGaFHjN6fnPPOJp8AK78e
	 FuqyX1KEeCpjnpAwi0TnoudX4aBzwyuT7gyoQvAmBvNCJQdaWX2zvCubYbc9zZTrjdnQD
	 2tsPZDNZZWX8vNFa6Yo69/oAQqscFru8nzV3ZYXTeZ6GkfyNpyqIK0/wxX6w00qiIyvgW
	 iAOTZrK1gEYTQRDGx9cFI/0vQHJEZA7iuLc8Q3jC+WGeg7qxgb2OqBg7jRCv8HaPQ8KR4
	 DOIueR42lu5QIZF8cXO53mX7I2H4rcyOXWQYkU+/4frqZzYNdhV2/GCWH8AQ/AsZwYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D536606A31B
	for <linux-ide@vger.kernel.org>; Wed,  4 Nov 2026 01:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D536606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jK7nr6xhRz8Xrrg;
	Wed, 04 Nov 2026 09:56:00 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A41tuf5055552;
	Wed, 4 Nov 2026 09:55:56 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 09:55:57 +0800 (CST)
X-Zmail-TransId: 2af96aea90adfdc-a834f
X-Mailer: Zmail v1.0
Message-ID: <20261104095557598LkOgF6gzz_WNRz5kEQ-xC@zte.com.cn>
In-Reply-To: <aupPouIrF_SkU0jz@ryzen>
References: 202610291903148135Df-fh-xl3zWuRJkq8AXn@zte.com.cn,aupMUrNn7PkrJg6W@ryzen,aupPouIrF_SkU0jz@ryzen
Date: Wed, 4 Nov 2026 09:55:57 +0800 (CST)
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
To: <cassel@kernel.org>
Cc: <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXRhOiBsaWJhdGEtc2NzaTogc2V0IHRoZSBmaWVsZCBwb2ludGVyIHdoZW4gcmVqZWN0aW5nIENETA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A41tuf5055552
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 09:56:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA90B0.001/4jK7nr6xhRz8Xrrg

Hi Niklas,

On Tue, Nov 03, 2026 at 10:18:26PM +0100, Niklas Cassel wrote:
> Sorry, to clarify, 0 would have been wrong anyway, but because of existing
> bugs in ata_scsi_mode_select_xlat() related to fp, not because of your patch
> was wrong:

Understood, and agreed.  With 6/8 passing the whole mode page to the
handler, the offset is the one from the mode page definition: CDL_CTRL is
the first byte after the four-byte mode page header, so fp = 4 is correct.
My 0 only looked consistent with the surrounding code because the handler
still saw the page data without its header.

I also saw that you carried the fix as 7/8 of the series.  That works for
me: I am dropping my standalone patch, so please keep 7/8 as it is and do
not respin it on my account.

Thanks for the clarification and for carrying the fix.

Best regards,
Shao
