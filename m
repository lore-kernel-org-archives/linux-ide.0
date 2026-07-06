Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3EF412276
	for <linux-ide@vger.kernel.org>; Mon,  6 Jul 2026 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371663; cv=none; b=naqfgB5xfC6O5eLtQFUpZGzW5Q/HEC1knDhBO9yaYyNdojzds5NxX3U+rnQ284B+rTQuEQpNzLIswxUr0yyrUfKshanYX5KGz1fCYQI51ltka9yAq5Lqhb1FCEp5E8GvPydxPI/kll5fWWfATiNfHzWN2lBeStGEzyJf8PkFc58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371663; c=relaxed/simple;
	bh=s3HmX/X+f0lhUwieovc5I87ItO93dMcnh6GKz5aaolQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jL1U0nq0bYD60maddqmmhkDrkZLR0hCllmKqRCemst75p+bBx8gCez3l2nuhgSd72uEi0ED/Xq5DgN5U2/hE23x/IXQlDmAddZhGWOozo6d/bDfHAuGRGffqwb3KpqGmXokuliF/KOxhv/pv2OqFetJ+uQ0UGrWWGjwC+oqwxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCuKt/7X; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCuKt/7X"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc73f47bdcso43818355ad.3
        for <linux-ide@vger.kernel.org>; Mon, 06 Jul 2026 14:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783371659; x=1783976459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLV4dGqOqstjD7NgUACah9WKGnrbohBkKXo+o2sEYrw=;
        b=NCuKt/7XGoK46qNZoIaHz/qHarKbbmuXqs2MYPqvjg2balsLZeQbHoibsCCmU4gh2t
         Cbf9wHD3+21nB1rrtH7cGldUEJoibiMk+5wb9uqAI2b2GF39RREUWBRdTEZl0GTP9wTb
         N/wHqNyUo2EZxayz+/nYVX2iTeUM6nGSDAaVC7nAOve9EWTi8hyf1rn1ICKLAX2LStjd
         srscODy9wytDkSvsJ3HTsfKqK6xmWai6fTXXyvqFDW6sqYwbEbLy/SgNqtEP6TG3oR/R
         mcqsjOna4rTY8XUdXUaYksu4OEppJPfiAfMO5wHGhSiQZLKkYLv5qjsyoLfKfOHyZXJ9
         HsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371659; x=1783976459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLV4dGqOqstjD7NgUACah9WKGnrbohBkKXo+o2sEYrw=;
        b=VMNPXtHsSt0MU8z1A3ajKZ/X0nIV8w881WjJ10kDvc4hzorUdRF06y6WredJQaqJLH
         rq/wqmcIHyko1zpFq3ujG9FUGmSPaNbKZwPoLNbV19fbCVOCYKKHMo51iTaiL6Svv76R
         Wh7WIQ3/hJBH/we+u/pGKPT8LX1htzR46JgUs03SDU/34lIQ9ra4+8GDi5E2LgZ7uFlD
         8mQW970pK4XHs9DD3hGoZBceStwoVbXTGpHsv1ifwsed9mVcd1V95DoFUkaSefq2rx2l
         wSnOOhT3uRoygAoHpVwRq6+Li+cPMthjrKc8wgMg8fbWQnCBAR9LmMA0Q1uN5Fd3Y37G
         luZQ==
X-Gm-Message-State: AOJu0YyLBN20WRDZ4xsV7hL9wOxM6GPlRk+t0UwXS2OoJYf5fduEqwxq
	GaPjaTJ0SjOFCNXFW7Dmy1QtBxQ0qQyU9U227Lr1YcgNVq/cgnEC4r3FGmNh9OXqC3Nib8zTN6K
	1dMIpx8oWQFxKuA==
X-Received: from pjbdw23.prod.google.com ([2002:a17:90b:957:b0:381:224:393a])
 (user=tadamsjr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d89:b0:381:18c3:1b99 with SMTP id 98e67ed59e1d1-3875779b61bmr2257011a91.23.1783371659024;
 Mon, 06 Jul 2026 14:00:59 -0700 (PDT)
Date: Mon,  6 Jul 2026 14:00:52 -0700
In-Reply-To: <akaHPScetfl1VbF8@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <akaHPScetfl1VbF8@ryzen>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706210054.1336654-1-tadamsjr@google.com>
Subject: [PATCH v2 0/2] Fixes for security locked drives
From: TJ Adams <tadamsjr@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Salomon Dushimirimana <salomondush@google.com>, 
	TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

These patches improve libata handling of locked drives.

Changes since v1:
- Simplified the n_sectors check in ata_dev_revalidate() as suggested by
  Niklas
- Added Patch 2 to disable HPA resizing for locked drives to address
  Sashiko's feedback.

Testing:
- Verified using the internal test suite that originally detected the regression.
- The issue can be reproduced manually using the steps outlined in the thread
  (runtime locking, disabling SSP, active I/O, and link reset).

TJ Adams (2):
  ata: libata-core: Skip HPA resize for locked drives
  ata: libata-core: Allow capacity transition to zero for locked drives

 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.55.0.rc2.803.g1fd1e6609c-goog

