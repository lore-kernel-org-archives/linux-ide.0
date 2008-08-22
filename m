From: "Grant Grundler" <grundler@google.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands concurrently
Date: Fri, 22 Aug 2008 09:28:40 -0700
Message-ID: <da824cf30808220928y58c31f88hb7c1876442189d1f@mail.gmail.com>
References: <489C19CE.6030708@ngs.ru> <489C4F29.6020007@rtr.ca>
	 <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com>
	 <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com>
	 <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com>
	 <48A2C9BC.2010209@ngs.ru> <48A2CAF3.2010009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:1073 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbYHVQ2z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Aug 2008 12:28:55 -0400
Received: from spaceape13.eur.corp.google.com (spaceape13.eur.corp.google.com [172.28.16.147])
	by smtp-out.google.com with ESMTP id m7MGSfmU030948
	for <linux-ide@vger.kernel.org>; Fri, 22 Aug 2008 17:28:41 +0100
Received: from ug-out-1314.google.com (ugeq7.prod.google.com [10.66.168.7])
	by spaceape13.eur.corp.google.com with ESMTP id m7MGSelQ030342
	for <linux-ide@vger.kernel.org>; Fri, 22 Aug 2008 09:28:41 -0700
Received: by ug-out-1314.google.com with SMTP id q7so176766uge.9
        for <linux-ide@vger.kernel.org>; Fri, 22 Aug 2008 09:28:40 -0700 (PDT)
In-Reply-To: <48A2CAF3.2010009@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Artem Bokhan <aptem@ngs.ru>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

T24gV2VkLCBBdWcgMTMsIDIwMDggYXQgNDo1MiBBTSwgVGVqdW4gSGVvIDxodGVqdW5AZ21haWwu
Y29tPiB3cm90ZToKPiBBcnRlbSBCb2toYW4gd3JvdGU6Cj4+IFRlanVuIEhlbyDQv9C40YjQtdGC
Ogo+Pj4gVW5mb3J0dW5hdGVseSwgbGliYXRhIGNvcmUgbGF5ZXIgaXNuJ3QgcmVhZHkgZm9yCj4+
PiB0aGlzIHlldCBhbmQgc3Bld3MgdWdseSB3YXJuaW5nIG1lc3NhZ2UgYW5kIG1hbGZ1bmN0aW9u
cyBvbiB0aGlzLgo+Cj4gV2hlbiBOQ1EgaXMgZGlzYWJsZWQsIGl0IHdpbGwgcHJvYmFibHkgYWRk
IHRpbnkgYml0IHRvIGludGVyIGNvbW1hbmQKPiBsYXRlbmN5IHRodXMgcmVkdWNpbmcgcGVyZm9y
bWFuY2UgYSBiaXQgYnV0IEkgZG9uJ3QgdGhpbmsgaXQgd2lsbCBzdGFuZAo+IG91dCBpbiBhbnkg
d2F5LiAgV2hlbiB5b3UgY291bnQgaW4gdGhlIHNlZWsgdGltZSBhbmQgYWxsLCB0aGUgaW50ZXIK
PiBjb21tYW5kIGxhdGVuY3kgc2hvdWxkIGJlIG5lZ2xpZ2libGUgaW4gbW9zdCBjYXNlcy4KCldo
ZW4gdGhlcmUgaXMgbm8gc2VlayB0aW1lIGl0IGRvZXMgbWF0dGVyIChlLmcuIFNTRCkuIFRvIHRl
c3QKY29tbWFuZCBwZXJmIHdpdGggYSBub3JtYWwgSEQsIGV4Y2VyY2lzZSB0aGUgZGlzayBjYWNo
ZSB3aXRoCnRoaXMgZmlvIGNvbW1hbmQgbGluZToKL3Jvb3QvZmlvIC0tcnVudGltZT0zMCAtLXRp
bWVfYmFzZWQgLS1id2F2Z3RpbWU9NTAwMCAtLXRocmVhZAotLW51bWpvYnM9MSAtLWlvZGVwdGg9
MSAtcnc9cmFuZHJ3IC0tbm9yYW5kb21tYXAgLW92ZXJ3cml0ZT0xCi0tZGlyZWN0PTEgLS1pb2Vu
Z2luZT1zeW5jIC0taW9zY2hlZHVsZXI9bm9vcCAtLWJzPTRrIC0tc2l6ZT00awotLW5hbWU9aGRf
c2RjIC0tZmlsZW5hbWU9L2Rldi9zZGMKCmFuZCB3aWxsIGdldCBvdXRwdXQgd2hpY2ggY29udGFp
bnMgc29tZXRoaW5nIGxpa2U6CmhkX3NkYzogKGc9MCk6IHJ3PXJhbmRydywgYnM9NEstNEsvNEst
NEssIGlvZW5naW5lPXN5bmMsIGlvZGVwdGg9MQpTdGFydGluZyAxIHRocmVhZApKb2JzOiAxIChm
PTEpOiBbbV0gWzk2LjclIGRvbmVdIFsgMTgzODEvIDE3NzA1IGtiL3NdIFtldGEgMDBtOjAxc10K
aGRfc2RjOiAoZ3JvdXBpZD0wLCBqb2JzPTEpOiBlcnI9IDA6IHBpZD0xNzA3OQogIHJlYWQgOiBp
bz01MjgzNDRLaUIsIGJ3PTE4NDc2S2lCL3MsIGlvcHM9NDUxMCwgcnVudD0gMjkyODFtc2VjCiAg
ICBjbGF0ICh1c2VjKTogbWluPTgyLCBtYXg9MTMxLCBhdmc9OTMuMTEsIHN0ZGV2PSAxLjY3CiAg
d3JpdGU6IGlvPTUyNzc5MktpQiwgYnc9MTgyMzVLaUIvcywgaW9wcz00NDUyLCBydW50PSAyOTYz
N21zZWMKICAgIGNsYXQgKHVzZWMpOiBtaW49ODQsIG1heD0yMDksIGF2Zz05My44OCwgc3RkZXY9
IDEuNjAKLi4uCiAgICAgbGF0ICh1c2VjKTogMTAwPTk5LjYwJSwgMjUwPTAuNDAlCi4uLgoKVGhl
IGRyaXZlL2NvbnRyb2xsZXIgY29uZmlnIHJlcG9ydHMgYWxtb3N0IDkwMDAgaW9wcyBmcm9tIGEg
c2luZ2xlIGRyaXZlLgpUaGlzIGNvbXBhcmVzIHdlbGwgd2l0aCBleGlzdGluZyBTU0RzIG9uIHRo
ZSBtYXJrZXQuCgpBbmQgbG9va3MgbGlrZSBmaW8gbmVlZHMgYmV0dGVyIGdyYW51bGFyaXR5IGlu
IGl0J3MgbGF0ZW5jeSBidWNrZXRzLgoKaHRoLApncmFudAoKPiAtLQo+IHRlanVuCj4gLS0KPiBU
byB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUg
bGludXgtaWRlIiBpbgo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5r
ZXJuZWwub3JnCj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9y
Zy9tYWpvcmRvbW8taW5mby5odG1sCj4K
