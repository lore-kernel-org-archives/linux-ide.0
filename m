Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748B40DFCF;
	Sat, 25 Apr 2026 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777097743; cv=none; b=Xnz6hylzcbevfAxEHxjyTGQxQ+JjGrPM4HcWITB+eMyUzKHAwq1McXjRspxgDW2Iwk5bexc0ZpnWNpXemqLMAE+zJ8V9QDd9XEd37nrwzAlaH/yDJMhzfBibDOgPVUSEwD6nRt5XAy1RBXzi47xumEVGiSOO0bAyJOa+qpfcZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777097743; c=relaxed/simple;
	bh=0lAYVBqCoHAV6q+RwmAJ/4Pf+9xbLcuQQVNm809CbKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Gvq7wMVjl9C/UJQ3epL2bh/8yFiI+kZE+2tlkpwFMkiyVUYYKdvDKbKko5Y3cKIr7cmCxnXbdi1lj4unwYOMkDQCIxjvq1HhaSNX/tzQuS9jVTFDzfPOXa9hm5fEspfRC97a7EKNfDzyiuDKvVe+PQRNAcLYGWI39k4v3mDuoaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W8NLohQ9; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W8NLohQ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=0lAYVBqCoHAV6q+RwmAJ/4Pf+9xbLcuQQVNm809CbKY=; b=W
	8NLohQ9g6A1qLUsolDB396Z7ckUWy+HcDS6wxSM1K6B5tVTFbLzAvgoRsZGxaLkW
	yL0u5tayrTfuUR9792ZZw0MHsnRFJmx2CVPksjAdmep1P0Bc6NIc9A/vGdOQeRUx
	cl9OoXVi+8v0PleAukSUojrJzTtpDr8oDlifrtKbkI=
Received: from dayou5941$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-104 (Coremail) ; Sat, 25 Apr 2026 14:15:15 +0800
 (CST)
Date: Sat, 25 Apr 2026 14:15:15 +0800 (CST)
From: =?GBK?B?wO7T07roIA==?= <dayou5941@163.com>
To: "Niklas Cassel" <cassel@kernel.org>
Cc: "Damien Le Moal" <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, liyouhong@kylinos.cn
Subject: Re:Re: Re: [PATCH] ata: libahci: fix panic when accessing ports
 beyond MMIO region
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aetO9e7Kf5DZK0QH@ryzen>
References: <20260422080322.1006592-1-dayou5941@163.com>
 <aejc_kqSuU60oRka@ryzen>
 <55809835.8838.19db9be1205.Coremail.dayou5941@163.com>
 <aepUh_p0Jkw0XQ7N@ryzen> <e4280e3b-b02a-4c4d-97dd-1bd49daad2fd@kernel.org>
 <13d7d471.6389.19dbe594e14.Coremail.dayou5941@163.com>
 <aetO9e7Kf5DZK0QH@ryzen>
X-NTES-SC: AL_Qu2cBfySuE8q4yiaYukcmEsSg+02Wsq5u/si1YVec+8EnAHDxzseW1loH2vP0vukDAqwsAOIWSl08u9ld5ZekjHomJvdgSgg7slxNvvU5Q==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <215c4c47.18f7.19dc347307f.Coremail.dayou5941@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aCgvCgDXpTf0W+xpoEmXAA--.48728W
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+hSpWGnsW-RF6AAA3Y
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKSGkgTmlrbGFzLCBEYW1pZW4sCgoKCkF0IDIwMjYtMDQtMjQgMTk6MDc6MzMsICJOaWts
YXMgQ2Fzc2VsIiA8Y2Fzc2VsQGtlcm5lbC5vcmc+IHdyb3RlOgo+T24gRnJpLCBBcHIgMjQsIDIw
MjYgYXQgMDM6MTY6NTZQTSArMDgwMCwgwO7T07roICB3cm90ZToKPj4gQXQgMjAyNi0wNC0yNCAx
MDo0MzoxMSwgIkRhbWllbiBMZSBNb2FsIiA8ZGxlbW9hbEBrZXJuZWwub3JnPiB3cm90ZToKPj4g
Pgo+PiA+V2hhdCBJIGFtIHN1cnByaXNlZCBvZiBoZXJlIGlzIHRoYXQgd2UgZXZlbiBzZWUgdGhh
dCBkZXZpY2Ugb24gdGhlIFBDSSBidXMgYXQKPj4gPmFsbCB3aGVuIGl0IGlzIGRpc2FibGVkIGlu
IHRoZSBCSU9zLiBJZiB0aGF0IGRldmljZSBpcyBkaXNhYmxlZCwgd2h5IGFyZSB3ZSBldmVuCj4+
ID5zZWVpbmcgaXQgYnkgc2Nhbm5pbmcgdGhlIFBDSSBwb3J0cyA/IFRoZSBhZGFwdGVyIHNob3Vs
ZCBzaW1wbHkgbm90IGJlIHZpc2libGUKPj4gPmF0IGFsbC4KPgo+SSBhZ3JlZS4KPkUuZy4gYm90
aCBBTUQgYW5kIEludGVsIG1ha2Ugc3VyZSB0aGF0IHRoZSBBSENJIGNvbnRyb2xsZXIgUENJIGRl
dmljZSBkb2VzCj5ub3Qgc2hvdyB1cCBvbiB0aGUgUENJIGJ1cyBpZiB5b3UgZGlzYWJsZSBpdCB1
c2luZyB0aGUgQklPUy4KPgo+SXQgd291bGQgaGF2ZSBiZWVuIG5pY2UgaWYgdGhlIFBoeXRpdW0g
QklPUyBhbHNvIHdvcmtlZCBsaWtlIHRoYXQuCj4KPgo+PiAzLiAqKkJBUiBTaXplIE1pc21hdGNo
Kio6IGBDQVAuTlBgIGluZGljYXRlcyBtb3JlIHBvcnRzIHRoYW4gcGh5c2ljYWxseSBmaXQgaW4g
dGhlIEJBUgo+PiAtIElmIENBUCBjbGFpbXMgMzIgcG9ydHMgYnV0IEJBUiBpcyBvbmx5IDRLQiwg
dGhpcyBpcyBwaHlzaWNhbGx5IGltcG9zc2libGUKPj4gLSAzMiBwb3J0cyByZXF1aXJlIGF0IGxl
YXN0IDB4MTEwMCBieXRlcyAoMHgxMDAgKyAzMiAqIDB4ODApCj4KPlRoZSByZWFzb24gd2h5IEkg
ZGlkIG5vdCBzdWdnZXN0IGZhaWxpbmcgdGhlIHByb2JlKCkgb3JpZ2luYWxseSwgd2FzIGJlY2F1
c2UKPsDu09O66CBzZW50IGEgcGF0Y2ggd2l0aCBhIEZpeGVzIHRhZywgc28gSSBhc3N1bWVkIHRo
YXQgaGUgY29uc2lkZXJlZCBpdCBhCj5yZWdyZXNzaW9uLCBhbmQgd2FudGVkIHRoZSBoYXJkd2Fy
ZSB0byBjb250aW51ZSB3b3JraW5nLCBldmVuIHRob3VnaCBpdCB3YXMKPm1hcmtlZCBhcyBkaXNh
YmxlZCBpbiBCSU9TLCBiZWNhdXNlIHRoYXQgaXMgaG93IGl0IHdhcyBiZWZvcmUgdGhlIGNvbW1p
dCBpbgo+dGhlIEZpeGVzIHRhZyB3YXMgaW50cm9kdWNlZC4KPgo+VGhhdCBzYWlkLCBJIGZ1bGx5
IGFncmVlIHRoYXQgSSB0aGluayBpdCBpcyBiZXR0ZXIgdG8gbW9kaWZ5IHRoZSBBSENJIGRyaXZl
cgo+dG8gZmFpbCB0aGUgcHJvYmUoKSBmb3IgdGhpcyBBSENJIGNvbnRyb2xsZXIgd2hlbiBpdCBo
YXMgbm90IGJlZW4gcHJvcGVybHkKPmluaXRpYWxpemVkIChiZWNhdXNlIGl0IGlzIG1hcmtlZCBh
cyBkaXNhYmxlZCBpbiBCSU9TKS4KPgo+SSBwcmVmZXIgb3B0aW9uIDMuCj5Mb29rIGF0IENBUC5O
UCBhbmQgbG9vayBhdCB0aGUgQkFSIHNpemUsIGlmIGl0IGlzIHRvbyBzbWFsbCwganVzdCBmYWls
IHRoZQoKPnByb2JlKCkuCgoKClRoYW5rIHlvdSBmb3IgdGhlIGNsZWFyIGRpcmVjdGlvbi4gSSBh
Z3JlZSB0aGF0IGNoZWNraW5nIEJBUiBzaXplIGFnYWluc3QKQ0FQLk5QIGlzIHRoZSBjbGVhbmVz
dCBzb2x1dGlvbi4KCgpJIHdpbGwgcHJlcGFyZSBhIHYyIHBhdGNoIGltcGxlbWVudGluZyB0aGlz
IGNoZWNrOgoKCjEuIEluIGFoY2lfaW5pdF9vbmUoKSwgYWZ0ZXIgbWFwcGluZyBNTUlPIGJ1dCBi
ZWZvcmUgYW55IHBvcnQgYWNjZXNzLgoyLiBDYWxjdWxhdGU6IHJlcXVpcmVkX3NpemUgPSAweDEw
MCArIChDQVAuTlAgKiAweDgwKS4KMy4gQ29tcGFyZSB3aXRoIHBjaV9yZXNvdXJjZV9sZW4ocGRl
diwgNSkuCjQuIElmIHJlcXVpcmVkX3NpemUgPiBCQVIgc2l6ZSwgZmFpbCBwcm9iZSB3aXRoIC1F
Tk9ERVYgYW5kIGNsZWFyIGVycm9yLgoKClRoZSBwYXRjaCB3aWxsIGluY2x1ZGU6Ci0gQSBuZXcg
YWhjaV92YWxpZGF0ZV9iYXJfc2l6ZSgpIGhlbHBlciBmdW5jdGlvbgotIENsZWFyIGVycm9yIG1l
c3NhZ2U6ICJBSENJOiBCQVI1IHRvbyBzbWFsbCBmb3IgJXUgcG9ydHMuLi4iCgoKSSdsbCBzZW5k
IHRoZSB2MiBwYXRjaCBzaG9ydGx5LgoKCkJlc3QgcmVnYXJkcywKbGl5b3Vob25nPgo+Cj5LaW5k
IHJlZ2FyZHMsCgo+TmlrbGFz
