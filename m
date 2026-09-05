Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3653D890C
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591841; cv=none; b=BIcnB2jbBwUUxbpI2ZCRJYWDphPmCot7o1HWYBvlE9PedoYM6fIvsotTLZN3Pkubda61dJ52G2iWluznp1zSa+D0U8N4Z23WAD5BKSoMcB0fYIPbmjUegyTyjaCb63QLbQbjU8njDTFHYo9mICiQv6oVmdIncYEO2OPMqbYoOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591841; c=relaxed/simple;
	bh=mhOUqwN3oOeKlzw4AsIblKh3dvC9P48S/odFVVFSApM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWVNgV6k1C81LrUnMgVb+0DlEZZ0av848P5KFQrnkPPrV5qb58LtUl02fj7tMP32kLAqXlgcDfoItLvSI+UTqO+yKVbJ1RscP1gGHpbxyqPASH3jVjSDLffNv1Hpnl4i0dSSP3ooEuRcNFSyx6oWsyRTsglaUxnZc3FI3Cpbamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rTtTkvs6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTtTkvs6"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so1208046f8f.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591837; x=1789196637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqbG77xAuC4eDU7XlaYrFKEyC2xRrttTZAEX6ejP9/I=;
        b=rTtTkvs6rM4NMcTBt8xaHA01lBlWiXX3jY40M7exjflP2eSuk0fXtdEIVw962mYre4
         Ppkhcmkyfiy99qBQIutIEDXPYrNbMzpER24nQZGdCVpycjI6q5KVdpUKf7835Z626bmN
         0XYU9d3/pG6cwOndupi0QvQi6RdAnlwn51MBcM8TP+BCx+Oj6nw5Wy1oefcXyYw/RX8U
         PlSdHcYzEtkmipy9uv6trEmsh6UITF6Equj/68D50/aotKv+wmjg3xY5J4LrzFrWl1pv
         4ATLBMbxQZg0lwHvXoZGKMF5rEB138MBB7DThJYARD28T63bmsjfq9M9mDodqWNgAR6p
         vVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591837; x=1789196637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eqbG77xAuC4eDU7XlaYrFKEyC2xRrttTZAEX6ejP9/I=;
        b=NNjyv7q21tQePIlGBtjhMUY8NJiKUARDP9eLgViMSSec27JDEVuKTJfOYBnG3jhFhm
         MEmIRSSezOwuV3BfOC2QrERqfLQmeoNO0Bf06pmZYH6kP3F0pO1frOLFnotMr255leZU
         /DtACJUQvCRCSrRj6hiwE5XfNsfiZM2THXaVdbxwAzkvBWzfXglvmUB29VDiOzQk82cC
         qPgflNEhKdcvqLzWIGO1xRo+CmRSYuzzpdsaBQ4/7OC9cMbbnOSVFEPciCBite2mz7Et
         R9Q1mA8ww3eYPFmIboLopwwbYYec+5twupcOZAzbal+KCZI2Fdt+gJ12eO196YBUe5wq
         ByMw==
X-Forwarded-Encrypted: i=1; AKwUvBxqEVHeaVtF4b3UBi0vl1NlyYsaPfdea2OfGvhyEHCXVxKkTMIVuI2+OLhEh2g7EOdiK5c7D2R1BVg=@vger.kernel.org
X-Gm-Message-State: AFuF++mhs8AhMQuoFk97/sIFZPyKMc9bnPMNt1lS3zUsTSUFYhci9UYe
	waLi1yquXEHMnMyvbMAsMcaXp5pQCYl5kxQqPHUIBkTaxvriZ62PPaIn
X-Gm-Gg: AYBFou0StEgzfRxdyTCMdEu9+zz97uLMGWX7yA70pExqSt3cCxHz2NvgTrBm62vdsVs
	vG2U0p5blct78jHCmIrPoi7uaFITAL5D5aSj5sXjp4W+UqS/sFys5JDcLNK+TJzxMQsn9IHPSOH
	v7Subcx1Co6BmqSdBDdCX6atGODKk6tPKKPSD6wYEnxJo3L7V6Gnm2gZpFLIbSuRonkehdBzvqm
	3SolQDVcYI9lO7gGw7z5CH/y5rngmNbXqi11ZBfSm+8ro7pDeiB1VLYPgqOb/oZ6XsAjvnm3MAu
	X7JoZeIxe32+yNHw/cSZXtA6IrG6cYpUhRlBFD4ccTWRCGW4Xlo8cCf/GJ/YMBOeH8AASdS6UbO
	q60k1jev76svYR0atCmLDa+37iyAC/A8pIYiVOncnaTaUPwfVn0dXQBaFvLL08lyXXNukx0DHz6
	UlCIqiIH+3ZxNcbzb4mowTLBCV/6nmg61NTBQnXk1GMKvFc9Gkzr9YGA5uevRjcDYyGV1es64on
	A0cNcppt/WYP4q+HcTjySKJfjQcfSR7Z8TYWnqvl8A0c2ougjEGwX9VOKY3CK1nUM16CyK9MomU
	xsZ2/578+58/5CTt7zhHmtcKTjTR1xqaTKrW0dBNEN4dpCciowefSG2tnhDYdlQyGTqlCXm0
X-Received: by 2002:a05:6000:1a85:b0:485:8c17:9775 with SMTP id ffacd0b85a97d-4858c179a0emr7751270f8f.55.1788591836769;
        Sat, 05 Sep 2026 00:03:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.03.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:03:56 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH 1/9] docs: kernel-parameters: Drop the atarimouse= entry
Date: Sat,  5 Sep 2026 09:03:39 +0200
Message-Id: <20260905070347.25902-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905070347.25902-1-kmehltretter@gmail.com>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing in the tree parses atarimouse=. drivers/input/mouse/atarimouse.c
only takes a module parameter, and git log -S finds no __setup() for the
boot parameter anywhere in the git history, so the entry has been stale
since before it.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..c8d96de4c00d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -591,8 +591,6 @@ Kernel parameters
 
 	ataflop=	[HW,M68k]
 
-	atarimouse=	[HW,MOUSE] Atari Mouse
-
 	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess,
 			EzKey and similar keyboards
 
-- 
2.53.0

