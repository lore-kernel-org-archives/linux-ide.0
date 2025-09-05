Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496BD258CE9;
	Fri,  5 Sep 2025 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057021; cv=none; b=Lc0HfWHTIj48PBUoCVNGuC7PLjCyt9Gg7hDuTL2MMwJ0/ZMX4fyMtNo2YSBS9XP4PtBsRj0rSNicBhfPxmMTG5j8mIQ69u1hPtces+0NVmD7LRXPHgoBDDtaZXuVzy/CnIVB1oxlkNFgKQqraiAd4oXd9UH52BFzK/kR8gbAmiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057021; c=relaxed/simple;
	bh=G03JThKW//Mso9KiVsolwbOmJ/ab7j3QoS6w0nXIjLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=CvQxkt8+95UglgY+xkmx+xiitEIoxJDRDZwinc2Fy46WW9NdIScYisWrZgkoMUOmMYI5mrcErzAbIAcZIOnjxzrsTrPdbGdKlkwVe0QCtZ8JjH2lPiVAs7p1Xkl7tbjCXM22Tfes6T/xicP0QoHzRD6F5i1qGJDjYq46Uh2dh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from luyulin$eswincomputing.com ( [10.12.96.77] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 5 Sep 2025 15:23:20 +0800 (GMT+08:00)
Date: Fri, 5 Sep 2025 15:23:20 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: luyulin@eswincomputing.com
To: "Krzysztof Kozlowski" <krzk@kernel.org>, cassel@kernel.org,
	robh@kernel.org
Cc: "Niklas Cassel" <cassel@kernel.org>, dlemoal@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
	ningyu@eswincomputing.com, zhengyu@eswincomputing.com,
	linmin@eswincomputing.com, huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com, lianghujun@eswincomputing.com
Subject: Re: Re: [PATCH v3 1/3] dt-bindings: ata: eswin: Document for
 EIC7700 SoC ahci
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <5f6bc8da-ac78-4f21-8f9f-c84f213f60a9@kernel.org>
References: <20250904063427.1954-1-luyulin@eswincomputing.com>
 <20250904063718.421-1-luyulin@eswincomputing.com>
 <8489c13b-6810-480c-9894-bb5c80cfbde0@kernel.org> <aLlYkZWBaI5Yz6fo@ryzen>
 <5f6bc8da-ac78-4f21-8f9f-c84f213f60a9@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7206383a.d98.19918c22570.Coremail.luyulin@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAXt5Xoj7poDeXIAA--.24640W
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/1tbiAgEQA2i5v1ESawAB
	sX
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gS3J6eXN6dG9mLCBOaWtsYXMsIFJvYiwKClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlv
dXIgc3VnZ2VzdGlvbnMgYW5kIHJlcGx5LgoKPiAKPiBPbiAwNC8wOS8yMDI1IDExOjE0LCBOaWts
YXMgQ2Fzc2VsIHdyb3RlOgo+ID4gSGVsbG8gS3J6eXN6dG9mLCBSb2IsCj4gPiAKPiA+IE9uIFRo
dSwgU2VwIDA0LCAyMDI1IGF0IDA5OjEwOjM0QU0gKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6Cj4gPj4+ICsKPiA+Pj4gKyAgcG9ydHMtaW1wbGVtZW50ZWQ6Cj4gPj4+ICsgICAgY29u
c3Q6IDEKPiA+Pgo+ID4+IEkgZG8gbm90IHNlZSBob3cgeW91IGFkZHJlc3NlZCByZXF1ZXN0IGFi
b3V0IGZpcm13YXJlLiBOb3RoaW5nIGNoYW5nZWQKPiA+PiBoZXJlLCBubyBleHBsYW5hdGlvbiBp
biB0aGUgY29tbWl0IG1zZy4KPiA+IAoKLi4uCgo+ID4gCj4gPiBBbnl3YXksIEkgcHJvdmlkZWQg
bXkgNTAgY2VudHMgaGVyZToKPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlkZS9h
TEJVQzExNk1kSnFER0lKQGZsYXdmdWwub3JnLwo+ID4gCj4gPiAoSSB3b3VsZCBsaWtlIHRvIGFk
ZCB0aGF0IEkgdGhpbmsgaXQgaXMgdGhlIGRpc2FibGluZyBvZiBjbG9ja3MgYW5kCj4gPiByZWd1
bGF0b3JzIHRoYXQgY2F1c2VzIHRoZSByZWdpc3RlciB0byBiZSBjbGVhcmVkLCBzaW5jZSB3ZSBk
byBjYWxsCj4gPiBhaGNpX3BsYXRmb3JtX2Fzc2VydF9yc3RzKCkgZHVyaW5nIHRoZSBmaXJzdCBw
cm9iZSwgc28gaWYgaXQgd2FzIHRoZSByZXNldAo+ID4gdGhhdCBjbGVhcmVkIHRoZSByZWdpc3Rl
ciwgdGhlIGZpcnN0IHByb2JlIHNob3VsZCBhbHNvIG5vdCBoYXZlIHdvcmtlZC4pCj4gPiAKClRo
YW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgZXhwbGFuYXRpb24uIFRvIGFkZCBzb21lIGNvbnRl
eHQ6CkluIG91ciBzeXN0ZW0sIHRoZcKgcG9ydHMtaW1wbGVtZW50ZWTCoHJlZ2lzdGVyIGhhcyBh
bHJlYWR5IGJlZW4gY29uZmlndXJlZCBieSB0aGUgZmlybXdhcmUKKHdoaWNoIGlzIFUtQm9vdCBv
biB0aGUgSGlGaXZlIFByZW1pZXIgUDU1MCBib2FyZCkuClRoZXJlZm9yZSwgd2hlbiBlbnRlcmlu
Z8KgdGhlIGtlcm5lbCwgdGhlIHZhbHVlIG9mIHRoaXMgcmVnaXN0ZXIgaXMgY29ycmVjdGx5IHNl
dCB0byAweDEuCgpEdXJpbmcgcHJvYmUswqBhaGNpX3BsYXRmb3JtX2VuYWJsZV9yZXNvdXJjZXPC
oOKGksKgYWhjaV9wbGF0Zm9ybV9kZWFzc2VydF9yc3RzwqBpcyBjYWxsZWQuCkFuZCB3aGVuIHRo
ZSBkcml2ZXIgaXMgcmVtb3ZlZCzCoGFoY2lfcGxhdGZvcm1fZGlzYWJsZV9yZXNvdXJjZXMK4oaS
wqBhaGNpX3BsYXRmb3JtX2Fzc2VydF9yc3RzwqBpcyB0cmlnZ2VyZWQuClRoaXMgcmVzZXQgb3Bl
cmF0aW9uIGNhdXNlcyB0aGUgcmVnaXN0ZXIgdG8gYmUgcmVzdG9yZWQgdG8gMC4KQWNjb3JkaW5n
IHRvIHRoZSBJUCBkYXRhYm9vaywgdGhpcyByZWdpc3RlciBpcyBpbmRlZWQgc2V0IHRvIDAgYWZ0
ZXIgcmVzZXQuCgpUaGlzIGlzIG15IHVuZGVyc3RhbmRpbmcuIEknZCBncmVhdGx5IGFwcHJlY2lh
dGUgaXQgaWYgeW91IHBvaW50IG91dCBhbnkgaXNzdWVzLgoKPiA+IAo+ID4gTm90IHN1cmUgaWYg
aXQgcmVsZXZhbnQgdG8gbWVudGlvbiB0aGlzIHJlcGx5IHRvIFJvYidzIHJldmlldyBjb21tZW50
IGluIHRoZQo+ID4gY29tbWl0IG1lc3NhZ2UsIGJ1dCBwZXJoYXBzIGl0IHNob3VsZCBoYXZlIGJl
ZW4gbWVudGlvbmVkIGluIHRoZSBjaGFuZ2UgbG9nLgo+IAo+IFJldmlld2VyIHF1ZXN0aW9ucyBm
b3IgbW9yZSBzZXJpb3VzIHN0dWZmIGhhcHBlbiBmb3IgYSByZWFzb24sIHNvIHdoZW4KPiBkaXNj
dXNzaW9uIGlzIHJlc29sdmVkIHNvbWVob3cgZGlmZmVyZW50bHkgdGhhbiByZXZpZXdlciBzdWdn
ZXN0ZWQsIGl0Cj4gcHJldHR5IG9mdGVuIGRlc2VydmVzIGV4cGxhbmF0aW9uIGluIGNvbW1pdCBt
c2cuCj4gCj4gV2VsbCwgaW4gY2hhbmdlbG9nIGFzIGFic29sdXRlIG1pbmltdW0uIE5vIGV4cGxh
bmF0aW9uIGhhcHBlbmVkIGhlcmUgaW4KPiB0aGUgY2hhbmdlbG9nLCBub3IgaW4gdGhlIGNvbW1p
dCBtc2cuCgpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHN1Z2dlc3Rpb24uCkknbGwgYWRk
IGV4cGxhbmF0aW9ucyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgYW5kIGNoYW5nZWxvZ3MgZm9yIHRo
ZSBuZXh0IHBhdGNoLgoKQmVzdCByZWdhcmRzLApZdWxpbgo=
