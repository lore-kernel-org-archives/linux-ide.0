Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22C5C433E0
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 22:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DB064EBD
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 22:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350255AbhCCVzA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Mar 2021 16:55:00 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:61304 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1450475AbhCCFd4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 3 Mar 2021 00:33:56 -0500
Received: by ajax-webmail-mail-app4 (Coremail) ; Wed, 3 Mar 2021 13:21:56
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.72.8]
Date:   Wed, 3 Mar 2021 13:21:56 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Kangjie Lu" <kjlu@umn.edu>, "Jens Axboe" <axboe@kernel.dk>,
        linux-ide@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: Re: [PATCH] sata_dwc_460ex: Fix missing check in
 sata_dwc_isr
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20200917(3e19599d)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <CAHp75VctFSqxpSfCP=XDSd_QsqX6kpEN+VtKQQU7Xp_wpN52gw@mail.gmail.com>
References: <20210301072842.7410-1-dinghao.liu@zju.edu.cn>
 <CAHp75Vf86_Ccs7wqzbpWbLDZSSJLbMwZ1TX3dwru9JvXUTMR_Q@mail.gmail.com>
 <44c09a14.a0cbd.177ed8446ea.Coremail.dinghao.liu@zju.edu.cn>
 <CAHp75VdT04AVzW=C=SubHjUE5_MHBeC0ptHTFSLgKzrSP3HmRQ@mail.gmail.com>
 <56ec2ffd.a3db1.177f1db3d26.Coremail.dinghao.liu@zju.edu.cn>
 <CAHp75VctFSqxpSfCP=XDSd_QsqX6kpEN+VtKQQU7Xp_wpN52gw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <c865dd8.a4485.177f6891a80.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHwWD0HD9gsZf3AQ--.8565W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUMBlZdtSkspwAGsX
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

PiBPbiBUdWUsIE1hciAyLCAyMDIxIGF0IDk6MzQgQU0gPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+
IHdyb3RlOgo+ID4gPiBPbiBNb24sIE1hciAxLCAyMDIxIGF0IDE6MjAgUE0gPGRpbmdoYW8ubGl1
QHpqdS5lZHUuY24+IHdyb3RlOgo+ID4gPiA+ID4gT24gTW9uLCBNYXIgMSwgMjAyMSBhdCA5OjQ0
IEFNIERpbmdoYW8gTGl1IDxkaW5naGFvLmxpdUB6anUuZWR1LmNuPiB3cm90ZToKPiAKPiAuLi4K
PiAKPiA+ID4gPiBUaGlzIGlzc3VlIGlzIHJlcG9ydGVkIGJ5IG15IHN0YXRpYyBhbmFseXNpcyB0
b29sLCBzbyBJIGRvbid0IGhhdmUgdGhlCj4gPiA+ID4gdnVsbmVyYWJsZSBpbnB1dCBjdXJyZW50
bHkuCj4gPiA+Cj4gPiA+IFNob3VsZCB3ZSBibGluZGx5IGZvbGxvdyBldmVyeXRoaW5nIHRoYXQg
c29tZSAobm9uLWlkZWFsKSB0b29sCj4gPiA+IHJlcG9ydHM/IEkgZG9uJ3QgdGhpbmsgc28uCj4g
PiA+IEZvciBhbGwgbXkgZXhwZXJpbWVudHMgd2l0aCB0aGF0IGhhcmR3YXJlLCBJIGhhdmVuJ3Qg
aGVhcmQgYWJvdXQgdGhlCj4gPiA+IGlzc3VlIHdpdGggTlVMTCBwb2ludGVycy4gVXNlbGVzcyBj
aGVja3MgbWFrZSBjb2RlIGhhcmRlciB0byByZWFkIGFuZAo+ID4gPiBDUFUgdG8gd2FzdGUgY3lj
bGVzLiBJdCBtaWdodCBiZSBtYWludGFpbmVycyBvZiB0aGlzIGRyaXZlciBjb25zaWRlcgo+ID4g
PiBvdGhlcndpc2UsIHNvIG5vdCBteSBjYWxsLgo+ID4gPgo+ID4KPiA+IFRoYW5rcyBmb3IgeW91
ciBhZHZpY2UuIEkgYWxzbyBjaGVja2VkIGFsbCB1c2Ugb2YgYXRhX3FjX2Zyb21fdGFnKCkgaW4g
dGhlCj4gPiB3aG9sZSBrZXJuZWwgYW5kIGZvdW5kIGFsbCBvZiB0aGVtIGhhZCByZXR1cm4gdmFs
dWUgY2hlY2tzIGV4Y2VwdCBmb3IgdGhlCj4gPiBjYWxscyBpbiBzYXRhX2R3Y19pc3IoKSwgd2hp
Y2ggaXMgb2RkLgo+IAo+IFRoYW5rcyBmb3IgdGhpcyBpbmZvcm1hdGlvbiwgaXQgbWFrZXMgc2Vu
c2UgdG8gbWUuIFBlcmhhcHMgeW91IG5lZWQgdG8KPiBwdXQgdGhpcyBpbnRvIHRoZSBjb21taXQg
bWVzc2FnZSB0byBqdXN0aWZ5IHRoZSBuZWVkIG9mIHRoZSBjaGFuZ2UuCj4gCgpPSy4gSSB3aWxs
IGZpeCB0aGlzIGFuZCBzZW5kIGEgbmV3IHBhdGNoIHNvb24uCgpSZWdhcmRzLApEaW5naGFvCg==

