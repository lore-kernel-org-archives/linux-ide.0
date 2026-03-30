Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9308340285
	for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883837; cv=none; b=NW5LNENklDxJxd2UQkq6iJ6B9rxSRJeVzgj4tgrb+iRUkYEukWjiqLMuuvYlhRVombPBEhBAsRLYsFj7rUw8f0hmyl1TIo9pRla/7o8S2aF9bglYRKz9XsqZNw/8HCdJKSI+WZOnirk2SE0mLrF/UL58Y3g2BJlhW9asOfw9HPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883837; c=relaxed/simple;
	bh=vKtTtdaxTbMHzxmdIDgOgR4OyzbeJtB6KFyrxWr5bzk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rl3tKLD0j/+51OAttbcupDoJNTrP6y38zunndDuWL5Gd59BKyteFQD0X+5dWWSmF9eTth3ySzoVEd9nlD8PFhp4GjGEYQwc9iDY1zYPlw2x+asb8rmg5VJ5aMj4pISQ5tUg8mNDESPGtDHa/7ZuYjTc+R4khhv3fwmrkHG7a3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W69q8OeB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W69q8OeB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486b9675d36so38940475e9.0
        for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774883834; x=1775488634; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tZ+sh5kClVbcLbBVEb5/P74vrNCvPTi1R6CnBaA8cY=;
        b=W69q8OeBBHjj7iR8yd0N9+JSYu+Rn1C28xI50a5n8RUDe3ZI0Qg1bB67yzeDjhVEu7
         thcLeZQakmB4Wd6FyU4qkI8dnxHLgvCq7cwAVU1lS7Loaymp0A2HTZaG4LFb+BoC9FZi
         jRLOrlCE9hqKxRShG2TosnCCUL+Ce0qfOVgIFsmnzMh+hcbE0k1+Ymx3IFAziXafRi0B
         D7FegH7mEhHDkaCEMrz8+z4cZbnJRuM+2tipgm/9u1eC+clyHcpQSIIjgFLvR9iIxvPO
         DqNN010eyEPdFm1GRcahyflwQu6BRM0A3HwMOSUP9oqbMTfnmzibx7C3z9s5eAv3PHRT
         Xhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774883834; x=1775488634;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tZ+sh5kClVbcLbBVEb5/P74vrNCvPTi1R6CnBaA8cY=;
        b=YkS79TLjL++Mnt4s0/z4AaQaDhvvtWS+7FMRgjCWNNseT2q52RafgZu3sJEvh3Uycw
         T01QsLXUPuWq/3QmoeQU2Y37a9zf8g4MCoy0VIQRxMpeEF5GcPPFq4zJ8mDUWKaX84be
         tD5kjdigfYAf63pzdfjUOZL/iSyDB871WFKWjo7WeoBnRtRsS5BDykiAHMdOwlGxd6/K
         xM4so78qYlVe81D+4kIo3CqqCZJj3gjvwjZNlz2kqRqI9RgrO365h+sviZcsPGoCY8fE
         KEub2JtR1eYopRPwGCSudUVKnObvBMNB9F9Lk65UxK2iPFgbn8NCdvcdwuKr2FjLWxa6
         ppQg==
X-Gm-Message-State: AOJu0YwqAyPyBTCtX/W5m0O8+zXdD4mPfGaGT9pm799ke9AZ2Uc48+ku
	bQRHDVJgOTGIRYbb/d0UyG1QuWwU46JujACun2wO6gRQJC9yFw1bK5C2
X-Gm-Gg: ATEYQzxM1jkBJ72uYTruXVY9ks5HBEa388BQ2HydolVOyG7hcwF8p82flvfdpUGCVfi
	13W8k3kk020qG0J6m1DK5rQCAyCLEvcJVSTmmXrLbjRUfifEPRlvrF5rFukee6QDtij2UBLeHtW
	Q6CqNpvIhjbkSv48LuoAqEHJOAieDFfzFms04vp1E2+A7JswXSy9Ua+p/DRGokuBvY29KCaQaP9
	l15ch3uCwjQ644OQmL7D12wJ1IqrJFycNkxlFqUqP5kOcMZD7WL6h7QUopGGsA1VW7XbPRMRilJ
	ad/ESQ0Ji05biVcwHJC+arf2JSE3Y1WgGIxYrUg89Mf4M8Y3UuPMDHYQCUHyaOBmf4V5KOEde90
	y6ZV714mnemiambZjOPTrTanz+NyiByd0zn/xi0YVldJt93mSnIaF4jXtPAYefZ7Tj6Xbg42j3I
	tAG3Ks5GVN7afamvEDpvJ3GY6fAL62ZaMb3pRDgwv1vkYZ5/MDtTCGU0tg/9/1S1hEdPX5fja6z
	j4HY99vjg+lz8doUp9E6BUE8/J40r4okoK1Nnmv2Vq5mqQLrbDEywGXK4OzmWTVbg==
X-Received: by 2002:a05:600c:c87:b0:487:338:b4eb with SMTP id 5b1f17b1804b1-48727ede22fmr224849035e9.28.1774883834077;
        Mon, 30 Mar 2026 08:17:14 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674? (p200300ea8f1aba00c5ab4ea43ed7a674.dip0.t-ipconnect.de. [2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eae727sm143766125e9.2.2026.03.30.08.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 08:17:13 -0700 (PDT)
Message-ID: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Date: Mon, 30 Mar 2026 17:17:12 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/5] ata: libata-transport: series with further refactorings
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series aims at further improving and simplifying the code.

Heiner Kallweit (5):
  ata: libata-transport: instantiate struct ata_internal statically
  ata: libata-transport: inline ata_attach|release_transport
  ata: libata-transport: use static struct ata_transport_internal to
    simplify match functions
  ata: libata-transport: split struct ata_internal
  ata: libata-transport: remove static variable
    ata_scsi_transport_template

 drivers/ata/libata-core.c      |  11 +---
 drivers/ata/libata-scsi.c      |   2 +-
 drivers/ata/libata-transport.c | 117 +++++++++++++--------------------
 drivers/ata/libata-transport.h |   5 +-
 4 files changed, 49 insertions(+), 86 deletions(-)

-- 
2.53.0

