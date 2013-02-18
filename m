From: =?ISO-8859-1?Q?Csaba_Hal=E1sz?= <csaba.halasz@gmail.com>
Subject: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Mon, 18 Feb 2013 19:17:54 +0100
Message-ID: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d042ef7536d562a04d603bed6
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:64866 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab3BRSR4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2013 13:17:56 -0500
Received: by mail-la0-f44.google.com with SMTP id eb20so5773456lab.3
        for <linux-ide@vger.kernel.org>; Mon, 18 Feb 2013 10:17:55 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--f46d042ef7536d562a04d603bed6
Content-Type: text/plain; charset=ISO-8859-1

Hi!

There seems to be a longstanding problem with certain ATAPI drives and
SATA bridges. This usually manifests itself in the device being
disabled on boot, with log messages similar to this:

kernel: ata5.00: qc timeout (cmd 0xa0)
kernel: ata5.00: failed to clear UNIT ATTENTION (err_mask=0x5)
kernel: ata5.00: disabled

At least for the bridge I have (an Abit Serillel 2) setting DMADIR
option and making sure even the internal commands use it seems to fix
the issue.
I have copied the code from atapi_xlat. Maybe some refactoring would
be in order, because apparently some other things might have to be
done too (such as setting lbam/lbah).
Also I am not sure whether we need to check that it's in fact an ATAPI
command (maybe by putting this in the if (cdb) block).

Cheers,
Csaba Halasz

--f46d042ef7536d562a04d603bed6
Content-Type: application/octet-stream; name="dmadir.diff"
Content-Disposition: attachment; filename="dmadir.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hdbxsxns0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmF0YS1jb3JlLmMgYi9kcml2ZXJzL2F0YS9saWJh
dGEtY29yZS5jCmluZGV4IDQ2Y2QzZjQuLjE0MGQ2NzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYXRh
L2xpYmF0YS1jb3JlLmMKKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYwpAQCAtMTYxNCw2
ICsxNjE0LDEwIEBAIHVuc2lnbmVkIGF0YV9leGVjX2ludGVybmFsX3NnKHN0cnVjdCBhdGFfZGV2
aWNlICpkZXYsCiAJCWF0YV9zZ19pbml0KHFjLCBzZ2wsIG5fZWxlbSk7CiAJCXFjLT5uYnl0ZXMg
PSBidWZsZW47CiAJfQorCWlmICgoZGV2LT5mbGFncyAmIEFUQV9ERkxBR19ETUFESVIpICYmCisJ
CSAgICAoZG1hX2RpciA9PSBETUFfRlJPTV9ERVZJQ0UpKQorCQkJLyogc29tZSBTQVRBIGJyaWRn
ZXMgbmVlZCB1cyB0byBpbmRpY2F0ZSBkYXRhIHhmZXIgZGlyZWN0aW9uICovCisJCQlxYy0+dGYu
ZmVhdHVyZSB8PSBBVEFQSV9ETUFESVI7CiAKIAlxYy0+cHJpdmF0ZV9kYXRhID0gJndhaXQ7CiAJ
cWMtPmNvbXBsZXRlX2ZuID0gYXRhX3FjX2NvbXBsZXRlX2ludGVybmFsOwo=
--f46d042ef7536d562a04d603bed6--
