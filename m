Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDB5393DD1;
	Tue, 26 Aug 2025 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178655; cv=none; b=RwwtoJGQY6m0UICOxU3d18YznMNI2b+dQAVu0ADGQVsbbDCfzFJrw+XeXUfq403TSvT+T19Lqxlz1F3k+pdkvYheL/1nSkffMSgOmTuV19PW4U3pkXpTmzb0IBAjb9mzQ/KAdud3Kb2Ojzw564CLZamiEaqn+/yNNHkz0qTg9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178655; c=relaxed/simple;
	bh=aXzpDQbc0d3NKnBRl7lRsprIHKBsoXUaHwCtoysIoIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=iMknVbblep8SIeflGHV1HWc1qWCGh8oTXV5EkDaOgShbVE7fxl1R34Us4pDuaJQykBqI475/pL0dHD18HXZDCGA6APPiuyaQ9CuDTpuYMtlvfjZtXIKfodmdkznheBbrcmBDjk5/H5gh9Gk/rGtJlMkIY4QsgmlXAzTCtQxfTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from luyulin$eswincomputing.com ( [10.12.96.77] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 26 Aug 2025 11:23:57 +0800 (GMT+08:00)
Date: Tue, 26 Aug 2025 11:23:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: luyulin@eswincomputing.com
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
	ningyu@eswincomputing.com, zhengyu@eswincomputing.com,
	linmin@eswincomputing.com, huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com, lianghujun@eswincomputing.com
Subject: Re: Re: [PATCH v2 2/3] dt-bindings: phy: eswin: Document for
 EIC7700 SoC SATA PHY
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20250821-precise-delightful-lyrebird-6b4275@kuoka>
References: <20250819134722.220-1-luyulin@eswincomputing.com>
 <20250820092758.803-1-luyulin@eswincomputing.com>
 <20250821-precise-delightful-lyrebird-6b4275@kuoka>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3fd6740d.6d3.198e4676278.Coremail.luyulin@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDHZpXNKK1oArvDAA--.23274W
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/1tbiAQEGA2isj-USPQAA
	sU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGksCktyenlzenRvZgoKSSBhcG9sb2dpemUgZm9yIGluY29ycmVjdGx5IGZpbGxpbmcgaW4gdGhl
ICJJbi1SZXBseS1UbyIgZmllbGQKd2hlbiBJIGZpcnN0IHNlbnQgdGhpcyBwYXRjaCwgd2hpY2gg
Y2F1c2VkIGl0IHRvIGxvc2UgYXNzb2NpYXRpb24Kd2l0aCB0aGUgb3RoZXIgcGF0Y2hlcy4KQXMg
YSByZXN1bHQsIEkgaGF2ZSByZXNlbnQgdGhpcyBwYXRjaC4KQ291bGQgeW91IHBsZWFzZSBoZWxw
IHJldmlldyB0aGUgb3RoZXIgcGF0Y2hlcyBpbiB0aGlzIHBhdGNoIHNlcmllcyBhZ2Fpbj8KVGhl
IGxpbmsgdG8gdGhlIGNvdmVyIGxldHRlciBmb3IgdGhpcyBwYXRjaCBzZXJpZXMgaXM6Cmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNTA4MTkxMzQ3MjIuMjIwLTEtbHV5dWxpbkBlc3dp
bmNvbXB1dGluZy5jb20vClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgcmV2aWV3IHN1Z2dl
c3Rpb25zIQo+IAo+IE9uIFdlZCwgQXVnIDIwLCAyMDI1IGF0IDA1OjI3OjU4UE0gKzA4MDAsIFl1
bGluIEx1IHdyb3RlOgo+ID4gQWRkIGRvY3VtZW50IGZvciB0aGUgU0FUQSBwaHkgb24gdGhlIEVJ
Qzc3MDAgU29DIHBsYXRmb3JtLAo+ID4gZGVzY3JpYmluZyBpdHMgdXNhZ2UuCj4gPiAKPiA+IFNp
Z25lZC1vZmYtYnk6IFl1bGluIEx1IDxsdXl1bGluQGVzd2luY29tcHV0aW5nLmNvbT4KPiAKPiBZ
b3UgYWxyZWFkeSBzZW50IHRoaXMgcGF0Y2ggc2VwYXJhdGVseSAoISEhKSBhbmQgcmVjZWl2ZWQg
cmV2aWV3Lgo+IAo+IEJlc3QgcmVnYXJkcywKPiBLcnp5c3p0b2YKCkJlc3QgcmVnYXJkcywKWXVs
aW4K
