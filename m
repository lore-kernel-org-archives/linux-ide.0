From: Taisuke Yamada <tai@rakugaki.org>
Subject: [PATCH] LBA28/LBA48 off-by-one bug in ata.h
Date: Sat, 03 May 2008 17:29:03 +0900
Message-ID: <481C224F.10301@rakugaki.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020703020407060800070307"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s62.xrea.com ([221.186.251.67]:38520 "HELO s62.xrea.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753940AbYECIfc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 May 2008 04:35:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tai@rakugaki.org

This is a multi-part message in MIME format.
--------------020703020407060800070307
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi.

I recently bought 3 HGST P7K500-series 500GB SATA drives and
had trouble accessing the block right on the LBA28-LBA48 border.
Here's how it fails (same for all 3 drives):

  # dd if=/dev/sdc bs=512 count=1 skip=268435455 > /dev/null
  dd: reading `/dev/sdc': Input/output error
  0+0 records in
  0+0 records out
  0 bytes (0 B) copied, 0.288033 seconds, 0.0 kB/s
  # dmesg
  ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
  ata1.00: BMDMA stat 0x25
  ata1.00: cmd c8/00:08:f8:ff:ff/00:00:00:00:00/ef tag 0 dma 4096 in
  res 51/04:08:f8:ff:ff/00:00:00:00:00/ef Emask 0x1 (device error)
  ata1.00: status: { DRDY ERR }
  ata1.00: error: { ABRT }
  ata1.00: configured for UDMA/33
  ata1: EH complete
  ...

After some investigations, it turned out this seems to be caused
by misinterpretation of the ATA specification on LBA28 access.
Following part is the code in question:

  === include/linux/ata.h ===
  static inline int lba_28_ok(u64 block, u32 n_block)
  {
    /* check the ending block number */
    return ((block + n_block - 1) < ((u64)1 << 28)) && (n_block <= 256);
  }

HGST drive (sometimes) fails with LBA28 access of {block = 0xfffffff,
n_block = 1}, and this behavior seems to be comformant. Other drives,
including other HGST drives are not that strict, through.

>From the ATA specification:
(http://www.t13.org/Documents/UploadedDocuments/project/d1410r3b-ATA-ATAPI-6.pdf)

  8.15.29  Word (61:60): Total number of user addressable sectors
  This field contains a value that is one greater than the total number
  of user addressable sectors (see 6.2). The maximum value that shall
  be placed in this field is 0FFFFFFFh.

So the driver shouldn't use the value of 0xfffffff for LBA28 request
as this exceeds maximum user addressable sector. The logical maximum
value for LBA28 is 0xffffffe.

The obvious fix is to cut "- 1" part, and the patch attached just do
that. I've been using the patched kernel for about a month now, and
the same fix is also floating on the net for some time. So I believe
this fix works reliably.

Just FYI, many Windows/Intel platform users also seems to be struck
by this, and HGST has issued a note pointing to Intel ICH8/9 driver.

  "28-bit LBA command is being used to access LBAs 29-bits in length"
http://www.hitachigst.com/hddt/knowtree.nsf/cffe836ed7c12018862565b000530c74/b531b8bce8745fb78825740f00580e23

Also, *BSDs seems to have similar fix included sometime around ~2004,
through I have not checked out exact portion of the code.

I do not subscribe to the list, so Cc: me if further discussion is
needed.

Best Regards,
--
Taisuke Yamada

--------------020703020407060800070307
Content-Type: text/plain;
 name="lba28-off-by-one.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="lba28-off-by-one.patch"

LS0tIGxpbnV4LTIuNi4yNC9pbmNsdWRlL2xpbnV4L2F0YS5oLm9yaWcJMjAwOC0wNS0wMyAx
NjowODoxMy4yMjQ4MTE5MDAgKzA5MDAKKysrIGxpbnV4LTIuNi4yNC9pbmNsdWRlL2xpbnV4
L2F0YS5oCTIwMDgtMDQtMDEgMjA6MzM6NDQuNDYwNjE5NzAwICswOTAwCkBAIC01OTksNyAr
NTk5LDcgQEAgc3RhdGljIGlubGluZSBpbnQgYXRhX29rKHU4IHN0YXR1cykKIHN0YXRpYyBp
bmxpbmUgaW50IGxiYV8yOF9vayh1NjQgYmxvY2ssIHUzMiBuX2Jsb2NrKQogewogCS8qIGNo
ZWNrIHRoZSBlbmRpbmcgYmxvY2sgbnVtYmVyICovCi0JcmV0dXJuICgoYmxvY2sgKyBuX2Js
b2NrIC0gMSkgPCAoKHU2NCkxIDw8IDI4KSkgJiYgKG5fYmxvY2sgPD0gMjU2KTsKKwlyZXR1
cm4gKChibG9jayArIG5fYmxvY2spIDwgKCh1NjQpMSA8PCAyOCkpICYmIChuX2Jsb2NrIDw9
IDI1Nik7CiB9CiAKIHN0YXRpYyBpbmxpbmUgaW50IGxiYV80OF9vayh1NjQgYmxvY2ssIHUz
MiBuX2Jsb2NrKQo=
--------------020703020407060800070307--
