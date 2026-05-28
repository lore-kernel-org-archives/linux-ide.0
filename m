Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71D5477E;
	Thu, 28 May 2026 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947883; cv=none; b=m01qGzacpRbbcdQal5uZ+aa300qljOqfGxWsuBLU8fSM2f80S06aNr0FMgCkRp7QFVzfIs/CdtFExuiIerwBrNAyK0ArpFnFV9HPhdHjLPDJT9obmLfFaTj35ajcRjyFJXxkIWhJoZxlj+Ibq0eOVPtj7FZaMN+hHBLkIL4R9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947883; c=relaxed/simple;
	bh=mA/6LUsDIkO5ykclnr9YeEcCnz77qYZIakSjVTfRcHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=q0jISdqi7EBgdsq27wBGOi22vA5xPdCEQi3RXJbL/N1k/og53HwRPHR1E+Bm20RKSdkzBC1lmB25EePI1pLbcAfOJLriI1Zjxhk9up6mY//Iw5t+yDV0Thp5MW3vVmIbHBM84lhl5MQOVnoxkb0IbxmbDjLyt+ZIFaOuzDZyCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VW7ATB3m; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VW7ATB3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=mA/6LUsDIkO5ykclnr9YeEcCnz77qYZIakSjVTfRcHE=; b=V
	W7ATB3mD6T0rOhUI63P6YcAy5yfBv8OM/7smHqEBnGiMNmIVYgT2em59GxIqMIpl
	rA/PSATqtiqwyrp6ezjp7ts/J8JWp9rQPGDPnq/bZfflvHjiSwt3I8IvXY1G1rE0
	SHfw1RRCgsV1UsoFkpiFheE2CzuvRhu4Ws3tO0Ai7k=
Received: from kensanya$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-112 (Coremail) ; Thu, 28 May 2026 13:57:39 +0800
 (CST)
Date: Thu, 28 May 2026 13:57:39 +0800 (CST)
From: kensanya  <kensanya@163.com>
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, TanZheng <tanzheng@kylinos.cn>
Subject: Re:Re: [PATCH] ahci: use hweight_long() to count port_map bits
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <ca92885c-0a61-4574-9136-bed6596dd72a@kernel.org>
References: <20260527091729.266582-1-kensanya@163.com>
 <cd21e56b-04de-4b29-bc4a-d936ac8d29bb@kernel.org>
 <ca92885c-0a61-4574-9136-bed6596dd72a@kernel.org>
X-NTES-SC: AL_Qu2cC/WfuEAu7yCaZukcnkcTg+k8WMW1ufsg2Ydec/gEqgToxyEnckByMFHp/sm2FjGVtSqPcz1W89RYd4VmWLNnBWPor0NWE3sOlhGh1g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <707006bc.4805.19e6d28ec5b.Coremail.kensanya@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cCgvCgD3B2pU2Rdq2l2tAA--.10567W
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbC6RTrx2oX2VRHdAAA3S
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDI2LTA1LTI4IDEzOjI3OjE1LCAiRGFtaWVuIExlIE1vYWwi
IDxkbGVtb2FsQGtlcm5lbC5vcmc+IHdyb3RlOgo+T24gNS8yOC8yNiAwMzoxOCwgRGFtaWVuIExl
IE1vYWwgd3JvdGU6Cj4+IE9uIDIwMjYvMDUvMjcgMTg6MTcsIGtlbnNhbnlhQDE2My5jb20gd3Jv
dGU6Cj4+PiBGcm9tOiBUYW5aaGVuZyA8dGFuemhlbmdAa3lsaW5vcy5jbj4KPj4+Cj4+PiBSZXBs
YWNlIHRoZSBvcGVuIGxvb3AgdXNlZCB0byBjYWxjdWxhdGUgdGhlIG51bWJlciBvZiBzZXQgYml0
cwo+Pj4gaW4gdGhlIHBvcnQgbWFwcGluZyB3aXRoIHRoZSBgaHdlaWdodF9sb25nKClgIGZ1bmN0
aW9uLCB3aGljaAo+Pj4gc2ltcGxpZmllcyB0aGUgY29kZSB3aXRob3V0IGFsdGVyaW5nIGl0cyBm
dW5jdGlvbmFsaXR5Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFRhblpoZW5nIDx0YW56aGVuZ0Br
eWxpbm9zLmNuPgo+PiAKPj4gVGhpcyBsb29rcyBnb29kIHRvIG1lLiBCdXQgYXMgTmlrbGFzIGNv
bW1lbnRlZCwgaWYgdGhpcyBuZWVkcyBhIFN1Z2dlc3RlZC1ieQo+PiB0YWcsIHBsZWFzZSBhZGQg
aXQuCj4+IAo+PiBSZXZpZXdlZC1ieTogRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9y
Zz4KPgo+Tm90ZTogdGhlIHBhdGNoIHRpdGxlIHNob3VsZCBiZToKPgo+YXRhOiBsaWJhaGNpOiB1
c2UgaHdlaWdodF9sb25nKCkgdG8gY291bnQgcG9ydF9tYXAgYml0cwo+Cj5NYXliZSBOaWtsYXMg
Y2FuIGZpeCB0aGlzIHdoZW4gYXBwbHlpbmcuCj4KPgo+LS0gCj5EYW1pZW4gTGUgTW9hbAo+V2Vz
dGVybiBEaWdpdGFsIFJlc2VhcmNoCgpIaQoKSSB3aWxsIG1vZGlmeSB0aGUgcGF0Y2ggdGl0bGUg
YW5kIHJlc2VuZCB0aGUgcGF0Y2guCgpCc2V0IHJlZ2FyZHMsClRhblpoZW5nCgo=
