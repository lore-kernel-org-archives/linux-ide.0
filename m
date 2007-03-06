From: dean gaudet <dean@arctic.org>
Subject: Re: [PATCH, RFT, v2] sata_mv: convert to new EH
Date: Mon, 5 Mar 2007 22:53:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703052220040.27855@twinlark.arctic.org>
References: <20070225233454.GA31282@havoc.gtf.org> <1173158201.3416.8.camel@obelisk.thedillows.org>
 <45ED039E.20608@garzik.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="500119290-1176968818-1173163991=:27855"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from twinlark.arctic.org ([207.29.250.54]:40863 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965810AbXCFG7x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 01:59:53 -0500
In-Reply-To: <45ED039E.20608@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Dave Dillow <dave@thedillows.org>, linux-ide@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--500119290-1176968818-1173163991=:27855
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 6 Mar 2007, Jeff Garzik wrote:

> Dave Dillow wrote:
> > BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> > BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> > BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> > BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> > BUG: at drivers/ata/sata_mv.c:1291 mv_get_crpb_status()
> 
> Well, all these seem to be WARN_ON() statements that will fire if NCQ queueing
> is enabled, which it should not be.
> 
> I also note that my test disk is not NCQ-capable, but the testers like you
> getting the BUG: output are attaching NCQ-capable disks.
> 
> So it sounds like something changes for the worst in NCQ land, which is area I
> did not touch for the new-EH work.  However, I do remember cleaning up the
> EDMA configuration in a patch (also sent upstream).
> 
> Does the attached patch fix things?  It should apply on top of linux-2.6.git
> upstream, or libata-dev.git#mv-eh.  This patch merely reverts commit
> e728eabea110da90e69c05855e3a11174edb77ef.

no luck... this actually made it worse :)  now it's spewing BUGs a lot 
more rapidly (without the revert it would error once a minute or so and 
didn't make other progress).  my tree is 2.6.21-rc1 + your "RFT, v2" patch 
+ this revert.

so i threw in some extra printks (see patch)... here's some samples:

[   87.798423] mv_qc_issue: in_ptr = 0x37fe0060, in_index = 0x3, EDMA_REQ_Q_OUT_PTR_OFS = 0x40
[   87.806974] BUG: at drivers/ata/sata_mv.c:1223 mv_qc_issue()

[   88.039421] mv_get_crpb_status: out_index = 0x2, EDMA_RSP_Q_IN_PTR_OFS = 0x18
[   88.047103] BUG: at drivers/ata/sata_mv.c:1273 mv_get_crpb_status()

[   88.312250] mv_get_crpb_status: out_index = 0x2, EDMA_RSP_Q_IN_PTR_OFS = 0x20
[   88.319925] BUG: at drivers/ata/sata_mv.c:1273 mv_get_crpb_status()

[   88.585094] mv_get_crpb_status: out_index = 0x3, EDMA_RSP_Q_IN_PTR_OFS = 0x20
[   88.592771] BUG: at drivers/ata/sata_mv.c:1273 mv_get_crpb_status()

[   89.152245] mv_get_crpb_status: out_index = 0x4, EDMA_RSP_Q_IN_PTR_OFS = 0x28
[   89.159547] BUG: at drivers/ata/sata_mv.c:1273 mv_get_crpb_status()

[   89.543206] mv_get_crpb_status: out_index = 0x5, EDMA_RSP_Q_IN_PTR_OFS = 0x30
[   89.550516] BUG: at drivers/ata/sata_mv.c:1273 mv_get_crpb_status()

[   90.382613] mv_get_crpb_status: out_index = 0x6, EDMA_RSP_Q_IN_PTR_OFS = 0x38
[   90.389933] BUG: at drivers/ata/sata_mv.c:1273 mv_get_crpb_status()

...

hope that helps...

-dean
--500119290-1176968818-1173163991=:27855
Content-Type: TEXT/plain; charset=US-ASCII; name=sata_mv-dbg.patch
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=sata_mv-dbg.patch

SW5kZXg6IGxpbnV4L2RyaXZlcnMvYXRhL3NhdGFfbXYuYw0KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KLS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9hdGEvc2F0
YV9tdi5jCTIwMDctMDMtMDUgMjI6Mjc6NTEuMDAwMDAwMDAwIC0wODAwDQor
KysgbGludXgvZHJpdmVycy9hdGEvc2F0YV9tdi5jCTIwMDctMDMtMDUgMjI6
Mzg6MjYuMDAwMDAwMDAwIC0wODAwDQpAQCAtMTIwMSw2ICsxMjAxLDcgQEAN
CiAJc3RydWN0IG12X3BvcnRfcHJpdiAqcHAgPSBxYy0+YXAtPnByaXZhdGVf
ZGF0YTsNCiAJdW5zaWduZWQgaW5faW5kZXg7DQogCXUzMiBpbl9wdHI7DQor
ICAgICAgICB1bnNpZ25lZCB0bXA7DQogDQogCWlmIChBVEFfUFJPVF9ETUEg
IT0gcWMtPnRmLnByb3RvY29sKSB7DQogCQkvKiBXZSdyZSBhYm91dCB0byBz
ZW5kIGEgbm9uLUVETUEgY2FwYWJsZSBjb21tYW5kIHRvIHRoZQ0KQEAgLTEy
MTUsOCArMTIxNiwxMiBAQA0KIAlpbl9pbmRleCA9IChpbl9wdHIgPj4gRURN
QV9SRVFfUV9QVFJfU0hJRlQpICYgTVZfTUFYX1FfREVQVEhfTUFTSzsNCiAN
CiAJLyogdW50aWwgd2UgZG8gcXVldWluZywgdGhlIHF1ZXVlIHNob3VsZCBi
ZSBlbXB0eSBhdCB0aGlzIHBvaW50ICovDQotCVdBUk5fT04oaW5faW5kZXgg
IT0gKChyZWFkbChwb3J0X21taW8gKyBFRE1BX1JFUV9RX09VVF9QVFJfT0ZT
KQ0KLQkJPj4gRURNQV9SRVFfUV9QVFJfU0hJRlQpICYgTVZfTUFYX1FfREVQ
VEhfTUFTSykpOw0KKyAgICAgICAgdG1wID0gcmVhZGwocG9ydF9tbWlvICsg
RURNQV9SRVFfUV9PVVRfUFRSX09GUyk7DQorCWlmIChpbl9pbmRleCAhPSAo
KHRtcCA+PiBFRE1BX1JFUV9RX1BUUl9TSElGVCkgJiBNVl9NQVhfUV9ERVBU
SF9NQVNLKSkgew0KKyAgICAgICAgICAgICAgICBwcmludGsoS0VSTl9JTkZP
ICJtdl9xY19pc3N1ZTogaW5fcHRyID0gMHgleCwgaW5faW5kZXggPSAweCV4
LCBFRE1BX1JFUV9RX09VVF9QVFJfT0ZTID0gMHgleFxuIiwNCisgICAgICAg
ICAgICAgICAgICAgICAgICBpbl9wdHIsIGluX2luZGV4LCB0bXApOw0KKyAg
ICAgICAgICAgICAgICBXQVJOX09OKDEpOw0KKyAgICAgICAgfQ0KIA0KIAlp
bl9pbmRleCA9IG12X2luY19xX2luZGV4KGluX2luZGV4KTsJLyogbm93IGlu
Y3IgcHJvZHVjZXIgaW5kZXggKi8NCiANCkBAIC0xMjUwLDYgKzEyNTUsNyBA
QA0KIAl1bnNpZ25lZCBvdXRfaW5kZXg7DQogCXUzMiBvdXRfcHRyOw0KIAl1
OCBhdGFfc3RhdHVzOw0KKyAgICAgICAgdW5zaWduZWQgdG1wOw0KIA0KIAlv
dXRfcHRyICAgPSByZWFkbChwb3J0X21taW8gKyBFRE1BX1JTUF9RX09VVF9Q
VFJfT0ZTKTsNCiAJb3V0X2luZGV4ID0gKG91dF9wdHIgPj4gRURNQV9SU1Bf
UV9QVFJfU0hJRlQpICYgTVZfTUFYX1FfREVQVEhfTUFTSzsNCkBAIC0xMjYx
LDggKzEyNjcsMTEgQEANCiAJb3V0X2luZGV4ID0gbXZfaW5jX3FfaW5kZXgo
b3V0X2luZGV4KTsNCiANCiAJLyogYW5kLCB1bnRpbCB3ZSBkbyBOQ1EsIHRo
ZXJlIHNob3VsZCBvbmx5IGJlIDEgQ1JQQiB3YWl0aW5nICovDQotCVdBUk5f
T04ob3V0X2luZGV4ICE9ICgocmVhZGwocG9ydF9tbWlvICsgRURNQV9SU1Bf
UV9JTl9QVFJfT0ZTKQ0KLQkJPj4gRURNQV9SU1BfUV9QVFJfU0hJRlQpICYg
TVZfTUFYX1FfREVQVEhfTUFTSykpOw0KKyAgICAgICAgdG1wID0gcmVhZGwo
cG9ydF9tbWlvICsgRURNQV9SU1BfUV9JTl9QVFJfT0ZTKTsNCisJaWYgKG91
dF9pbmRleCAhPSAoKHRtcCA+PiBFRE1BX1JTUF9RX1BUUl9TSElGVCkgJiBN
Vl9NQVhfUV9ERVBUSF9NQVNLKSkgew0KKyAgICAgICAgICAgICAgICBwcmlu
dGsoS0VSTl9JTkZPICJtdl9nZXRfY3JwYl9zdGF0dXM6IG91dF9pbmRleCA9
IDB4JXgsIEVETUFfUlNQX1FfSU5fUFRSX09GUyA9IDB4JXhcbiIsIG91dF9p
bmRleCwgdG1wKTsNCisgICAgICAgICAgICAgICAgV0FSTl9PTigxKTsNCisg
ICAgICAgIH0NCiANCiAJLyogd3JpdGUgb3V0IG91ciBpbmMnZCBjb25zdW1l
ciBpbmRleCBzbyBFRE1BIGtub3dzIHdlJ3JlIGNhdWdodCB1cCAqLw0KIAlv
dXRfcHRyICY9IEVETUFfUlNQX1FfQkFTRV9MT19NQVNLOw0K

--500119290-1176968818-1173163991=:27855--
