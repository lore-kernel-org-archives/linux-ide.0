Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057222;
	b=iX229D7+N361yFAXVfUy5ckTg7a78sTN46B8wdtSngR1wTqeyxPST7lGnj33gFauqooY
	 b40Myus0EePzRwW9GCZiwI2AzkmC7zODaLGVNYQvg96hB+KWr8soqqlOAJcmNCSxyDW/M
	 g8Cb0Kc72d68otcvLf8UolYlTvGMAki5zKzGuLOOdzIHQ5+P4Luk+2IHqQVl88LsCVtsf
	 1kD52TCshP+O8qRKSNIvaFgPEuChFf1ZSeAndBT1p1tRNfdhnV/BkDDonrJ5HjbeqWIFt
	 gUjPo7FVbCPgii55o4mVMRwE7dx0zQO1sQgsF0ODr2yJCEnlRF5tXEkG4Usd8wm1k1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Ck14fKV6LP02+4pNJEFmV4SbeAH9q4KUqAqJ8rl5z8k=;
	b=QXGi0nDDtHc/U3EKYlvojCMoF1T640+B4rphuH0rdm0/XLAIjV4lm8votnmo+AxC4kiZ
	 ygpLlwb/qI6hXhXdcqGNS4MAp2Vr1A53U3Zzjj1Y91lqFSZdhVkNq1g3PEbxPVAeHilTi
	 EJSwyMzbRy73af+EN9NSx/gIgq1RMg6bJd3ZPCiKDZllUeFioXvbaUJZnSiQVVAto3s/D
	 ES0tcU2HGrOwrgwfUi7jKga6uwih+Yc019YC8Up57Z2ztMwtcv0tszXLvM4SIXsG3VOdW
	 aRVEpO8VoBrJqbi3vK5lDQTfJxzyvFtllFU/Gixjvtadmh+2PonbcxDlcVc14UewQpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vysbNISz;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBEF606A326
	for <linux-ide@vger.kernel.org>; Sat,  7 Nov 2026 13:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DBEF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vysbNISz
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a208d93758so15984495e9.3
        for <linux-ide@vger.kernel.org>; Sat, 07 Nov 2026 05:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057220; x=1794662020; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ck14fKV6LP02+4pNJEFmV4SbeAH9q4KUqAqJ8rl5z8k=;
        b=vysbNISz8SzWFmHI7OcsIgVE/V/ABSV+2GuqrFioIU8vzq1zVTXOrd25yYMsQGul9y
         IEto4XwlcWxPi87QSsB987nCN8kie9R//K940kp2cy4w6DGnnusCyWiKypiGT0BosmEK
         k5hRpohwrzdagbuCUHEuGHglN/d/4vS2TmukSYXpzdr+2SZzmtkZHqLmc4kZuEjaDeUX
         XslpIvKrRJ+13BcESV/cnCaiDh7rnm5AclHVYWdWPQ47JMwWb0M68A2i4c3+TVsyOqtQ
         MNaCauf99Dry39oFPQdwQZw+o75uxbi9RVSDmZ2KrCIvyH5J9NjIVPMhm/dxtrbOtxbn
         Je6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057220; x=1794662020;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ck14fKV6LP02+4pNJEFmV4SbeAH9q4KUqAqJ8rl5z8k=;
        b=jt2EPiZhvf7U0eqc0egAotLGcNdnFcfcedXMmyEU+X7e9KiLBz4/IlUT+5X8GAq4TN
         0ZAPa1V5tocmltChXvwTaFxz3akxpngarmcmDYVXph7JKRKhc5vnO/az7MtjeS3SuJWD
         dBwk96SExQzKJDjZXYJqyH8++/hYtumHb+0rcB2ybik4XZKvlPOnlMbneZAjbc7Cdx4U
         BMItsg7+NlIPQVJJtjQwk/guNB/ffIoJdJdrbOD+gHBxXzQNv17SRHNMhZGyPLF+Us1b
         96i7u3DOJM6mghwheDiRx6VQCsOleuoiqcNA6qHBCA4P0RvpE9w6M9dQd6BLWBLfmGbw
         Mp4w==
X-Forwarded-Encrypted: i=1; AKwUvBy4ZYnJ8kS5OAx3D9xFDGl1wWT/Iiuh02iRdGlBigMoTrNeg6gPM9iWDy138COl6ZXYscLJrOP9LtM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DrfISvuuj2q1lNCZOmT/i1m+9HAArBn6gOGwB17FVfKe576it
	vjjn1AOrk/hmNSPHr9mFJ+VskoQQsJeYxqh0kwMIAUp4aPNH3l6SbUuSW6522m4O
X-Gm-Gg: AYBFou1CYDNx9WluVmV4fm3y3azD6MryLJ/vbA5xKqqr023x0qltVFuXfVnApTLqtZf
	2MGc+G4BhD42Xu+yQtQZDso/iLGgES++xMv/v4mb0zi1jlUCcFf2aV7GlihIicQOSS0NC2nvK5R
	O0xGM+gADivjsC1p8E0K1IWX17MSY534jTyJycGzU9T3fzncAtjJP2uWjQ8tGmjtGQLTvETaD6o
	5S31KLLjAf0OSPwvCSx8u+bAuc2IqrVYRvlvcHHA1Pnb0awoNOL26oWGsBNtHZADQPkEARjWxb5
	icZUf1ARgy7J7z3v99Yq973YeikzKDNQ5TJVK0rohSWq2WzMzkEF1i6Sen9nZBSMXKej7F8LwUy
	eT66toUR1de0mcgcZ/ejkO63faAGkSQrzb5/EQwF3FUEiodqpaB2HV+8U20s512eCLUg9kHikUZ
	v1CUi++ogQPuOWur9nj2YQLpxB+TUIViaxgW1PzPPHa9DZ12JnP48pXD19UOPVi/Ao6HtvJZ9Le
	GZeZ6B1NnFeim5giHmmgrm5jAWEODNTC35EuCOoMQ9t7sxZ4xTiEiMXLNZ0rAfjuLSxgJrIxkM4
	kcWzXBD1iLyzIgliit7no2FZIvI1JMp8eGIhDAYjnoepbmhQ6iwsZPTDBIBD6q5EGtuNFqqo5XO
	Wq/niZDztFjHsmCfvaQp5j8MjNC5u3QsWYEvCLGP7rlrOBG5uMSOeW+Zf+yPPKkkvShE=
X-Received: by 2002:a05:600c:6994:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4b6df11de39mr98136025e9.14.1794057219338;
        Sat, 07 Nov 2026 05:13:39 -0800 (PST)
Received: from PC-Marco.local ([151.59.49.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e2e9ad95sm64282305e9.3.2026.11.07.05.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:13:38 -0800 (PST)
From: Marco Ziliani <rylos78@gmail.com>
Date: Sat, 07 Nov 2026 14:13:30 +0100
Subject: [PATCH v2] ata: libata-pmp: disable the SEMB port on Marvell
 88SM9705
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
Message-Id: <20261107-pmp-88sm9705-v2-1-18eed983d3db@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0JmbQ1TKAVX3sOwgDqFMZaSFomGc
 HcB1y5f8v77C0QKTBEuyQKBZo7shw3kKQHTN0NHgu8bg0xlgaksxehGUZbRVTpVQlqdY5tnymI
 B22QMZPl95G71j+OrfZCZ9sZu9BwnHz7H34y79yc9o0BhbKXQks6Vzq6da/h5Nt5Bva7rF/qbB
 xG6AAAA
X-Change-ID: 20261028-pmp-88sm9705-2f741b435f16
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Kyrylo Biryuk <illofspeed@gmail.com>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marco Ziliani <rylos78@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794057217; l=4258;
 i=rylos78@gmail.com; s=20261027; h=from:subject:message-id;
 bh=1bZ0/g/Vqj0TVjKKgVi14x/QhYjtWqwjUDv/wvKppsM=;
 b=yXxfwA1Y8VSA1X8Ye6NPG87dZVzkjbfYENcw35RNXLaGSsA9OXP6rmIMkNGKpSr1PVgwY1p4A
 s6DSuuJSftKBL9Gzz7JNyMoT1pFyrci2879OTsSivs6lterDy04biLp
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

libata.force only partly works around it.  The "disable" horkage
only takes effect after IDENTIFY, which the SEMB link never reaches.
"norst" on port 5 stops the retry loop, but the disks still come up
about a minute later than with this change (see below).

Treat port 5 the same way as port 4 of the Marvell 88SM4140 and mark
the link ATA_LFLAG_DISABLED.

Tested on a Synology DX1222 expansion unit (four 88SM9705 r160 behind
a Marvell 88SE9235, passed through to a KVM guest, 6 disks), 7.4-rc1
with and without this change, one boot each:

                                    softreset  reset failed,  last disk
                                    failed     giving up      attached
  7.4-rc1, no libata.force          60         12             197 s
  7.4-rc1, libata.force=N.05:norst   0          0              70 s
  7.4-rc1 + this patch, no force     0          0              11 s

The problem was first found on a Synology DX1215 with the same chain,
where this change brought the disks up after about 20 s instead of
about 200 s, including a disk on a separate AHCI controller.

Each PMP still logs one "failed to resume link (SControl 0)" for port 5
at probe time.

Link: https://www.marvell.com/content/dam/marvell/en/public-collateral/storage/marvell-storage-88sm9705-functional-specifications-2015-06.pdf [1]
Cc: stable@vger.kernel.org
Tested-by: Kyrylo Biryuk <illofspeed@gmail.com>
Signed-off-by: Marco Ziliani <rylos78@gmail.com>
---
I don't have this hardware myself: the problem was found and measured
on a DX1215 by a user who preferred not to send the patch, and Kyrylo
has since tested it on his DX1222.

I used an AI coding assistant to draft the patch and the changelog;
I reviewed them and can answer for them.
---
Changes in v2:
- Say that libata.force "norst" only partly works around the problem
  (Niklas).
- Use Kyrylo's 7.4-rc1 results on a DX1222 as the test data, and drop
  the references to the downstream distribution (Niklas).
- Mention the DX1222 in the comment.
- Add Kyrylo's Tested-by.
- Link to v1: https://patch.msgid.link/20261028-pmp-88sm9705-v1-1-cf951fe74573@gmail.com
---
 drivers/ata/libata-pmp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 904f418387..43991e54eb 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -482,6 +482,20 @@ static void sata_pmp_quirks(struct ata_port *ap)
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
+		 * that.  Seen behind a Marvell 88SE9235 in the Synology DX1215
+		 * and DX1222.
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

