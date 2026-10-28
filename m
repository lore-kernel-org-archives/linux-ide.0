Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217029;
	b=KSUXhf/vSO6ptd2Pns70r2BTLEgCN01DP5so3pYiBJ8497a6aKeJBqCA2jotDcS8iBwF
	 FfHm2dhosYAlahMsQU6OzEACrGDqsxWykc6WvcdW+GVzPZnrell3F+XLdjDpF/zIkKvs8
	 cBkFpXreKkThOYbVqx1X3Rdxl6dv2RJlF5MOoskSfE6T29c5rcKGPQjTrZPWRtvrBw5QX
	 LqTF434peE5HwkbA+E+UBeR4s+NNc/7gpOMGVpCTjiPk+Q/CNGMSQdyoTTonUx5K/+cyf
	 7qzKTYKso/N618otWz/pL2+EjtMwlbeWMVFeIcIiWXvM000oL0V2sU4UK8+IiTwf8jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=fom4yvaENzaHnSG42GyLTccOuWuaPzKK86KyGa1FSTI=;
	b=AZgIALOxEsEpsyElc88Zpp+a4EkWgZ9ABZpi+JsWvTk90b1me8RA6Id+6/Htxt8lMd8F
	 dYdjCS8e70OZlYiPNFxFCBTppN/uPEUL8Cnav2N2y8Ty/n7tfvsqs0D6k8aAmcpoF1xwS
	 vPX3qr8bhmGaA/T+41G9uaeavJaZZfIrd4GEMrs9NVuDcCoo/sfYx7/E/ZCCCFafTqpAq
	 PUambdL49hDz4cGsw0ZF0ICfvqevLxvU8PaDIza2tXl9DUbTueZe5ebVbsFjXeCjjOQeW
	 ZM1dd5pbdmNVsLb0Me1zLiaXBCb4VPy6YzSB1u8qb4vc0L9po0zXjUeAIld0x64mxUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIGq3gNS;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBE60A260F
	for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 19:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFDBE60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIGq3gNS
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956869750eso9903075e9.2
        for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793217027; x=1793821827; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fom4yvaENzaHnSG42GyLTccOuWuaPzKK86KyGa1FSTI=;
        b=TIGq3gNSEQTGFE8dirwFKRkWnd2Scl2mBdvbI3o75uLkytzDGiMdvcHJ7K+8HBB91j
         YMCyy5YoVCr6B4L/aMd8GXJ8cWK1y/M7cuXQDJtkpMLRZiNK3HjOXQSJ/naWqYQglkiW
         3up1GCHSKhOS5YT4aikidg8Qq5XCIxwk6otkmHO9up4rFsuFa3GmujedpuO1x8cLU1O3
         YrqwJLryCf4dFeXsLlHOkzbCU33UKhzJDCRBO7wD1zi/nEUXqqTaLR7gKm1g/AegosYs
         P/xLfute2jVjbAycdQdaluXrl7sht7ZYMtoN6we0YeCDrJ1zOYhdrwaI3cQEm9M20xxh
         GRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217027; x=1793821827;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fom4yvaENzaHnSG42GyLTccOuWuaPzKK86KyGa1FSTI=;
        b=JL6H4olXO1XKZByMLPLxEejzsVY2i5V2Wwiqvb//HqfDMRjTgXAljZ8CL1IVZIM56u
         M9uuT9+fRoYdVayBHHlAOAwOt2shSzFEDnPIK4iT9I4BW1ScJqDLtjyYDwE9QkROwO2z
         FamIuRrumPfOH65nBrXW92MZDsWzeW3n+0qV8aRxD+SCYuhVlvpPgqCXd5qlO5w6GrJS
         1echKqlT73XC8UsXd59o5mHT/K7JucTpzGX8r8eB0qGgwp0LoLXx/AfzQ7FxHvLd82IE
         0CP+nzUgAwjpo3GYD/s/DK3eahgFLaeqkgPaXkjLEBoiVc6nVJnvxCY+n4m+dGJYDRbp
         O4CQ==
X-Forwarded-Encrypted: i=1; AKwUvBystIfqWRJCgb+fZJ7FJfnONoi0TMlLlYSndKLkTwktmH/fbQIVyXEXNBEiRFZAp9SlbFslh/JUMb8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIleu0aJdQhYiemRcLmp7rUHPYeZwTZuTtWe1mBADzqbtmTS83e
	CggYl0PJcNF2qdOA1l279X61nVkHI/J37EKJeHFfFOQq+QI6NyCRE1nY6XMj3uNh
X-Gm-Gg: AYBFou1IQLbRiP+1MdFjXNmREnHVXG8XEHwsbaQh0eojWKbxCwJGCy2n8p9lO1WxLG/
	/Tc8LeWO1MfN72kifyOVgbXDQOFtXBoT4nuiPnrvgSBRAKESL7C7R3WpByM+4yz2L15OnaLe2j5
	m8xEU98Zsa23mRCaZTb3aokSK8Dw0mh3LvuP8nRiBjpgja4orV6hAm3pPpybSseMeMVeC3Pv4p/
	70/MG78Ak3CICqsTAAe64H0lfAhCRIy/1Y/r4m4FotV+GsTuJ6Avy4FMLcoGgkeRh3Uf8dIJNQd
	ixjNdquORLTdhgHx6Kv/L8npHmV+qlmbTvaUB8cC+vkS06SIiwhb3KiKGArze546s2N96tt97m0
	q55mKbi7ap17qNOqsc4I6S42/PvvjMF3Xs0hcG4wK2zj9mFpBnI+DJAzAt2RMBpSrpFxTeWcHr5
	MN3ognPdu3FzxnHwpNopW0zI5wfZsWo2LoK7m20bBN9FoYFcUi57DLJdksYVDVGoPCc1NupKamu
	6W7/APZCrzAyTExPRFHD3/T3Tv3he3NUqB0Bzz3uszHrVEUiX8MFAafD+PoZHZ+ObKDKuhaKvyO
	OlDHusY513oY+aNtlee8cuq283TXJKrP47+no948oR1pQgOzPe2gY9wEnfcPNbWAA4L2eCopQqA
	LmOKXaPbIMwNb58p07utFUsQKSMzqwrJ0vJAuzSZhJQAczvDiW2XyUIAWILwSVg0pcumLzVNHZx
	QPinWdMSljMIZGn/8=
X-Received: by 2002:a05:600c:530d:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4a966774cbemr70339165e9.22.1793217026916;
        Wed, 28 Oct 2026 12:50:26 -0700 (PDT)
Received: from PC-Marco.local ([151.59.117.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896fesm15170845e9.10.2026.10.28.12.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:50:26 -0700 (PDT)
From: Marco Ziliani <rylos78@gmail.com>
Date: Wed, 28 Oct 2026 20:50:18 +0100
Subject: [PATCH] ata: libata-pmp: disable the SEMB port on Marvell 88SM9705
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-pmp-88sm9705-v1-1-cf951fe74573@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyML3YLcAl0Li+JcS3MDU12jNHMTwyQTY9M0QzMloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAWrVLmXAAAAA=
X-Change-ID: 20261028-pmp-88sm9705-2f741b435f16
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Kyrylo Biryuk <illofspeed@gmail.com>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marco Ziliani <rylos78@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793217025; l=3551;
 i=rylos78@gmail.com; s=20261027; h=from:subject:message-id;
 bh=jq/bX4Fw2tFf9xoqbWcRl/77+7jumFvnKruLVmfuESM=;
 b=QmP1T7AMCqTiyXZgs9/3e4KvTqqNeOjWSzyF3W/gT6zMoxHave+E4fbXSsO6v2doE0t3tfwvm
 sb4mnLBhg4SD/A6vQVZvPszY6XNAoJA+QQ988f7EhJwSRySSHCdbf0B
X-Developer-Key: i=rylos78@gmail.com; a=ed25519;
 pk=nXCfiK5yExPZCMp+lfKif3gdXkfjkUK2qk7bDW+ixMo=

The Marvell 88SM9705 is a 1-to-5 SATA port multiplier with one
additional SEMB (SATA Enclosure Management Bridge) port [1].  Ports
0-4 are device ports and port 5 is the SEMB.  The number of fan-out
ports in GSCR[2] is 6 when the SEMB is enabled and 5 when it is not,
so on boards without the SEMB there is no link 5 and this quirk does
nothing.  That includes the common 8-port PCIe cards that pair an
88SE9215 with an 88SM9705, which report 5 ports.

The SEMB port never answers SRST.  libata probes it like a device
port, and every EH round on the PMP ends in a retry loop that lasts
about a minute before EH gives up, then starts over:

  ata19.15: Port Multiplier 1.2, 0x1b4b:0x9705 r160, 6 ports, feat 0x1/0x1f
  ata19.05: hard resetting link
  ata19.05: failed to resume link (SControl 0)
  ata19.05: softreset failed (1st FIS failed)
  ata19.05: hard resetting link
  ...
  ata20.05: reset failed, giving up

Disk discovery waits for this, including disks on other controllers.

libata.force cannot work around it: the "disable" horkage only takes
effect after IDENTIFY, which the SEMB link never reaches.

Treat port 5 the same way as port 4 of the Marvell 88SM4140 and mark
the link ATA_LFLAG_DISABLED.

Tested by the user who found the problem (see the synodeb link below)
on a Synology DX1215 expansion unit (four 88SM9705 r160 behind a
Marvell 88SE9235), one disk in the DX1215 and one on a separate AHCI
controller, one boot each, Debian 6.12 libata with and without this
change:

                                      without     with
  "softreset failed" lines            60          0
  disk on the separate controller     200.6 s     18.6 s
  disk behind an 88SM9705             203.3 s     21.3 s

Each PMP still logs one "failed to resume link (SControl 0)" for port 5
at probe time.

Link: https://www.marvell.com/content/dam/marvell/en/public-collateral/storage/marvell-storage-88sm9705-functional-specifications-2015-06.pdf [1]
Link: https://github.com/rylos/synodeb/discussions/8
Cc: stable@vger.kernel.org
Signed-off-by: Marco Ziliani <rylos78@gmail.com>
---
I don't have this hardware myself: the problem was found and measured
on a DX1215 by a user of synodeb (Debian on Synology NAS units), who
preferred not to send the patch. It is carried in the synodeb kernels.

Kyrylo, your DX1222 has the same 88SE9235 + 88SM9705 chain: if it shows
the same port 5 retry loop, a Tested-by would be very welcome.
---
 drivers/ata/libata-pmp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 904f418387..72bc458568 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -482,6 +482,19 @@ static void sata_pmp_quirks(struct ata_port *ap)
 			if (link->pmp == 4)
 				link->flags |= ATA_LFLAG_DISABLED;
 		}
+	} else if (vendor == 0x1b4b && devid == 0x9705) {
+		/*
+		 * Marvell 88SM9705 quirks
+		 *
+		 * 1-to-5 PMP with an extra SEMB port.  It reports 6 ports and
+		 * port 5 is the SEMB, which never answers SRST: EH spends about
+		 * a minute per round retrying it, and disk discovery waits for
+		 * that.  Seen behind a Marvell 88SE9235 in the Synology DX1215.
+		 */
+		ata_for_each_link(link, ap, EDGE) {
+			if (link->pmp == 5)
+				link->flags |= ATA_LFLAG_DISABLED;
+		}
 	}
 }
 

---
base-commit: fb2c3f44a7e14627b9dca8e6b568e6cdc234b40b
change-id: 20261028-pmp-88sm9705-2f741b435f16

Best regards,
--  
Marco Ziliani <rylos78@gmail.com>

