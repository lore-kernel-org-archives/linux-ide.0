From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: pread and aio_read do not fail while they should when reading from a device
Date: Tue, 25 Apr 2006 14:29:35 +0300
Message-ID: <5d96567b0604250429v7dc597abs422e0df046d48f72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_16360_2899825.1145964575542"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:16013 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751544AbWDYL3g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Apr 2006 07:29:36 -0400
Received: by pproxy.gmail.com with SMTP id i49so1381524pye
        for <linux-ide@vger.kernel.org>; Tue, 25 Apr 2006 04:29:35 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-aio@kvack.org

------=_Part_16360_2899825.1145964575542
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello
i have tested the "non common" path of the IO.
i have made the following tests:
1.
. pull one disk out of supermicro p8sct machine.
. open a DEVICE in direct IO manner.
. send a simple pread io and asynch read io to this DISK
2.
. pull one disk out of supermicro p8sct machine.
. open a FILE  in direct IO manner.
. send a simple pread io and asynch read io to the FILE

results:
1.
 pread returnred the size of the io sent as if they was no bug.
The same applied for the async io (events->res is 4096 bytes ).

2.
pread and async io returned 0 bytes read.

dmesg reports for test 1 :
ata1: handling error/timeout
ata1: port reset, p_is 0 is 0 pis 0 cmd c017 tf 7f ss 0 se 0
ata1: status=3D0x50 { DriveReady SeekComplete }
sda: Current: sense key=3D0x0
    ASC=3D0x0 ASCQ=3D0x0
ata1: handling error/timeout
ata1: port reset, p_is 0 is 0 pis 0 cmd c017 tf 7f ss 0 se 0
ata1: status=3D0x50 { DriveReady SeekComplete }
sda: Current: sense key=3D0x0
    ASC=3D0x0 ASCQ=3D0x0

dmesg reports nothing in test 2.


xxxxx
i have attacched the test code in tar ball.

thank you.
--
Raz

------=_Part_16360_2899825.1145964575542
Content-Type: application/x-gzip; name=aioerr.tgz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_emg5nx6t
Content-Disposition: attachment; filename="aioerr.tgz"

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
------=_Part_16360_2899825.1145964575542--
