Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6751139CFA
	for <linux-ide@vger.kernel.org>; Sun,  1 Sep 2024 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725229030; cv=none; b=Y2wNlaFiCkJzszPNAx5kzDAT3vKVytpYXfOZ+10K0GYE6E323sf/JaqhZ06M+nzbKKVymLLrmcnzBfawochpqTJsdTdEtZ6EYmm+VDowiLfKtUgEjnLvG+7nI0QiQNbNaao0VimfGgSRx7Ejc9Ennrd4fFjYNUXFCc5SwSKWCfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725229030; c=relaxed/simple;
	bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOBl7+uqZLbxBknDeDN5jyXlBLWMzfc5FzL4Pgmw69kZH/oIVUgSwkXV3pEgtU7VXcSwhH1EYMj/yxIaryDUG4zCE6pjuuRruGnmUOlhFDLbL6FJZNodpQhjIZCPI9c0jENWQBjFg0lV8DjOqGvHZDp8LmVUbQOb9HFgF+VTZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQeKyTa1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQeKyTa1"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3ffc7841dso33335531fa.0
        for <linux-ide@vger.kernel.org>; Sun, 01 Sep 2024 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725229027; x=1725833827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
        b=QQeKyTa1ZHOmdeLtfJQ08oELr7R+lfjvt5DWUSh590msEz57AUPas1fkl/8ZGMqRgl
         0Iu0opmnDjxtg91FlE9g3nLLVZIYs50mxBV5jwuLKOjV3UYlQireUyT2TB0yDh4uiyY9
         sFtNWX0fLiMvj9AeZrRxEqrF+bKgbpxgM33j4hZyIe0Z03WMeeSWO1kFXH6F/j/FpT+O
         LPbqPI5pFhod6fbBZohITmA2zN+58+S9hduNR5fIkbonsuvPHo90j6DzcN3Ur9pvP2n7
         HJ3t8xY12Wz/oB/4ZwZ99EeBsVnJwZOg+nfyyYIZRdOCq879DzKlIyBArjAGBEukeuSe
         yKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725229027; x=1725833827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
        b=hriWiwMLjdIFxKM1nlT+St7CuObcNbadAtRAoA8Ry424K73CNINixeIRnJkNCZE77E
         3hbJMmWYk8fS1IJyzVyUnYUzVcbWJI1s/9Y2Ftq194EqBi64kCvQsrtE/ANIGC1JcWPe
         S1ukpJFBGFdrEv1MAEhpnhIeC9+sJ6/ZDpvlvkwC4LrreoqKzK6JlEpUwBY/VKilOuCP
         P3xoyueM5f5PndO+59jSA+B92kVfa7UuET+pLHEQfLrg+ROr1dZbrtS0XtuQnxyrd3kB
         EmeHckKGR0S4578LrVUFMxomfRJmd/spcff5A+8qVXWf1+3VDAEXBaF3WV5yTXkPvU1u
         lLyQ==
X-Gm-Message-State: AOJu0YwZa5UeHTOnmbVtiGHSMQNRlcgoF0pDqGNokPWUVZGx9lFI4uFh
	CZ2UEzu731AzvySiMOMLPdlYMkKvajwNUito4w3K3EqHG2SLHB54CcpKotq3dKnOdshOLLRMNCf
	JeBp2CvjLXRTn+gpIFH3dox0kJkJhUFcAODfG16L1tfKg2Du+GwE=
X-Google-Smtp-Source: AGHT+IELtYHgrwEdRxYDgxD8aHpOX0/GHHaDJQOuj7XAGfQNHkEYFfltRh55fb3ghPbg2gbymDF7rNGgW5udWeVIpUM=
X-Received: by 2002:a2e:be87:0:b0:2f5:a29:5a42 with SMTP id
 38308e7fff4ca-2f6108a0ed0mr86585481fa.14.1725229026305; Sun, 01 Sep 2024
 15:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831072158.789419-1-liaochen4@huawei.com> <20240831072158.789419-3-liaochen4@huawei.com>
In-Reply-To: <20240831072158.789419-3-liaochen4@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 00:16:55 +0200
Message-ID: <CACRpkdYv5bcDM6B42_pmkEtaiFNQ-mqZzHOPW4UZ-AsPiwuBDA@mail.gmail.com>
Subject: Re: [PATCH -next v2 2/3] ata: pata_ixp4xx: Enable module autoloading
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, s.shtylyov@omp.ru, 
	dlemoal@kernel.org, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 9:30=E2=80=AFAM Liao Chen <liaochen4@huawei.com> wr=
ote:

> Add MODULE_DEVICE_TABLE(), so modules can be properly autoloaded based
> on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
