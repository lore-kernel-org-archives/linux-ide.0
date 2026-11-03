Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707160;
	b=l9fsI6kcdorstxM3hPr1iHcAponkWdm2ppT8Kn22VdqB7rDCEbLsqeNnfRSnMFvGs48O
	 S7eqlcqDEmWf7di0yESPrP/IWiNTq09osl+Qpfj2NEtlH0O9J7vCag4emllCqb0FNcr8H
	 1WlP1YEw8rveiBuYkq8XSbPj9UY8jAwLJ1a3+MqJoaufiFN0nijKQVnrH4E98LjlAwBAX
	 aYKv2bRnAkoxytdFBQo/lBFqI+0XGQrJOK/tVwVCVVZTWOG4IDNdYWZyVdsY2Wi2tgci1
	 i+D4FHlNdva1vGEOXMB1EmzhPVUB0XvQaU/30kmC+v4+zDcFj/NNY/BEltUXc7QL66g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707160;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=QdiQxeuZdR2NFe4vs9IUq6UmiGzYNXC1G+HPFNcf42Q=;
	b=b7xtLpazO302G4Gpfu2Pyv6+AYFGLIh5VeoUuOxvyzcNcrSYaQaxw4Onr+MPWQehRdjx
	 RCSOQQQEjT+fMvOEDSZFMZ5wHWcfCd+Zy26klg/GByVFzXI8YQ5w2HGtw3ADFoPOTneJA
	 04a0xvs0bqmbYPTemue0bmwGMuIy0x7bHucQEqEzEzvSbgHEGTfMCWn9cO9VC3s2vL5EJ
	 auUnQWXmre0XFSmExDd/Xs55d8nzxpqjdwAje2rcwXi5ENdhMvCR0gwp/4W1NKhUd2BRe
	 926hEDFCKmTV4Q3rpE9tOnZs/XBPkNM1xqPisnJHfHodWFBk9TMDxBJmetq1ockluGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26D606A327
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 11:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D26D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJnDN3bNJz5B103;
	Tue, 03 Nov 2026 19:59:16 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A3Bx6qF011131;
	Tue, 3 Nov 2026 19:59:07 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 3 Nov 2026 19:59:09 +0800 (CST)
X-Zmail-TransId: 2afa6ae9cc8d5ce-15cd0
X-Mailer: Zmail v1.0
Message-ID: <20261103195909777Ka0kj46-6HT1fVak-hNq9@zte.com.cn>
In-Reply-To: <sashiko-outbox-195104@kernel.org>
References: 20261103185346937YqEZr3t5lq7FdnTzM3-TY@zte.com.cn,sashiko-outbox-195104@kernel.org
Date: Tue, 3 Nov 2026 19:59:09 +0800 (CST)
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
To: <linux-ide@vger.kernel.org>
Cc: <sashiko-bot@kernel.org>, <dlemoal@kernel.org>, <cassel@kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXRhOiBsaWJhdGEtc2NzaTogYXZvaWQgUkVBRCBDQVBBQ0lUWSAxNiB1bmRlcmZsb3c=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A3Bx6qF011131
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 03 Nov 2026 19:59:16 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE9CC94.000/4jJnDN3bNJz5B103

You are right, and thanks for catching it.  Please drop this patch.

The underflow to 0xffff_ffff_ffff_ffff is what keeps the capacity at
zero: sd_read_capacity_16() computes sdkp->capacity = lba + 1, so the
value wraps before it reaches the block layer, and the "8 ZiB" in my
changelog was wrong for the same reason.  Reporting 0 turns a locked
drive into a one block disk and brings the partition scan back.

Sorry about the noise.
