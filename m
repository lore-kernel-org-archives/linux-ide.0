Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15B6C43381
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 02:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D8064EBB
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 02:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhCCCUJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:20:09 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:51070 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1837141AbhCBHex (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 2 Mar 2021 02:34:53 -0500
Received: by ajax-webmail-mail-app2 (Coremail) ; Tue, 2 Mar 2021 15:33:33
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Tue, 2 Mar 2021 15:33:33 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Kangjie Lu" <kjlu@umn.edu>, "Jens Axboe" <axboe@kernel.dk>,
        linux-ide@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH] sata_dwc_460ex: Fix missing check in
 sata_dwc_isr
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20200917(3e19599d)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <CAHp75VdT04AVzW=C=SubHjUE5_MHBeC0ptHTFSLgKzrSP3HmRQ@mail.gmail.com>
References: <20210301072842.7410-1-dinghao.liu@zju.edu.cn>
 <CAHp75Vf86_Ccs7wqzbpWbLDZSSJLbMwZ1TX3dwru9JvXUTMR_Q@mail.gmail.com>
 <44c09a14.a0cbd.177ed8446ea.Coremail.dinghao.liu@zju.edu.cn>
 <CAHp75VdT04AVzW=C=SubHjUE5_MHBeC0ptHTFSLgKzrSP3HmRQ@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <56ec2ffd.a3db1.177f1db3d26.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDnrvBN6j1gv5HiAQ--.64536W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUMBlZdtSkcrQABsq
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

PiBPbiBNb24sIE1hciAxLCAyMDIxIGF0IDE6MjAgUE0gPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+
IHdyb3RlOgo+ID4KPiA+ID4gT24gTW9uLCBNYXIgMSwgMjAyMSBhdCA5OjQ0IEFNIERpbmdoYW8g
TGl1IDxkaW5naGFvLmxpdUB6anUuZWR1LmNuPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IGF0YV9x
Y19mcm9tX3RhZygpIG1heSByZXR1cm4gYSBudWxsIHBvaW50ZXIgYW5kIGZ1cnRoZXIgbGVhZCB0
bwo+ID4gPiA+IG51bGwtcG9pbnRlci1kZXJlZmVyZW5jZS4gQWRkIGEgcmV0dXJuIHZhbHVlIGNo
ZWNrIHRvIGF2b2lkIHN1Y2ggY2FzZS4KPiA+ID4KPiA+ID4gQ2FuIHlvdSBlbGFib3JhdGUgbW9y
ZSBvbiB0aGlzPyBJcyBpdCBhIHJlYWwgY2FzZT8KPiA+ID4gSSBoYXZlIGEgaGFyZHdhcmUsIGhv
dyBjYW4gSSByZXByb2R1Y2UgdGhpcz8KPiA+ID4KPiA+Cj4gPiBJbiB0aGUgYnJhbmNoICdpZiAo
aW50cHIgJiBTQVRBX0RXQ19JTlRQUl9ORVdGUCknLCB3ZSBjYWxsIGF0YV9xY19mcm9tX3RhZygp
Cj4gPiBhbmQgYWNjZXNzIHFjLT5hcC0+bGluay5hY3RpdmVfdGFnIGltbWVkaWF0ZWx5LiBJZiBh
dGFfcWNfZnJvbV90YWcoKSByZXR1cm5zCj4gPiBhIG51bGwgcG9pbnRlciwgYWNjZXNzaW5nIHFj
LT5hcC0+bGluay5hY3RpdmVfdGFnIG1heSBjcmFzaCB0aGUgc3lzdGVtLgo+IAo+IFllcywgSSBj
YW4gc2VlIHRoYXQuIE15IHF1ZXN0aW9uIGlzIGhvdyB0byBnZXQgaW50byB0aGUgY2FzZSB3aGVu
IHRoaXMKPiB3aWxsIGJlIHRydWUuCj4gCgpJIGNhbm5vdCBhbnN3ZXIgdGhpcyBxdWVzdGlvbiBp
bW1lZGlhdGVseS4gSSB0aGluayBpdCdzIHBvc3NpYmxlIHRvIGJ1aWxkIAphIGRlc2lnbmVkIGlu
cHV0IHRvIHRyaWdnZXIgdGhpcyBjYXNlIGZvciBzb21lIHByb2Zlc3Npb25hbCBhdHRhY2tlcnMu
IAoKPiA+IFRoaXMgaXNzdWUgaXMgcmVwb3J0ZWQgYnkgbXkgc3RhdGljIGFuYWx5c2lzIHRvb2ws
IHNvIEkgZG9uJ3QgaGF2ZSB0aGUKPiA+IHZ1bG5lcmFibGUgaW5wdXQgY3VycmVudGx5Lgo+IAo+
IFNob3VsZCB3ZSBibGluZGx5IGZvbGxvdyBldmVyeXRoaW5nIHRoYXQgc29tZSAobm9uLWlkZWFs
KSB0b29sCj4gcmVwb3J0cz8gSSBkb24ndCB0aGluayBzby4KPiBGb3IgYWxsIG15IGV4cGVyaW1l
bnRzIHdpdGggdGhhdCBoYXJkd2FyZSwgSSBoYXZlbid0IGhlYXJkIGFib3V0IHRoZQo+IGlzc3Vl
IHdpdGggTlVMTCBwb2ludGVycy4gVXNlbGVzcyBjaGVja3MgbWFrZSBjb2RlIGhhcmRlciB0byBy
ZWFkIGFuZAo+IENQVSB0byB3YXN0ZSBjeWNsZXMuIEl0IG1pZ2h0IGJlIG1haW50YWluZXJzIG9m
IHRoaXMgZHJpdmVyIGNvbnNpZGVyCj4gb3RoZXJ3aXNlLCBzbyBub3QgbXkgY2FsbC4KPiAKClRo
YW5rcyBmb3IgeW91ciBhZHZpY2UuIEkgYWxzbyBjaGVja2VkIGFsbCB1c2Ugb2YgYXRhX3FjX2Zy
b21fdGFnKCkgaW4gdGhlIAp3aG9sZSBrZXJuZWwgYW5kIGZvdW5kIGFsbCBvZiB0aGVtIGhhZCBy
ZXR1cm4gdmFsdWUgY2hlY2tzIGV4Y2VwdCBmb3IgdGhlIApjYWxscyBpbiBzYXRhX2R3Y19pc3Io
KSwgd2hpY2ggaXMgb2RkLiBUaGVyZSBpcyBubyBpc3N1ZSBjdXJyZW50bHkgZG9lcyBub3QKbWVh
biBpdCB3aWxsIG5ldmVyIGhhcHBlbiBpbiB0aGUgZnV0dXJlLiBTbyBJIHN1Z2dlc3QgdGhlIG1h
aW50YWluZXIgb2YgZnVuY3Rpb24Kc2F0YV9kd2NfaXNyKCkgdG8gZml4IHRoaXMgaXNzdWUuCgpS
ZWdhcmRzLApEaW5naGFvCg==
