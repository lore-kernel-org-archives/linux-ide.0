Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920562;
	b=XXDHW1EnzauI5bknMej4ToxjKp4TGkqXNhD4xYV7th0CLjO1vUzifekhebN5Zk2S3UxE
	 D0/PZcvf69m8QxPxR0VTCzH/IViSdsVEVreDLyflGDYuS1YHmLkZXLN83pBMlqnx0ebmh
	 m4IBG0p71+fHOt0iC/H5hBpZzVxne4JhKkgE3YmbDPfW8sTCXxbeuwWEJeH/dwuQbjpew
	 z2h/ojwh0RgDhXdM/iBay3WysU055YlJPpZ35IjOcyDaoqkHlEN/vM3dG0u4dY0X1Kqf0
	 dgC0gA8AD8m0Cr6e9pTCKHRiiCV8IeoVfLanO+3JRsPyScv8rlA/VpsKP4H0pjN1LNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920562;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=QNA3Vhqf+UZeGZxTB/kn2GTeWL5R2nnhu8DLevJSejc=;
	b=XjLk/k9EQDPRZr5f53XjXT6aNdyYmyugK8hquj04P5ExD2K0W5SCU+sLakDlzFJ9xVWf
	 BQmzltg5t8xUOpILqsR+5b6zGS8trU62yUjCew9J4o7zt1f1eMUvP4jxVmucsCqfDskjg
	 u2+4stu/5hA4uZT1hQp5Qab/3EQdJIQesjm8wIkMzV7/t8MUgAVWf7KCkjSqekaOnpMYA
	 lcmUSlwGOYwno20og0dGfFZqlfoDKrg5meb3Yzg2sSqL445lrzbqEu8LCcbZFYUXrgMpq
	 bIM2EgixugTj3XE5JOXwFbTuVU2hl17/poAklRghOo6n84FjKlGnZS78zlt4gifhrJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBn5GHyR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD950606A32F
	for <linux-ide@vger.kernel.org>; Tue, 17 Nov 2026 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBn5GHyR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDB91F000C5;
	Tue, 17 Nov 2026 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920562;
	bh=QNA3Vhqf+UZeGZxTB/kn2GTeWL5R2nnhu8DLevJSejc=;
	h=From:To:Cc:Subject:Date;
	b=PBn5GHyRXGmdAaJ7Al0r2Tmp0ff4YPWapIhQ/4MD5gQxQZT26MCuMOvRHtDRrGgIo
	 MRXDN7klDDNC08GUEZFro7RVTGKi8UQj6t+8tHVluZNp7cYT5tIPb3xq0xaD3znTZi
	 v2fJP3L0dJ00t9AYdgfG0J3ntjm6OMBVqBa+9rqGur6e2gYC/m9g7F9wL46TE5srVz
	 QsozKb4PgugRyVHEiV3RjzyWptNF1AkVV57tBx0xW8p+MW17es0azvpdDNsJXygDN9
	 kSoCqZPEjVaIUFrml59H9X8LPwpBzgTyUTZ9Yt240XT81W0hwURslC4tC3XSHuX0Af
	 F7jOBBvgjcLng==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: remove two WDC BROKEN_HPA quirks that never match
Date: Tue, 17 Nov 2026 14:02:39 +0100
Message-ID: <20261117130238.3472718-2-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=cassel@kernel.org; h=from:subject; bh=SabDmZfmppGDLD0wj/gGiv40m2jzpbrozf1TZCFT6DU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLL+BORtlb9/ymJiScaZwx+85j8rCuTb+lzkkeui/4mMJ qbngo0SOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRkpsM/4w2hVQKfP4XeTT7 9nm2GyuYXkxKbreap/E2dP+Dz2X7Dv1kZNgYFlxm/fvmwmK/rpB3jk6/ZutV5knmXK5V3SM/9+9 UG3YA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The second field of a __ata_dev_quirks[] entry is matched against the
firmware revision of the device, which ata_dev_quirks() reads into a
buffer of ATA_ID_FW_REV_LEN (8) characters. The ATA_QUIRK_BROKEN_HPA
entries for "WDC WD3200JD-00KLB0" and "WDC WD2500JD-00HBB0" instead
contain "WD-WCAMR1130137" and "WD-WMAL71490727", which look like drive
serial numbers. Without wildcards, these 15 character patterns can never
match a firmware revision, so the two entries have not applied to any
drive since they were added in commit 16c55b038033 ("libata: implement
BROKEN_HPA horkage and apply it to affected drives").

Remove them. The quirks applied to all drives are unchanged: these
models keep getting their quirks from the "WDC WD2500JD-*" and
"WDC WD3200JD-*" entries.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2a5ca1b9ee5c..96aa941c4810 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4331,8 +4331,6 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_QUIRK_BROKEN_HPA },
-	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_QUIRK_BROKEN_HPA },
-	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_QUIRK_BROKEN_HPA },
 	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_QUIRK_BROKEN_HPA },
 
 	/* this one allows HPA unlocking but fails IOs on the area */
-- 
2.56.1

