Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF554C433E0
	for <linux-ide@archiver.kernel.org>; Wed, 23 Dec 2020 09:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9759220760
	for <linux-ide@archiver.kernel.org>; Wed, 23 Dec 2020 09:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgLWJAs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Dec 2020 04:00:48 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:15080 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727904AbgLWJAs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 23 Dec 2020 04:00:48 -0500
Received: by ajax-webmail-mail-app3 (Coremail) ; Wed, 23 Dec 2020 16:59:47
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Wed, 23 Dec 2020 16:59:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Kari Argillander" <kari.argillander@gmail.com>
Cc:     kjlu@umn.edu, "David S. Miller" <davem@davemloft.net>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ide: pci: Fix memleak in ide_pci_init_two
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.12 build 20200616(0f5d8152)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20201220195033.due2e4ukijaah23a@kari-VirtualBox>
References: <20201220070541.7515-1-dinghao.liu@zju.edu.cn>
 <20201220195033.due2e4ukijaah23a@kari-VirtualBox>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2969245c.5c186.1768ed3662e.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgC3Lw8DB+NfGjJ4AA--.18499W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgkDBlZdtRp0WwAOsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUblIS07vEb7Iv0x
        C_Ar1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wCS07vE84ACjcxK6I8E87Iv67AKxVW0oV
        Cq3wCS07vE84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DMIAIbVAS0I0E0xvYzxvE52x0
        82IY62kv0487MIAIbVAqx4xG64xvF2IEw4CE5I8CrVC2j2WlV2xY6cIj6xIIjxv20xvE14
        v26r1j6r18MIAIbVAv7VC2z280aVAFwI0_Jr0_Gr1lV2xY6cvjeVCFs4IE7xkEbVWUJVW8
        JwCS07vE7I0Y64k_MIAIbVCY0x0Ix7I2Y4AK64vIr41lV2xY6xAIw28IcVCjz48v1sIEY2
        0_GFWkJr1UJwCS07vE4x8a6x804xWlV2xY6xC20s026xCaFVCjc4AY6r1j6r4UMIAIbVC2
        0s026c02F40E14v26r1j6r18MIAIbVC20s026x8GjcxK67AKxVWUGVWUWwCS07vEx4CE17
        CEb7AF67AKxVWUAVWUtwCS07vEIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCS07vEIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r1j6r4UMIAIbVCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3w
        CS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1lV2xY6IIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
        GrUvcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

PiBPbiBTdW4sIERlYyAyMCwgMjAyMCBhdCAwMzowNTo0MFBNICswODAwLCBEaW5naGFvIExpdSB3
cm90ZToKPiA+IFdoZW4gZG9faWRlX3NldHVwX3BjaV9kZXZpY2UoKSBmYWlscywgaG9zdCBhbGxv
Y2F0ZWQKPiA+IGJ5IGlkZV9ob3N0X2FsbG9jKCkgbWF5IG5vdCBoYXZlIGJlZW4gZnJlZWQsIHdo
aWNoCj4gPiBsZWFkcyB0byBtZW1sZWFrLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBEaW5naGFv
IExpdSA8ZGluZ2hhby5saXVAemp1LmVkdS5jbj4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvaWRlL3Nl
dHVwLXBjaS5jIHwgOCArKysrLS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lkZS9zZXR1
cC1wY2kuYyBiL2RyaXZlcnMvaWRlL3NldHVwLXBjaS5jCj4gPiBpbmRleCBmZGM4ZTgxMzE3MGMu
LmM3ZGE1MzY4ZmNkNCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvaWRlL3NldHVwLXBjaS5jCj4g
PiArKysgYi9kcml2ZXJzL2lkZS9zZXR1cC1wY2kuYwo+ID4gQEAgLTU4Niw3ICs1ODYsNyBAQCBp
bnQgaWRlX3BjaV9pbml0X3R3byhzdHJ1Y3QgcGNpX2RldiAqZGV2MSwgc3RydWN0IHBjaV9kZXYg
KmRldjIsCj4gPiAgCQkgKiBkb19pZGVfc2V0dXBfcGNpX2RldmljZSgpIG9uIHRoZSBmaXJzdCBk
ZXZpY2UhCj4gPiAgCQkgKi8KPiA+ICAJCWlmIChyZXQgPCAwKQo+ID4gLQkJCWdvdG8gb3V0X2Zy
ZWVfYmFyczsKPiA+ICsJCQlnb3RvIG91dF9mcmVlX2hvc3Q7Cj4gPiAgCj4gPiAgCQkvKiBmaXh1
cCBJUlEgKi8KPiA+ICAJCWlmIChpZGVfcGNpX2lzX2luX2NvbXBhdGliaWxpdHlfbW9kZShwZGV2
W2ldKSkgewo+ID4gQEAgLTU5NywxMSArNTk3LDExIEBAIGludCBpZGVfcGNpX2luaXRfdHdvKHN0
cnVjdCBwY2lfZGV2ICpkZXYxLCBzdHJ1Y3QgcGNpX2RldiAqZGV2MiwKPiA+ICAJfQo+ID4gIAo+
ID4gIAlyZXQgPSBpZGVfaG9zdF9yZWdpc3Rlcihob3N0LCBkLCBod3MpOwo+ID4gLQlpZiAocmV0
KQo+ID4gLQkJaWRlX2hvc3RfZnJlZShob3N0KTsKPiA+IC0JZWxzZQo+ID4gKwlpZiAoIXJldCkK
PiA+ICAJCWdvdG8gb3V0Owo+IAo+IE1heWJlIAo+IAlpZiAocmV0KQo+IAkJZ290byBvdXRfZnJl
ZV9ob3N0Owo+IAo+IAlyZXR1cm4gMDsKPiAKPiB3b3VsZCBiZSBtb3JlIGNsZWFyIGhlcmUuIEJ1
dCB0aGlzIGlzIGp1c3Qgc21hbGwgbml0Lgo+IAo+ID4gIAo+ID4gK291dF9mcmVlX2hvc3Q6Cj4g
PiArCWlkZV9ob3N0X2ZyZWUoaG9zdCk7Cj4gPiAgb3V0X2ZyZWVfYmFyczoKPiA+ICAJaSA9IG5f
cG9ydHMgLyAyOwo+ID4gIAl3aGlsZSAoaS0tKQoKVGhhbmsgeW91IGZvciB5b3VyIGFkdmljZSBh
bmQgSSB3aWxsIHNlbmQgYSBuZXcgcGF0Y2ggc29vbi4KClJlZ2FyZHMsCkRpbmdoYW8=
