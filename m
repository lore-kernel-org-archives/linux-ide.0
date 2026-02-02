Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20AB3EBF37
	for <linux-ide@vger.kernel.org>; Mon,  2 Feb 2026 05:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770009835; cv=pass; b=fzDqaKeePUPZsyXisfDrRUPUvFAuZPR3S3KOOhmMliQJITL0eMFFBMegD3GlOyyKAT+t4ua6j8v8UBq77LQ+Ezq9uwJAdqCjgGHuuMYWyRWE5zgExQBcEj3dZCNhnLntDyEXcLLPusXkFL6YtXwV/MKqOXVkXbzEtOh8EYx4FGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770009835; c=relaxed/simple;
	bh=INC+ZHNKEOFP4XP49W3q4d+i4FkauVEFCMtk70j206A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgRlWpjAzgqFB4Eb3uI0xNTCU3Tqb6ZoXCW7FqpVP/+CJghJrLsYgF+uqskQTBdV+IvtN6/HIKsMuU/04dK2szs/FQsbbnQWCC7aELa68pq0XiarsSCGuP58zRd2jIWdkvQY8mQSvsYFeJCTb7q/C/XxSkGvv4kowbqzJeMyy4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtOlfcqy; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtOlfcqy"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-894676e6863so48532846d6.2
        for <linux-ide@vger.kernel.org>; Sun, 01 Feb 2026 21:23:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770009833; cv=none;
        d=google.com; s=arc-20240605;
        b=QaE+kRL4Jfx62zfjjqsab6IlRwJfut6mrGsvTH/5kEgf/0X2jKU2nOxpjT0LSZRDB9
         5pDU7IXMIGuKXRp3OId9u4aJyv96ltRN9Cv+Ejud23YvRkzYiqBLc0kZT0we5GdYzpHZ
         vmsoDug7pJafHCofEfcdSHkPu1UlZ93Yvesworfs6aim2N/xfIx+w/xSIa7u9FnNHVd4
         GE+L6PnU/1hWFHmdyWGmaJfIhiRKQSJNd8bJEtKHAfTxVToKqr1oQAjnID8jQ1xmapwG
         SE94f06qZyaxj6NNJPFSt9tWy4BCdcwHwS94DWkwmy1ZCAo07Vj5VwdC4H8p4pVPyFC/
         DJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=INC+ZHNKEOFP4XP49W3q4d+i4FkauVEFCMtk70j206A=;
        fh=xwbopahXrHvZHA0C/4BG1IIz1hyQ2x5swPUXWsXNVZg=;
        b=if2FNYn+4AZpGDj8LlBX+hD6icwheLFH5e+7p55CINyicK5bQtKByXBbsnCR7/gN6J
         iL1fvmiKT+vMoezeBrJKHkbgau2yK50aAy1htO6GKBFWoRV5cYwXrgRh19wuEr/qjhmN
         VZYyi6owkSPjNJVpmEY3N1CPMZv0TEERfPOw2a83wlyWsOSGB9un9RaNWBWR6gwE74pO
         nCZyy62gS4ZqKLkXn3r5W4wUS9iuzUkcE3rrWwsC2CjzhTHjHGFixk1ZJfUggQHSP/hE
         DVZBURQ6f8ex7WMyksYlnUooqBy3DVzXsNb3z8UoqbP5wJ+Rystz/xAgPmvyTI8hn8aF
         4quw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770009833; x=1770614633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INC+ZHNKEOFP4XP49W3q4d+i4FkauVEFCMtk70j206A=;
        b=LtOlfcqyMknSQ7Pka+sGEDGZxOiLhKKw5pf0/dNgQKrC8szNC0J4nrzaKruV13mxsu
         dK6MjaI4Ow7G2qlQlEob7FDEytodMtCAWfkyMhrWirnNHz3usuDpopFFOUQXb/5MQBKp
         TXJCzy3vePJTntmckEQYasOmLex7wmXAB87hY9y9DbgNy64ZRsFVvmWd86fxcP0xVRiI
         uSWw+JHd4jo9YWtiugv5MB8DRvbe81umkN0QZk3jMLcvS1nPVgyM/CG1patbuk9cOY6Y
         hNiZ5BuTHohMF1AlWDoeNhp9xDMoHaMcWKgFj0oEqDxjy73ueTlNICUj8sP7Jp6g8Gg1
         ZcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770009833; x=1770614633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INC+ZHNKEOFP4XP49W3q4d+i4FkauVEFCMtk70j206A=;
        b=v/IwSHpjsm4hlVnarKFmiA4TfcZUcvIqPHK9+2NFcWGBga6fcW9v0kVZGpyh9ECmxm
         bKiHZY6tHVSnIg5vl16uNt4IG72WIoWIZVjRVWYhm5GAms9sA8FFJT1twviqTKI/q5R6
         /JriYLme42lc0gNYMqU46Dfjrb0OxTpcOv60025XouySWZLF7u6uzun/gCUqwBlCDG3E
         +0U3ZOkPMmGyJOPMObiDwzdyfeuW3rtmu1r74MCh/R3cKLr5B5cFLhyM3FXBJNu21CdK
         meuGmR6RVVxpuj86ZjUzBzeDdHjbOEuOiOQPApASpyzNfLSvK8JV3V1rtpH+v7xpWFMQ
         xIsQ==
X-Gm-Message-State: AOJu0YxwxQkmVOfZudsZ5Umdzi91ybl199IqOs2rQHIM0BcVr8mo98na
	aQM0MFOsVZXMmeS7yZVy6KdAcBlVpxPOKaCz67ZdMUF/kYrWGsPRT92LmRFihD7zrlnzbnTd0O2
	48+CG/RAiS5eevkmvlhGPsDS+FK/w7mM2VtXV03U=
X-Gm-Gg: AZuq6aKdqjQnSeU7WJJQpVBiyYvHmqq/0ZHUTMldvTRofQChBN1NTo7zKp1eQFn3F/k
	ES0WqODA4Cxk0RWyYfP8ZDsF6AONcaVyGAGrxhkjuUCo1PHo8+wZ95e/j7HGE6oZOeisBQobv4i
	bInUFUbemxnC+a4fjJalOprxDBo8LEOq2MVX0+NnO3LPNppJV8hjO61UNHvLoCPMCyqCIaxu/yl
	PmCDn1P7LfEMVCkr6ALsXB/jHwgaH+cDruq6JrUG8J2hGD1ztzWH+gkbwHdADV6MSkncNqfdA8k
	Z7P62t0/SlFBpYg3Gi0l+LhVq9tI7b32TagAZhJY35vuUO2nB3nrjPuc
X-Received: by 2002:a05:6214:5014:b0:894:6f21:3138 with SMTP id
 6a1803df08f44-894ea021037mr155063056d6.45.1770009832652; Sun, 01 Feb 2026
 21:23:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131004732.19198-1-enelsonmoore@gmail.com> <32a46d9c-1c60-43c0-825a-4482bd133c55@kernel.org>
In-Reply-To: <32a46d9c-1c60-43c0-825a-4482bd133c55@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 1 Feb 2026 21:23:41 -0800
X-Gm-Features: AZwV_QjDzGyhDTjO-CnQ8J6wqIDyF_S2bPfFHgo4gPrX-GJgoEaCM9ruDf5jjoc
Message-ID: <CADkSEUiFzLEqc02iSb68B4QSL4f7XWq87Dg8BqHF8VNXXL1ZXw@mail.gmail.com>
Subject: Re: [PATCH v2] ata: pata_legacy: remove VLB support
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 8:57=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
> Applied to for-6.20. Thanks !

You're welcome!

Ethan
