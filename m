From: Lin Mac <mkl0301@gmail.com>
Subject: Re: [PATCH v5 3/3] ahci_platforms: add support for CNS3xxx SoC devices
Date: Mon, 10 Jan 2011 23:47:29 +0800
Message-ID: <AANLkTikrFpD+MDqyjS3CMGceMHXWhELPGNv1FaqEqP0s@mail.gmail.com>
References: <1294557970-654-1-git-send-email-mkl0301@gmail.com>
	<1294557970-654-4-git-send-email-mkl0301@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0373E1D99B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a549b06b7c04997fe228
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35282 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab1AJPrb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 10:47:31 -0500
Received: by fxm20 with SMTP id 20so18966875fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2011 07:47:30 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373E1D99B@dbde02.ent.ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>
Cc: "htejun@gmail.com" <htejun@gmail.com>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

--20cf3054a549b06b7c04997fe228
Content-Type: text/plain; charset=ISO-8859-1

2011/1/10 Basheer, Mansoor Ahamed <mansoor.ahamed@ti.com>:
>> From: Mac Lin <mkl0301@gmail.com>
>>
>> CNS3xxx override the softreset function of ahci_platform
>> ahci_softreset by cns3xxx_ahci_softreset, which would retry
>> ahci_do_softreset again with pmp=0 if
>> pmp=15 failed, for the controller has problem receiving D2H
>> Reg FIS of the different PMP setting of the previous sent H2D Reg FIS.
>>
>
> Is this issue only with your ahci platform controller? I came across another
> thread here,
>
> http://www.spinics.net/lists/linux-ide/msg39865.html
Thanks for mentioning this.
They do look alike. I'll confirm with them.

> Also, the ahci platform controller on Texas Instruments OMAP L138 platform
> behaves in a similar fashion.
>
> Currently I see only Cavium Networks, Faraday and TI using ahci platform
> controller and all 3 facing same issue.
>
> Hence, should we fix this in ahci_platform.c conditionally using platform data,
> otherwise we will end-up adding file for every platform (just for one
> function).
We can add quirk in ahci platform data, just like sdhci_pltfm.c and
sdhci_cns3xxx.c.
Thus, in cns3xxx's case, all we need is to include
<linux/ahci_platform.h>, and all the SoC specific code could exist in
arch folder, similar to my v1 patchset.

Best Regards,
Mac Lin

--20cf3054a549b06b7c04997fe228
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-libahci-Fixup-for-softwreset-failures-with-direct-co.patch"
Content-Disposition: attachment;
	filename="0001-libahci-Fixup-for-softwreset-failures-with-direct-co.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_girhvv430

RnJvbSAwMzBlZWZiY2JhOTQ5OWIyYWEyNDE3MTg5NTg4MWFmZTZjMzg1ZmQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYWMgTGluIDxta2wwMzAxQGdtYWlsLmNvbT4KRGF0ZTogTW9u
LCAxMCBKYW4gMjAxMSAyMjozNzo1NyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGxpYmFoY2k6IEZp
eHVwIGZvciBzb2Z0d3Jlc2V0IGZhaWx1cmVzIHdpdGggZGlyZWN0IGNvbm5lY3RlZCBkaXNrcyB3
aXRoIENPTkZJR19TQVRBX1BNUCBlbmFibGVkCgotLS0KIGRyaXZlcnMvYXRhL2xpYmFoY2kuYyB8
ICAgIDcgKysrKysrLQogMSBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvbGliYWhjaS5jIGIvZHJpdmVycy9hdGEv
bGliYWhjaS5jCmluZGV4IGViYzA4ZDYuLjA4MTU0OGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYXRh
L2xpYmFoY2kuYworKysgYi9kcml2ZXJzL2F0YS9saWJhaGNpLmMKQEAgLTEzMDIsMTAgKzEzMDIs
MTUgQEAgc3RhdGljIGludCBhaGNpX3NvZnRyZXNldChzdHJ1Y3QgYXRhX2xpbmsgKmxpbmssIHVu
c2lnbmVkIGludCAqY2xhc3MsCiAJCQkgIHVuc2lnbmVkIGxvbmcgZGVhZGxpbmUpCiB7CiAJaW50
IHBtcCA9IHNhdGFfc3JzdF9wbXAobGluayk7CisJaW50IHJldDsKIAogCURQUklOVEsoIkVOVEVS
XG4iKTsKIAotCXJldHVybiBhaGNpX2RvX3NvZnRyZXNldChsaW5rLCBjbGFzcywgcG1wLCBkZWFk
bGluZSwgYWhjaV9jaGVja19yZWFkeSk7CisJcmV0ID0gYWhjaV9kb19zb2Z0cmVzZXQobGluaywg
Y2xhc3MsIHBtcCwgZGVhZGxpbmUsIGFoY2lfY2hlY2tfcmVhZHkpOworCWlmIChyZXQgJiYgcG1w
KQorCQlyZXR1cm4gYWhjaV9kb19zb2Z0cmVzZXQobGluaywgY2xhc3MsIDAsIGRlYWRsaW5lLAor
CQkJYWhjaV9jaGVja19yZWFkeSk7CisJcmV0dXJuIHJldDsKIH0KIEVYUE9SVF9TWU1CT0xfR1BM
KGFoY2lfZG9fc29mdHJlc2V0KTsKIAotLSAKMS43LjMKCg==
--20cf3054a549b06b7c04997fe228--
