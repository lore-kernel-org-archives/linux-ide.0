Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDAF331EBC
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601629; cv=none; b=W542q1Tz9hHR8fdGOIXAHlQndDCRuja4k+8Vk15bvsS95t+YO1fHTmQLqifb/RaZaUh0WBhdPimyZM5ssU4NkFnsLplKz/379MiFzcscvMlyq1o/xvvaBJVPNUAsUYRcuMeh3sX76W2Ze9tzopk8y68Xr00y59thgTS8OfnOhZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601629; c=relaxed/simple;
	bh=r1zTAstGx+IQRZSz2V3LqeUHrdmsIckPyGpER4pVwcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GNPVWm8+vvU2iAFIEIM6GiFB7rhvIH44T5njE+W4l2kkS0eFVyyiU/wKC3R1QwqsVKI+EgCS2M37oSxb5HOlaDRomLv9bC60sW5ul/TexzO7PNxMRvTtpe69atKJ4GSXwD38kU12eKkJc9GaVxuQaJ+ck1xy6c2uz84rPk4LaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mqzc5uFI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqzc5uFI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b8687630fso16356535e9.3
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601620; x=1789206420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0rL+/iAM/i65sRrJdGWBjEYqO95wvZ81bUVdK7eRsAk=;
        b=Mqzc5uFIvQMGJH/Qvx9JF0IzrPctKlDeb9yowyBBnvUHbJf5jBARJGIOZJ45uNB28k
         8Z4q/bv2SqU25SFGtZ61Xd7F777i2Dq9EaTA/Zrj/rZFEXnioKAWjArU0Qu7i5h7gHXF
         Ner24Ov6fTQNGs33qhIXnkra+vE1dBm7taglV8UME4MALkC9WK/JVUhq9u+mXQj+o59b
         wKASP4FMp090Fsvh9lvAmn3il43ycNJs1EMS0myNTLfxMK+UoErDjiHTKDGPBw0vwUq3
         KnFQWL1E5SlZeG2rkKaJMNU9CyAE4Ob48i9+WHPenGupCpxuQvAs1KuJ5+jSwkCkwIDA
         +G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601620; x=1789206420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rL+/iAM/i65sRrJdGWBjEYqO95wvZ81bUVdK7eRsAk=;
        b=GTBMojW5VxFl/9O/E7D2LtbXF1JN26lDllYiBp46+zZvpah+DQsougU2f1LdRROJrP
         EBdBaArqsV/YVSVzciw0GQOwS4dl4td2QF1aG7tPjXPwNMrsBhYaGl0+1iUtYBdCSXQ7
         RdJt9A/bzt+z0bsRwCSWkGKW1n9J9mlBID/xo2xzHa5AA2xdR0UMn9f38iuy0N6ee4+C
         kIvxqMS5WOEadi/ahtSa3Vp78/Ttsr8a2k/MBR+ZCtJWLhVV2bT9GQ3eEZIzuoSrnCAq
         ZLnf4uQcs/kIZS7XgQpRXnD4JNtV6kjl4ajE3/QUNOKp6Knmc1QJ2+7RaFeiAPr8mbi0
         nq2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzrmo+UxeiYHJK7YaQcLoJkxpOXEU721k4JVX6p3Utr0HZPjJpER0fE17hunbI0WyxeL9/aFV8VFgQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nmYW88EWMlJVBVRxxy/6cv6RJsYiLbRPnCfxiC1cui03HE6nth
	pouJKWYUofviJHAf2WtXr5AHLxdLQfVrKWbCGENpyF9dxltkAqRxyYox
X-Gm-Gg: AYBFou3s1Oi20sph8HG6SslIOxTiIGvMEFytNHvIvTCA55a4FblVmOJNR8dRNxvMaj9
	gN4h9zuiOH6HdDnf4Ya9J3zFVqILvy+obnztbcx1cT15QP9fm7c2nodcx0dQ/fOnPLyZvgdYnLd
	gW2oFoWcFFKhmZG2pNvH5+tvNPiwp1pP2ost9gBhTokZ75EPrIJTD6lp/UqfLCiwmW0lSSPL5+k
	WfVK87qV1KDjcvwbB4dLiBOW8bE7vp1MQwNlWG8mmx89CFJTNUHLkEkolL4Q7l2v1jlfsucm0mx
	h8aBz1Gwt5C6COTDNJoIf6XFOrLorSv4DoIXwevXuizOyx7wKhtTvlclNLFlv6xwWSa4U7H3SFa
	F14RtA+1jYZex3iONDixJXoX4HIhTWaZ0KHQsrTkYbRREGHuPS4gBXioL3Nd6oZ4zEQi7v0kwpr
	9Ld1Kdw6K3KCoFKtkmEzXg24Zykq65zkTtvHsbJD52X9qvTtlerCKJqOY7zQG8XNYgDC/1xD8vH
	OVru/HVHXHaLQWSm+xLSFZkZd45VAUT17aZq62KxPglFcKWosP3gVzMxUny1CoxJZy79v+IxzTI
	0PtAWlLjUXVL2CmrzU8pLTBv4PMExmPO/2ehcfYPWYFhpKf/ykS9isbGLXtUvCCOsAc=
X-Received: by 2002:a05:600c:3e0a:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49cf8267a36mr138818915e9.12.1788601620145;
        Sat, 05 Sep 2026 02:47:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.46.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:46:59 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Mike Travis <mike.travis@hpe.com>,
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
	linux-ide@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/9] docs: kernel-parameters: Remove ten entries for parameters that no longer exist
Date: Sat,  5 Sep 2026 11:46:40 +0200
Message-Id: <20260905094649.41996-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-parameters.txt still documents ten boot parameters whose parsing
code was removed with the drivers or platforms that used them, one of
them (atarimouse=) since before the git history. One patch per
parameter, each with a Fixes: tag for the commit that removed the
parser, so the maintainers of that area are on their own patch only;
the two pata_legacy module parameters share the last one. Each entry
was checked with git grep for its __setup(), early_param() and
module_param() handler and with git log -S for the removing commit.

Changes in v2:
- patch 9: drop the Fixes: tag for 0dcd0a76370a, which removed the
  separate pata_qdi driver and not the pata_legacy parameter; both
  parameters went away in 3c4d783f6922 alone
- collect the Reviewed-by and Acked-by tags from v1

v1: https://lore.kernel.org/all/20260905070347.25902-1-kmehltretter@gmail.com/

Karl Mehltretter (9):
  docs: kernel-parameters: Drop the atarimouse= entry
  docs: kernel-parameters: Drop the bau= entry
  docs: kernel-parameters: Drop the edac_report= entry
  docs: kernel-parameters: Drop the enable_timer_pin_1 entry
  docs: kernel-parameters: Drop the mini2440= entry
  docs: kernel-parameters: Drop the nomfgpt entry
  docs: kernel-parameters: Drop the omap_mux= entry
  docs: kernel-parameters: Drop the pcmv= entry
  docs: kernel-parameters: Drop the pata_legacy.qdi and
    pata_legacy.winbond entries

 .../admin-guide/kernel-parameters.txt         | 67 -------------------
 1 file changed, 67 deletions(-)

-- 
2.53.0

