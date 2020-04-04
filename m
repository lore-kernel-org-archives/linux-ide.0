Return-Path: <SRS0=zDqJ=5V=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3BEC2BA15
	for <linux-ide@archiver.kernel.org>; Sun,  5 Apr 2020 02:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ADA20659
	for <linux-ide@archiver.kernel.org>; Sun,  5 Apr 2020 02:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgDECXa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 4 Apr 2020 22:23:30 -0400
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.123]:61079 "EHLO
        xiaomi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbgDECXa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 4 Apr 2020 22:23:30 -0400
Received: from CNBOX13.mioffice.cn (10.237.8.153) by HKBOX1.mioffice.cn
 (10.56.8.141) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 4 Apr
 2020 19:27:03 +0800
Received: from CNBOX05.mioffice.cn (10.237.8.125) by cnbox13.mioffice.cn
 (10.237.8.153) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 4 Apr
 2020 19:27:03 +0800
Received: from CNBOX05.mioffice.cn ([::1]) by cnbox05.mioffice.cn
 ([fe80::59c2:4d72:7961:f4b5%21]) with mapi id 15.00.1497.006; Sat, 4 Apr 2020
 19:27:03 +0800
From:   =?gb2312?B?s8LG9M7k?= <chenqiwu@xiaomi.com>
To:     "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: [ide:master 1/1] drivers/ide/ide-scan-pci.c:104:13: error:
 incompatible type for argument 1 of 'list_del'
Thread-Topic: [ide:master 1/1] drivers/ide/ide-scan-pci.c:104:13: error:
 incompatible type for argument 1 of 'list_del'
Thread-Index: AQHWCnP3Cw8WOGn020+9rEHUpMT4Wg==
Date:   Sat, 4 Apr 2020 11:27:03 +0000
Message-ID: <1585999579788.83525@xiaomi.com>
References: <202004041117.BRMQBZTk%lkp@intel.com>
In-Reply-To: <202004041117.BRMQBZTk%lkp@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

DQpIaSBEYXZpZCwNCg0KSSdtIHNvcnJ5IGZvciBicmluZ2luZyB0aGlzIGJ1aWxkIGZhaWx1cmUg
aXNzdWUuIFBsZWFzZSBoZWxwIGFwcGx5IHRoZSBmb2xsb3dpbmcgY2hhbmdlIHRvIGNvbW1pdCAg
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZGF2ZW0vaWRl
LmdpdC9jb21taXQvP2lkPTZhMDAzMzQ1N2YyMzgwODUyYTNhNDEzOGQ0Yzc5NTcxYTViNTFiZTYN
Cg0KICAgMTAzICAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShkLCB0bXAsICZpZGVf
cGNpX2RyaXZlcnMsIG5vZGUpIHsNCiA+IDEwNCAgICAgICAgICAgICAgICAgIGxpc3RfZGVsKCZk
LT5ub2RlKTsNCg0KVGhhbmtzIQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQoNCnRyZWU6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvZGF2ZW0vaWRlLmdpdCBtYXN0ZXINCmhlYWQ6ICAgNmEwMDMzNDU3ZjIzODA4NTJh
M2E0MTM4ZDRjNzk1NzFhNWI1MWJlNg0KY29tbWl0OiA2YTAwMzM0NTdmMjM4MDg1MmEzYTQxMzhk
NGM3OTU3MWE1YjUxYmU2IFsxLzFdIGRyaXZlcnMvaWRlOiBjb252ZXJ0IHRvIGxpc3RfZm9yX2Vh
Y2hfZW50cnlfc2FmZSgpDQpjb25maWc6IHBhcmlzYy1nZW5lcmljLTY0Yml0X2RlZmNvbmZpZyAo
YXR0YWNoZWQgYXMgLmNvbmZpZykNCmNvbXBpbGVyOiBocHBhNjQtbGludXgtZ2NjIChHQ0MpIDku
My4wDQpyZXByb2R1Y2U6DQogICAgICAgIHdnZXQgaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRl
bnQuY29tL2ludGVsL2xrcC10ZXN0cy9tYXN0ZXIvc2Jpbi9tYWtlLmNyb3NzIC1PIH4vYmluL21h
a2UuY3Jvc3MNCiAgICAgICAgY2htb2QgK3ggfi9iaW4vbWFrZS5jcm9zcw0KICAgICAgICBnaXQg
Y2hlY2tvdXQgNmEwMDMzNDU3ZjIzODA4NTJhM2E0MTM4ZDRjNzk1NzFhNWI1MWJlNg0KICAgICAg
ICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8gbGludXggYnVpbGQgdHJlZQ0KICAgICAg
ICBHQ0NfVkVSU0lPTj05LjMuMCBtYWtlLmNyb3NzIEFSQ0g9cGFyaXNjDQoNCklmIHlvdSBmaXgg
dGhlIGlzc3VlLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWcgYXMgYXBwcm9wcmlhdGUNClJlcG9y
dGVkLWJ5OiBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCg0KQWxsIGVycm9ycyAo
bmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KDQogICBkcml2ZXJzL2lkZS9pZGUtc2Nhbi1wY2ku
YzogSW4gZnVuY3Rpb24gJ2lkZV9zY2FuX3BjaWJ1cyc6DQo+PiBkcml2ZXJzL2lkZS9pZGUtc2Nh
bi1wY2kuYzoxMDQ6MTM6IGVycm9yOiBpbmNvbXBhdGlibGUgdHlwZSBmb3IgYXJndW1lbnQgMSBv
ZiAnbGlzdF9kZWwnDQogICAgIDEwNCB8ICAgbGlzdF9kZWwoZC0+bm9kZSk7DQogICAgICAgICB8
ICAgICAgICAgICAgfl5+fn5+fg0KICAgICAgICAgfCAgICAgICAgICAgICB8DQogICAgICAgICB8
ICAgICAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQNCiAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBp
bmNsdWRlL2xpbnV4L21vZHVsZS5oOjEyLA0KICAgICAgICAgICAgICAgICAgICBmcm9tIGRyaXZl
cnMvaWRlL2lkZS1zY2FuLXBjaS5jOjEyOg0KICAgaW5jbHVkZS9saW51eC9saXN0Lmg6MTQ0OjQ3
OiBub3RlOiBleHBlY3RlZCAnc3RydWN0IGxpc3RfaGVhZCAqJyBidXQgYXJndW1lbnQgaXMgb2Yg
dHlwZSAnc3RydWN0IGxpc3RfaGVhZCcNCiAgICAgMTQ0IHwgc3RhdGljIGlubGluZSB2b2lkIGxp
c3RfZGVsKHN0cnVjdCBsaXN0X2hlYWQgKmVudHJ5KQ0KICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+Xn5+fn4NCg0KdmltICsvbGlzdF9kZWwg
KzEwNCBkcml2ZXJzL2lkZS9pZGUtc2Nhbi1wY2kuYw0KDQogICAgODANCiAgICA4MSAgLyoqDQog
ICAgODIgICAqICAgICAgaWRlX3NjYW5fcGNpYnVzICAgICAgICAgLSAgICAgICBwZXJmb3JtIHRo
ZSBpbml0aWFsIElERSBkcml2ZXIgc2Nhbg0KICAgIDgzICAgKg0KICAgIDg0ICAgKiAgICAgIFBl
cmZvcm0gdGhlIGluaXRpYWwgYnVzIHJhdGhlciB0aGFuIGRyaXZlciBvcmRlcmVkIHNjYW4gb2Yg
dGhlDQogICAgODUgICAqICAgICAgUENJIGRyaXZlcnMuIEFmdGVyIHRoaXMgYWxsIElERSBwY2kg
aGFuZGxpbmcgYmVjb21lcyBzdGFuZGFyZA0KICAgIDg2ICAgKiAgICAgIG1vZHVsZSBvcmRlcmlu
ZyBub3QgdHJhZGl0aW9uYWxseSBvcmRlcmVkLg0KICAgIDg3ICAgKi8NCiAgICA4OA0KICAgIDg5
ICBzdGF0aWMgaW50IF9faW5pdCBpZGVfc2Nhbl9wY2lidXModm9pZCkNCiAgICA5MCAgew0KICAg
IDkxICAgICAgICAgIHN0cnVjdCBwY2lfZGV2ICpkZXYgPSBOVUxMOw0KICAgIDkyICAgICAgICAg
IHN0cnVjdCBwY2lfZHJpdmVyICpkLCAqdG1wOw0KICAgIDkzDQogICAgOTQgICAgICAgICAgcHJl
X2luaXQgPSAwOw0KICAgIDk1ICAgICAgICAgIGZvcl9lYWNoX3BjaV9kZXYoZGV2KQ0KICAgIDk2
ICAgICAgICAgICAgICAgICAgaWRlX3NjYW5fcGNpZGV2KGRldik7DQogICAgOTcNCiAgICA5OCAg
ICAgICAgICAvKg0KICAgIDk5ICAgICAgICAgICAqICAgICAgSGFuZCB0aGUgZHJpdmVycyBvdmVy
IHRvIHRoZSBQQ0kgbGF5ZXIgbm93IHdlDQogICAxMDAgICAgICAgICAgICogICAgICBhcmUgcG9z
dCBpbml0Lg0KICAgMTAxICAgICAgICAgICAqLw0KICAgMTAyDQogICAxMDMgICAgICAgICAgbGlz
dF9mb3JfZWFjaF9lbnRyeV9zYWZlKGQsIHRtcCwgJmlkZV9wY2lfZHJpdmVycywgbm9kZSkgew0K
ID4gMTA0ICAgICAgICAgICAgICAgICAgbGlzdF9kZWwoZC0+bm9kZSk7DQoNCi0tLQ0KMC1EQVkg
Q0kgS2VybmVsIFRlc3QgU2VydmljZSwgSW50ZWwgQ29ycG9yYXRpb24NCmh0dHBzOi8vbGlzdHMu
MDEub3JnL2h5cGVya2l0dHkvbGlzdC9rYnVpbGQtYWxsQGxpc3RzLjAxLm9yZw0KIy8qKioqKiqx
vtPKvP68sMbkuL28/rqs09DQocPXuavLvrXEsaPD3NDFz6KjrL32z97T2reiy824+MnPw+a12Na3
1tDB0LP2tcS49sjLu/LIutfpoaO9+9a5yM66zsbky/vIy9LUyM66ztDOyr3KudPDo6iw/MCotauy
u8/e09rIq7K/u/Kyv7fWtdjQucK2oaK4tNbGoaK78smit6KjqbG+08q8/tbQtcTQxc+ioaPI57n7
xPq07crVwcuxvtPKvP6jrMfrxPrBory0tee7sLvy08q8/s2o1qq3orz+yMuyosm+s/2xvtPKvP6j
oSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGlu
Zm9ybWF0aW9uIGZyb20gWElBT01JLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVy
c29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0
aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1
dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rp
b24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGlu
IGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRp
YXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioqKiovIw0K
