Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA011FA85A;
	Thu, 24 Apr 2025 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527421; cv=none; b=tq8eab/ubKt0PBTwUYDwjc6XbBUXHkQEulIYCRnpW+t3mly2QTtjW+bWoX03tIRMHFFMg27iX0Crz+lH0C1+Cq75yK/LldVcZOFbeUUlWtW4pNatM0C3vtt/NlKBwHjrJ9xfNp62rtzEBzoqObFEWl8/YVqLcwgct2V+u3MfOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527421; c=relaxed/simple;
	bh=jWbtE072NIrMaIeBIzJ/yXydVqEkK3qVNeGEeCKQ4B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cr2nsnJKtkw4tan2NcuSXVQH/McbG+wWkgW0S09UhoVt+j7XlFzB+zZFbuMZ4jJkxtQzI9kcwOi5TkcFL3ueWtdSNa8uIaZFEB5w6/T5MQ0QU8vQjhfuU87kHAJW4ek92P0RLQF8WvLgqzB0DwALwJDQn5TrOaU1hDvCtO5P4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6se57LP; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6se57LP"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e72bb146baeso1395159276.3;
        Thu, 24 Apr 2025 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745527418; x=1746132218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kibNvjYZjZYJR9PgTMJi3nr7GCmsE1rsbx1EBNX1cuM=;
        b=d6se57LPyHH0H93OZs8LQBzhHJCrWolqC3f93hcHyx6vy4mo1WomzSapz5mU/JL7Ry
         AAJY5/Hjk2dLoDbJtFg5ehe2kFDnLLXXLc47iTxIc5R3sq9gxo079c3i8m/0fQdaj6mr
         F1KDojeuEqzT2kL2X3J3MTVPCFOpjApQ+dNqpTEdJbDWcemZ/gEqIe4DFEZUxE1lpcQ/
         lOWv19XaTYcfBTE49HXTAa+5vEXLnNqLO7eX45lL1FOHP5gX8TNafZTXYaDqRxe67Tlb
         1PoeFMcnxmZnDoj8cg5mECI2iwyLpnT1VRCOmneMMYKJjUnjIBNe9DDPTUn/gDYeEjBA
         uG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745527418; x=1746132218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kibNvjYZjZYJR9PgTMJi3nr7GCmsE1rsbx1EBNX1cuM=;
        b=Zl0OFJAGAMkZ3XRTBsbhvHDCr9+MTonAHjb+yWFw6zHKrC4C4uRUrFo44jvhEo8UbH
         NiXAG1EpPuJfwO+YJP2RtJ3FmZlNBhzFSCkbCBh9kw8RZoG7MAKgOMd8xUez51qM4RdJ
         7ywxB0yfOuXtDkq3A69c5n3cdXCm7V7ebOO+lRuml8nomvPjiUmdhe+t3JAdJRT9iOp7
         R77Ux81NQqMFHB0uhCiW6SW3TmR1kisOnisBFRzqj2Y7d2c0Nd5xTCAt8+s3cVmgDtqL
         kIcIyMfkiW3HVEpoEYfsbNuCL0ub9Lbg2sSrppdqubl5/HVbMMSZbi9HORh2e9dXVDB6
         Hjog==
X-Forwarded-Encrypted: i=1; AJvYcCUOqYwrp12BCGDWPnU9dU4+U+lNOcscSpdXdv7Fv151i9e2htEx7RRWn+L7NxvHJBxJ5ccbo4TAI0E=@vger.kernel.org, AJvYcCWO6zffKUaV79THC71jxlwvN18YZCV63xqwQpVmk4qN2MpSHV6Y8/uIeUIhtcvIvDwUa+L5ih0un3HdZ+k6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wYZUe5651G/qbt3MvoK0SsG9HyaUMuhCu5Kse4YgzatgH0Vu
	sAFvJY5VD2N+MSdXHXNE80on4ZPEV++pORVWed9gX2aW9PA9b0mfGXMC5zQf6kXGwUnMOC18Rn3
	XBKgMSYCA41UmGNLKZ0oVs+VHAnGzY+Ow
X-Gm-Gg: ASbGnctF9lVqtdnPidzlTl6Nl7u8JBlF8kUKfFAUWWwTqJq12AX7FikhUuQEBPmtDIu
	jeqr9QFBt5nTBO7Z/5z7cr5ZME9NdrjUTKjejGYzI6FVWPaW7W4EKOWDsIGrpaJ5qBklHmkkc8O
	pZ/G2WAivuiit9EHDIUzreQSM=
X-Google-Smtp-Source: AGHT+IGcc7UQ0+MFxh9lLSiRhzOf5fCGqpqJWN/oigg3vrXRTs7T63oIcn1ib8DS92izzMzRa021SQyCvMnr/QFufaU=
X-Received: by 2002:a05:690c:680f:b0:6fe:abff:cb17 with SMTP id
 00721157ae682-7084f129c8amr19443827b3.26.1745527418015; Thu, 24 Apr 2025
 13:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAZ0mTfQ+feHUeRjC3aH9z=sM92XmXASY+3ELzwXJLfk30h_6A@mail.gmail.com>
 <62cfcebc-3280-448c-9fe6-ef6df0b3fcb0@kernel.org>
In-Reply-To: <62cfcebc-3280-448c-9fe6-ef6df0b3fcb0@kernel.org>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Thu, 24 Apr 2025 23:43:02 +0300
X-Gm-Features: ATxdqUHXI9-HqWRMgcmrHXKCUMlG_WouCuHVKNMSZzNA7GGT8FdbiflQSMd5dnA
Message-ID: <CAAZ0mTdUkG5yp+XkBGE9Wc2V8np6r-DyNJSCa7Yo0k2bNzuq9w@mail.gmail.com>
Subject: [PATCH v2] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make WDC WD20EFAX-68FB5N0 hard drive work again
after regression in 6.9.0 when LPM was enabled,
so disable it for this model

Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>
---
drivers/ata/libata-core.c | 5 +++++
1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d956735e2a76..c429ba259548 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4208,6 +4208,11 @@ static const struct ata_dev_quirks_entry
__ata_dev_quirks[] = {
       { "WDC WD3000JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
       { "WDC WD3200JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },

+       /*
+        * This specific WD SATA-3 model has problems with LPM.
+        */
+       { "WDC WD20EFAX-68FB5N0",       NULL,   ATA_QUIRK_NOLPM },
+
       /*
        * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY
        * log page is accessed. Ensure we never ask for this log page with

base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
--
2.47.2
