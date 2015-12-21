From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Mon, 21 Dec 2015 18:48:17 +0200
Message-ID: <1450716497.30729.232.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	 <yw1xtwnfad4y.fsf@unicorn.mansr.com> <56745BA4.1090607@candw.ms>
	 <yw1xpoy39yl1.fsf@unicorn.mansr.com> <56748D85.4060108@candw.ms>
	 <yw1xlh8r9wkm.fsf@unicorn.mansr.com>
	 <CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
	 <567541EE.9010308@candw.ms> <yw1x60zua1ld.fsf@unicorn.mansr.com>
	 <CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
	 <yw1xwpsa8j2x.fsf@unicorn.mansr.com> <56758F33.20804@candw.ms>
	 <yw1xsi2y8ifa.fsf@unicorn.mansr.com> <5675A84F.2070208@candw.ms>
	 <yw1xio3u8dgc.fsf@unicorn.mansr.com> <5675BB2F.6060107@candw.ms>
	 <CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	 <yw1xegei893o.fsf@unicorn.mansr.com> <5675C452.2080206@candw.ms>
	 <yw1xy4cp6o4o.fsf@unicorn.mansr.com> <5676E906.1060603@candw.ms>
	 <yw1xpoy16jlt.fsf@unicorn.mansr.com>
	 <CAHp75Vedczfn7B-tOEVZi2dOExW8FiAGGA7iTkpuC2wBrsK68g@mail.gmail.com>
	 <CAHp75VfaHvBHhTjQVMNdOYA2kEdus-XpH6E=9i1HPSKTa-2ffA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-sN+5zfzOJZ40DWE6QXqY"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54948 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbbLUQuI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Dec 2015 11:50:08 -0500
In-Reply-To: <CAHp75VfaHvBHhTjQVMNdOYA2kEdus-XpH6E=9i1HPSKTa-2ffA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--=-sN+5zfzOJZ40DWE6QXqY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sun, 2015-12-20 at 22:55 +0200, Andy Shevchenko wrote:
> On Sun, Dec 20, 2015 at 10:17 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Dec 20, 2015 at 8:49 PM, Måns Rullgård <mans@mansr.com>
> > wrote:
> > I noticed thanks to DWC_PARAMS that burst size is hardcoded to 32
> > items on this board, however registers for SATA program it to 64. I
> > remember that I got no interrupt when I programmed transfer width
> > wrongly (64 bits against 32 bits) when I ported dw_dmac to be used
> > on
> > Intel SoCs.
> 
> One more thing, I have a patch to monitor DMA IO, we may check what
> exactly the values are written / read  in DMA. I can share it
> tomorrow.

As promised the patch I have to debug IO of DW DMA. Didn't check though
if it applies cleanly on top of recent vanilla kernel.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--=-sN+5zfzOJZ40DWE6QXqY
Content-Disposition: attachment; filename="0001-dw_dmac-debug-dma-controller-IO.patch"
Content-Type: text/x-patch; name="0001-dw_dmac-debug-dma-controller-IO.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBjODI0ODQ1MjM4ZjBlMDI3ZDQ4MGJmYzNiOWFkNDgyYWU5MDFiNzhiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxp
bnV4LmludGVsLmNvbT4KRGF0ZTogTW9uLCA0IEp1biAyMDEyIDEwOjE0OjUwICswMzAwClN1Ympl
Y3Q6IFtQQVRDSCB2Ml0gZHdfZG1hYzogZGVidWcgZG1hIGNvbnRyb2xsZXIgSU8KClNpZ25lZC1v
ZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29t
PgotLS0KIGRyaXZlcnMvZG1hL2R3L2NvcmUuYyB8ICA4ICsrKysrLS0tCiBkcml2ZXJzL2RtYS9k
dy9yZWdzLmggfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2Vk
LCAzMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZG1hL2R3L2NvcmUuYyBiL2RyaXZlcnMvZG1hL2R3L2NvcmUuYwppbmRleCBkY2YxOWYwLi5kNTBj
MzljIDEwMDY0NAotLS0gYS9kcml2ZXJzL2RtYS9kdy9jb3JlLmMKKysrIGIvZHJpdmVycy9kbWEv
ZHcvY29yZS5jCkBAIC01NzAsOSArNTcwLDEwIEBAIHN0YXRpYyB2b2lkIGR3Y19oYW5kbGVfY3lj
bGljKHN0cnVjdCBkd19kbWEgKmR3LCBzdHJ1Y3QgZHdfZG1hX2NoYW4gKmR3YywKIAlpZiAoZHdj
LT5tYXNrKSB7CiAJCXZvaWQgKCpjYWxsYmFjaykodm9pZCAqcGFyYW0pOwogCQl2b2lkICpjYWxs
YmFja19wYXJhbTsKKwkJZG1hX2FkZHJfdCBsbHAgPSBjaGFubmVsX3JlYWRsKGR3YywgTExQKTsK
IAotCQlkZXZfdmRiZyhjaGFuMmRldigmZHdjLT5jaGFuKSwgIm5ldyBjeWNsaWMgcGVyaW9kIGxs
cCAweCUwOHhcbiIsCi0JCQkJY2hhbm5lbF9yZWFkbChkd2MsIExMUCkpOworCQlkZXZfdmRiZyhj
aGFuMmRldigmZHdjLT5jaGFuKSwgIm5ldyBjeWNsaWMgcGVyaW9kIGxscCAlcGFkXG4iLAorCQkJ
CSZsbHApOwogCiAJCWNhbGxiYWNrID0gZHdjLT5jZGVzYy0+cGVyaW9kX2NhbGxiYWNrOwogCQlj
YWxsYmFja19wYXJhbSA9IGR3Yy0+Y2Rlc2MtPnBlcmlvZF9jYWxsYmFja19wYXJhbTsKQEAgLTE1
NzEsNiArMTU3Miw4IEBAIGludCBkd19kbWFfcHJvYmUoc3RydWN0IGR3X2RtYV9jaGlwICpjaGlw
LCBzdHJ1Y3QgZHdfZG1hX3BsYXRmb3JtX2RhdGEgKnBkYXRhKQogCiAJcG1fcnVudGltZV9nZXRf
c3luYyhjaGlwLT5kZXYpOwogCisJZHctPmRtYS5kZXYgPSBjaGlwLT5kZXY7CisKIAlkd19wYXJh
bXMgPSBkbWFfcmVhZF9ieWFkZHIoY2hpcC0+cmVncywgRFdfUEFSQU1TKTsKIAlhdXRvY2ZnID0g
ZHdfcGFyYW1zID4+IERXX1BBUkFNU19FTiAmIDB4MTsKIApAQCAtMTcxNSw3ICsxNzE4LDYgQEAg
aW50IGR3X2RtYV9wcm9iZShzdHJ1Y3QgZHdfZG1hX2NoaXAgKmNoaXAsIHN0cnVjdCBkd19kbWFf
cGxhdGZvcm1fZGF0YSAqcGRhdGEpCiAJZG1hX2NhcF9zZXQoRE1BX1NMQVZFLCBkdy0+ZG1hLmNh
cF9tYXNrKTsKIAlpZiAocGRhdGEtPmlzX3ByaXZhdGUpCiAJCWRtYV9jYXBfc2V0KERNQV9QUklW
QVRFLCBkdy0+ZG1hLmNhcF9tYXNrKTsKLQlkdy0+ZG1hLmRldiA9IGNoaXAtPmRldjsKIAlkdy0+
ZG1hLmRldmljZV9hbGxvY19jaGFuX3Jlc291cmNlcyA9IGR3Y19hbGxvY19jaGFuX3Jlc291cmNl
czsKIAlkdy0+ZG1hLmRldmljZV9mcmVlX2NoYW5fcmVzb3VyY2VzID0gZHdjX2ZyZWVfY2hhbl9y
ZXNvdXJjZXM7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2R3L3JlZ3MuaCBiL2RyaXZlcnMv
ZG1hL2R3L3JlZ3MuaAppbmRleCAzYTNhNWUxLi5hM2I4ODFjIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2RtYS9kdy9yZWdzLmgKKysrIGIvZHJpdmVycy9kbWEvZHcvcmVncy5oCkBAIC0xMzAsNiArMTMw
LDggQEAgc3RydWN0IGR3X2RtYV9yZWdzIHsKICNkZWZpbmUgZG1hX3dyaXRlbF9uYXRpdmUgd3Jp
dGVsCiAjZW5kaWYKIAorI2RlZmluZSBEV19ETUFDX0lPX0RFQlVHCisKIC8qIFRvIGFjY2VzcyB0
aGUgcmVnaXN0ZXJzIGluIGVhcmx5IHN0YWdlIG9mIHByb2JlICovCiAjZGVmaW5lIGRtYV9yZWFk
X2J5YWRkcihhZGRyLCBuYW1lKSBcCiAJZG1hX3JlYWRsX25hdGl2ZSgoYWRkcikgKyBvZmZzZXRv
ZihzdHJ1Y3QgZHdfZG1hX3JlZ3MsIG5hbWUpKQpAQCAtMzAxLDEwICszMDMsMjIgQEAgX19kd2Nf
cmVncyhzdHJ1Y3QgZHdfZG1hX2NoYW4gKmR3YykKIAlyZXR1cm4gZHdjLT5jaF9yZWdzOwogfQog
CisjaWZkZWYgRFdfRE1BQ19JT19ERUJVRworI2RlZmluZSBjaGFubmVsX3JlYWRsKGR3YywgbmFt
ZSkgKHsJCQkJCQlcCisJdW5zaWduZWQgaW50IHZhbCA9IGRtYV9yZWFkbF9uYXRpdmUoJihfX2R3
Y19yZWdzKGR3YyktPm5hbWUpKTsJCVwKKwlkZXZfZGJnKGNoYW4yZGV2KCZkd2MtPmNoYW4pLCAi
cmVhZGw6ICIgI25hbWUgIiAweCUwOHhcbiIsICh1MzIpdmFsKTsJXAorCXZhbDsJCQkJCQkJCQlc
Cit9KQorI2RlZmluZSBjaGFubmVsX3dyaXRlbChkd2MsIG5hbWUsIHZhbCkgKHsJCQkJCVwKKwlk
ZXZfZGJnKGNoYW4yZGV2KCZkd2MtPmNoYW4pLCAid3JpdGVsOiAiICNuYW1lICIgMHglMDh4XG4i
LCAodTMyKXZhbCk7CVwKKwlkbWFfd3JpdGVsX25hdGl2ZSgodmFsKSwgJihfX2R3Y19yZWdzKGR3
YyktPm5hbWUpKTsJCQlcCit9KQorI2Vsc2UKICNkZWZpbmUgY2hhbm5lbF9yZWFkbChkd2MsIG5h
bWUpIFwKIAlkbWFfcmVhZGxfbmF0aXZlKCYoX19kd2NfcmVncyhkd2MpLT5uYW1lKSkKICNkZWZp
bmUgY2hhbm5lbF93cml0ZWwoZHdjLCBuYW1lLCB2YWwpIFwKIAlkbWFfd3JpdGVsX25hdGl2ZSgo
dmFsKSwgJihfX2R3Y19yZWdzKGR3YyktPm5hbWUpKQorI2VuZGlmCiAKIHN0YXRpYyBpbmxpbmUg
c3RydWN0IGR3X2RtYV9jaGFuICp0b19kd19kbWFfY2hhbihzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4p
CiB7CkBAIC0zMzMsMTAgKzM0NywyMiBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBkd19kbWFfcmVn
cyBfX2lvbWVtICpfX2R3X3JlZ3Moc3RydWN0IGR3X2RtYSAqZHcpCiAJcmV0dXJuIGR3LT5yZWdz
OwogfQogCisjaWZkZWYgRFdfRE1BQ19JT19ERUJVRworI2RlZmluZSBkbWFfcmVhZGwoZHcsIG5h
bWUpICh7CQkJCQkJXAorCXVuc2lnbmVkIGludCB2YWwgPSBkbWFfcmVhZGxfbmF0aXZlKCYoX19k
d19yZWdzKGR3KS0+bmFtZSkpOwlcCisJZGV2X2RiZyhkdy0+ZG1hLmRldiwgInJlYWRsOiAiICNu
YW1lICIgMHglMDh4XG4iLCAodTMyKXZhbCk7CVwKKwl2YWw7CQkJCQkJCQlcCit9KQorI2RlZmlu
ZSBkbWFfd3JpdGVsKGR3LCBuYW1lLCB2YWwpICh7CQkJCQlcCisJZGV2X2RiZyhkdy0+ZG1hLmRl
diwgIndyaXRlbDogIiAjbmFtZSAiIDB4JTA4eFxuIiwgKHUzMil2YWwpOwlcCisJZG1hX3dyaXRl
bF9uYXRpdmUoKHZhbCksICYoX19kd19yZWdzKGR3KS0+bmFtZSkpOwkJXAorfSkKKyNlbHNlCiAj
ZGVmaW5lIGRtYV9yZWFkbChkdywgbmFtZSkgXAogCWRtYV9yZWFkbF9uYXRpdmUoJihfX2R3X3Jl
Z3MoZHcpLT5uYW1lKSkKICNkZWZpbmUgZG1hX3dyaXRlbChkdywgbmFtZSwgdmFsKSBcCiAJZG1h
X3dyaXRlbF9uYXRpdmUoKHZhbCksICYoX19kd19yZWdzKGR3KS0+bmFtZSkpCisjZW5kaWYKIAog
I2RlZmluZSBjaGFubmVsX3NldF9iaXQoZHcsIHJlZywgbWFzaykgXAogCWRtYV93cml0ZWwoZHcs
IHJlZywgKChtYXNrKSA8PCA4KSB8IChtYXNrKSkKLS0gCjIuMS4zCgo=


--=-sN+5zfzOJZ40DWE6QXqY--

