Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC75028851F;
	Thu, 16 Oct 2025 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595585; cv=none; b=TBIqvaa/lYq63r7TXhwweGivn81SYnCk0/pkXsQ1QWtstKaIbLvDCjsLO3bqFUl2GAYrlL0tpC6i19/gVezfC5OvtEve94YSyb0tlWv7R1FeAkghfnbt91GtxrwmlyN5noOGFbfxscQcekFHYsWYOfmKBdxw14mOod2PmDWK+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595585; c=relaxed/simple;
	bh=RR0UzflW7cJ/5piPBcCWUDW7t/cm9hmbuIFiuPMMky4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=l4W+b/OAQepmT/8uBQmmq56WsVIqi+/j3PYTzy7o3IpIr9Cj0Q8tZo+plgX7VQJxqhenYPDTlXp2JaNyDfo0CMyrEBlVFL8cPRRhwcPwq0F2LqxCiGGGEqWcVS9OMsp3bHiIXm9I7JBzT60Aw5q+Thj9LlEGvkziOY4D5k9gJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from luyulin$eswincomputing.com ( [10.12.96.77] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 16 Oct 2025 14:19:25 +0800 (GMT+08:00)
Date: Thu, 16 Oct 2025 14:19:25 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yulin Lu" <luyulin@eswincomputing.com>
To: dlemoal@kernel.org, cassel@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org
Cc: ningyu@eswincomputing.com, zhengyu@eswincomputing.com,
	linmin@eswincomputing.com, huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com, lianghujun@eswincomputing.com
Subject: Re: [PATCH v5 0/3] Add driver support for Eswin EIC7700 SoC SATA
 Controller and PHY
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20250930083754.15-1-luyulin@eswincomputing.com>
References: <20250930083754.15-1-luyulin@eswincomputing.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6399b000.1dc.199ebac5daf.Coremail.luyulin@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAXt5VujvBoAvINAQ--.27874W
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/1tbiAQERA2jvzH0SZQAB
	sS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgYWxsLAoKR2VudGxlIHBpbmcuCkNvdWxkIHlvdSBwbGVhc2UgcmV2aWV3IHRoZSBQSFktcmVs
YXRlZCBjaGFuZ2VzIGluIHBhdGNoIDIvMyBhbmQgcGF0Y2ggMy8zPwpUaGFua3MgaW4gYWR2YW5j
ZSBmb3IgeW91ciB0aW1lIGFuZCBjb25zaWRlcmF0aW9uLgoKQmVzdCByZWdhcmRzLApZdWxpbiBM
dQoKPiAKPiBUaGlzIHNlcmllcyBkZXBlbmRzIG9uIHRoZSBjb25maWcgb3B0aW9uIHBhdGNoIFsx
XS4KPiAKPiBbMV0gSHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvbmV4dC9saW51eC1uZXh0LmdpdC9jb21taXQvP2g9bmV4dC0yMDI1MDkyOSZpZD1jZTJkMDBj
NmUxOTJiNTg4ZGRjM2QxZWZiNzJiMGVhMDBhYjU1MzhmCj4gCj4gVXBkYXRlczoKPiAgIHY1IC0+
IHY0Ogo+ICAgICAtIGVzd2luLGVpYzc3MDAtYWhjaS55YW1sCj4gICAgICAgLSBBZGQgImR0LWJp
bmRpbmdzOiBhdGE6IiBwcmVmaXggdG8gdGhlIHN1YmplY3QuCj4gICAgICAgLSBXcmFwIGF0IDgw
IGNoYXJhY3RlcnMgaW4gdGhlIFlBTUwgZGVzY3JpcHRpb24gZmllbGQuCj4gICAgIC0gTGluayB0
byB2NDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI1MDkxNTEyNTkwMi4zNzUtMS1s
dXl1bGluQGVzd2luY29tcHV0aW5nLmNvbS8KPiAKPiBZdWxpbiBMdSAoMyk6Cj4gICBkdC1iaW5k
aW5nczogYXRhOiBlc3dpbjogRG9jdW1lbnQgZm9yIEVJQzc3MDAgU29DIGFoY2kKPiAgIGR0LWJp
bmRpbmdzOiBwaHk6IGVzd2luOiBEb2N1bWVudCB0aGUgRUlDNzcwMCBTb0MgU0FUQSBQSFkKPiAg
IHBoeTogZXN3aW46IENyZWF0ZSBlc3dpbiBkaXJlY3RvcnkgYW5kIGFkZCBFSUM3NzAwIFNBVEEg
UEhZIGRyaXZlcgo+IAo+ICAuLi4vYmluZGluZ3MvYXRhL2Vzd2luLGVpYzc3MDAtYWhjaS55YW1s
ICAgICAgfCAgNzkgKysrKysrKwo+ICAuLi4vYmluZGluZ3MvcGh5L2Vzd2luLGVpYzc3MDAtc2F0
YS1waHkueWFtbCAgfCAgMzYgKysrKwo+ICBkcml2ZXJzL3BoeS9LY29uZmlnICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDEgKwo+ICBkcml2ZXJzL3BoeS9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDEgKwo+ICBkcml2ZXJzL3BoeS9lc3dpbi9LY29uZmlnICAgICAg
ICAgICAgICAgICAgICAgfCAgMTQgKysKPiAgZHJpdmVycy9waHkvZXN3aW4vTWFrZWZpbGUgICAg
ICAgICAgICAgICAgICAgIHwgICAyICsKPiAgZHJpdmVycy9waHkvZXN3aW4vcGh5LWVpYzc3MDAt
c2F0YS5jICAgICAgICAgIHwgMTkyICsrKysrKysrKysrKysrKysrKwo+ICA3IGZpbGVzIGNoYW5n
ZWQsIDMyNSBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXRhL2Vzd2luLGVpYzc3MDAtYWhjaS55YW1sCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L2Vzd2lu
LGVpYzc3MDAtc2F0YS1waHkueWFtbAo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkv
ZXN3aW4vS2NvbmZpZwo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkvZXN3aW4vTWFr
ZWZpbGUKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGh5L2Vzd2luL3BoeS1laWM3NzAw
LXNhdGEuYwo+IAo+IC0tIAo+IDIuMjUuMQo=
