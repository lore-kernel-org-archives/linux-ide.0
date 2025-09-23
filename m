Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5BD1DDA09;
	Tue, 23 Sep 2025 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596941; cv=none; b=nVh6BKzJenooXh/zKF0iOYHd8G+PfA/JHhiBYhhvP4xS9g+sjtToVBmpqJ4h6uv66EIZDcF/uKIY72fAU/a8ibKrBoPjNcbn6vvjw2ZmBN7qYGrObc004NG8Wogz64ZCebC3EFGGkZIL7umdFyedrYdcvKhXVd1PPpdb0jWrAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596941; c=relaxed/simple;
	bh=XVWhz4F8cmF1+0bnKhnlPRE2MY7x3XEFc8K9dNdbvtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=rirCPgXDbkpZIk8jJu+W2FJp2pdTQ+mUaE4LHYHwnx9TZ92vaAmCBZjQnQiTxr/B/7o5zQPP0piseW670vuV+RMFf7QuBehc8nUUxdGcJluByDYiL0qLqdbpZysHXt0RgqCh0x7pAp+mEPdyoyoMIsz1UiX2Jkq7pw1Qs/BJX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from luyulin$eswincomputing.com ( [10.12.96.77] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 23 Sep 2025 11:08:48 +0800 (GMT+08:00)
Date: Tue, 23 Sep 2025 11:08:48 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: luyulin@eswincomputing.com
To: "Rob Herring" <robh@kernel.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
	ningyu@eswincomputing.com, zhengyu@eswincomputing.com,
	linmin@eswincomputing.com, huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com, lianghujun@eswincomputing.com
Subject: Re: Re: [PATCH v4 1/3] Document the EIC7700 SoC sata ahci
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20250922161140.GA150852-robh@kernel.org>
References: <20250915125902.375-1-luyulin@eswincomputing.com>
 <20250915130135.1497-1-luyulin@eswincomputing.com>
 <20250922161140.GA150852-robh@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <42166db3.16e4.199748b931d.Coremail.luyulin@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgA31pRAD9Jo0tvXAA--.25586W
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/1tbiAgEOA2jRelQTUQAA
	sb
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGksIFJvYiBIZXJyaW5nCgpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IGFuZCBjb21tZW50cy4K
PiAKPiBPbiBNb24sIFNlcCAxNSwgMjAyNSBhdCAwOTowMTozNVBNICswODAwLCBZdWxpbiBMdSB3
cm90ZToKPiA+IERvY3VtZW50IHRoZSBTQVRBIEFIQ0kgY29udHJvbGxlciBvbiB0aGUgRUlDNzcw
MCBTb0MgcGxhdGZvcm0sCj4gPiBpbmNsdWRpbmcgZGVzY3JpcHRpb25zIG9mIGl0cyBoYXJkd2Fy
ZSBjb25maWd1cmF0aW9ucy4KPiAKPiBQbGVhc2UgZml4IHRoZSBzdWJqZWN0OiAiZHQtYmluZGlu
Z3M6IGF0YTogLi4uIgo+IAoKSSBwcmV2aW91c2x5IG5vdGljZWQgdGhpcyBzdWJqZWN0IGlzc3Vl
LCB0aGVuIHJlc3VibWl0dGVkIHY0CmFuZCBleHBsYWluZWQgdGhlIHJlYXNvbiBpbiB0aGUgY292
ZXIgbGV0dGVyLgpUaGUgbGlua3MgdG8gdGhlc2UgcGF0Y2hlcyBhcmU6Cmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvMjAyNTA5MTUxMzUxMzguODc3LTEtbHV5dWxpbkBlc3dpbmNvbXB1dGlu
Zy5jb20vCgo+ID4gCi4uLgo+ID4gK2Rlc2NyaXB0aW9uOgo+ID4gKyAgQUhDSSBTQVRBIGNvbnRy
b2xsZXIgZW1iZWRkZWQgaW50byB0aGUgRUlDNzcwMCBTb0MKPiA+ICsgIGlzIGJhc2VkIG9uIHRo
ZSBEV0MgQUhDSSBTQVRBIHY1LjAwYSBJUCBjb3JlLgo+IAo+IFdyYXAgYXQgODAgY2hhcnMuCj4g
CgpUaGFua3MsIEkgd2lsbCBmaXggaXQgaW4gdGhlIG5leHQgcGF0Y2guCgo+ID4gKwouLi4KPiA+
IC0tIAo+ID4gMi4yNS4xCj4gPiAKQmVzdCByZWdhcmRzLApZdWxpbiBMdQo=
