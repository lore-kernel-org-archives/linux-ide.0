Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729683;
	b=jPRr1wThXc8cJAvatOhHM2obEsN4be2W7Z9VSzRWHRRarHFR5Hhj3v+sRGsxVzEuHW2U
	 qazAfQnWT02R7UpuZPR0S4gVW0tBTGR0l/LHCr5CDXFVBZ5qV/mWlqI/TwvCJLTYZxDo4
	 GRYrQCNfs2OuvdMz7urjuthRMNEk5KElzzth0hJVEQ/5Tt/ZTTrrU93hAxeVKQG6oTJfy
	 O2tqwM7uGIj6T2U5nwl2+Mj20SYQnWzQW1oy5snyUEMd14pjAInkHfe1woNb/Bh9OCQt+
	 4MYthacA0tQayg4rq0tMHD/solwzP3ZMRR1yOwxLX4DAADbyajANH2aivYNOzS475ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ivjjARUrAieaHI+KUn/UgI1V7xqs4l7rxB7xnDyFdos=;
	b=VMwCV/MeOzFwuWiMU1xssjRAGEj+mo0lhXp1zZ5U3mqIvnkDfCGoVafMa8ew9mHJUJIU
	 OJ8XPgYBxzKh/BZ5fhfRo8Jf/4jo/p3udbCej1/67MzWDpxdrDlHLpIFG4XM18BfPwGOk
	 D1BytmiO7SDYCsGHLtXcEiX0lSdcAj+enHeSBFl25coUaEn9Y1j2p4YN1YdufhnlWOmeO
	 omvMum8iURbPxGPjdGoeDSkfPRLBFUaF/Qen4x4dmWDshdpNr1534CYonlUgX4/VDpZzj
	 mhRgu8J3ecOYot6dxpAj5tkHaYRjGoIvew88JYbozRGwTmWuNuUAia78CKgD2XHAUlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LfYP0AxG;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5D606A331
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 21:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDF5D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LfYP0AxG
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a9f9473029so5589768b3a.2
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729682; x=1796334482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivjjARUrAieaHI+KUn/UgI1V7xqs4l7rxB7xnDyFdos=;
        b=LfYP0AxGJ9FIZj28kmPQJc/lnKWHwjtDxCLKD1K0ksZxaDdfUJlgSIlrAG4ZP5M1f6
         iQGyiG8377KKDD2VoiBSB4PbHbijdd0b3oe3FMdeyDxzORH1h0t5bHU0rbZAmHp+pjpr
         pTJVB/JRG3dvLdrIm6UD/4L93g6+2aso/tt9XSe5a1KitSmHsPHDY92XUJXnq534P9Lw
         pI0ulPWio8edo5BeLTKl/zrQ8v78lPVWLmw1vHCB2NUzoEW727+UW1OTabrM15DdAYDH
         P9hfMGeh/P5N9uqjat0E6t6j0+83oCk9wYCvB1LI7ahYxRF4WoPwB69IH9ykTYHgYC08
         dHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729682; x=1796334482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ivjjARUrAieaHI+KUn/UgI1V7xqs4l7rxB7xnDyFdos=;
        b=kLVMz+mDOiqQAXhwQ0C0SDN/Zq/4kZRVTzybGT+lM/5PhOjWfy5vEEM64SsTQgbiOJ
         RNNQcGt5ItASt9yielMY2tok6sfHBDMT/xpRyVAQvyZ8ck1r8gwf1QUQ/ntL+yqh8gwP
         ao/M+ofM3mXlTdfB0Wq/yrIMpRdg1Cr9NGFkiKiPztXchtKpeALtU/Xdu+oVNPj/vGyC
         Omzhca3T5kwBWMZTyDk98TA3hICTtdD1boi3+1Rq3oeezpZKj3TSLobmIV1oBWj7vBuR
         s3nXhjI23OEfLtwwFm877FRN8Ceiy2chjL9MGiVN0MaPsmc7scbD/KxSHtuef/u+xtRJ
         Czfg==
X-Forwarded-Encrypted: i=1; AL+hErGhOa34YWA9B2NuVQDsQjHdolbKG5FwMIV33KwjTUc7kORHSfR2PmTcvoNqrAkWxmM9pcom/484Usc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lwUITdnrWF8CC9B/Cwzu97L1Vadwo0WmYq6BEGTDgJvWMyTVn
	ur0eyW0U7T5hwBLFZOcbFlRLALm6wiUYGp9Znzktzur5o6FouqkzbdCS
X-Gm-Gg: AZFdTZcmEGX4n06myvMmypfTgSGPHowUXZ5z9QjUbSzRAY89F3ShA8wIgBV7ud7ji7f
	F3WXTnX0HHgTeqhSkh0FJ4xmFzmxdsI1UkhUsvwulny2FT5tW2+1NhTFxaw9s7iE86fDxIcWKbh
	ybAjyZaoJaysH0jSOO86iTYyXt4duUhA5LCgW9R14njRL/atL2JPLX7I0tYQ3dujEZe4rKXuVGA
	fCdZCV9NfKJBKwaPQUmhs+eOA3XQ371ztZEDF5oPc9UdeiK013pWWVOizi9nCGieJvhg1sOcioT
	8eaoI+S2hM/vGknd5iDYtD2huL6ag/oGo1DL2QTRLa/RP+KsWFG35HDA6GUFRt5xoAOveDIP7mq
	Ew3lqMFpXM8r9KlCtsk6ukPiqy2kEqj0WqZQHq42uHfV/z8+TxJOOjFqW7pccz2Abktf4pBfYSn
	suOUeTPWVmo2VGBNOytZXdy7+EL8X7hQl5cS811PKbLLgiks/Q6JRO+/Qy0vmZ8i5IbVtdEW70U
	ChkDRwgy1FK9bpfYqzXmJ8kb4HHHfYcZGT8/YxnN0z+hSbwuSybSrbU1n14U8uwqpbG6SuaL4rf
	MhlMysVgWZ2byAOr4mw44AiRF7NLhb/6TRaLkz9S2+veAvNI9eCXlP3tLcI1C+VWE+KOYi8=
X-Received: by 2002:a17:90b:4a88:b0:3b5:29e:11ac with SMTP id 98e67ed59e1d1-3b5029e1483mr5276379a91.37.1795729682252;
        Thu, 26 Nov 2026 13:48:02 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm34636414a91.8.2026.11.26.13.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:48:01 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v3 1/4] ata: pata_arasan_cf: add missing newline to warning
Date: Thu, 26 Nov 2026 15:47:53 -0600
Message-ID: <20261126214756.39027-2-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214756.39027-1-artem122novak@gmail.com>
References: <20261126214756.39027-1-artem122novak@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Terminate the clock-rate failure warning with a newline so that
subsequent kernel messages are properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_arasan_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 12f1324461d1..0b3e4e63b66d 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -318,7 +318,7 @@ static int cf_init(struct arasan_cf_dev *acdev)
 
 	ret = clk_set_rate(acdev->clk, 166000000);
 	if (ret) {
-		dev_warn(acdev->host->dev, "clock set rate failed");
+		dev_warn(acdev->host->dev, "clock set rate failed\n");
 		clk_disable_unprepare(acdev->clk);
 		return ret;
 	}
-- 
2.56.1

