Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0632FE05F;
	Mon, 25 Aug 2025 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140688; cv=none; b=PqThsgRIpGYwp1L7O2LbJz2YtvrAftYAWeFLhhcqBc9sKV9wL/Y9g0wghSk8Z4MpsCfmKwAlWVIwRw0qXjjnVvNidaGjdt5n8j9yyZLMPVq1gqSuwlMpOj371tzmZFJXjdr7N7d4RFjNxsIEhASVIk0wMLr/wf+KtzmcO+dX8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140688; c=relaxed/simple;
	bh=0tTqNLSeao+s8mHkbv3mY8oW1cUtNZAz5tqBv3Mc/lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRW+w24AdAb8r0Lyju6tPLgLLjEP3rhpvspJzZXfsy6Ld7U5nLlvSTUkzLT1KUQ2GgARtUl3LUMVvEu7N72yUXHt2SSJhsV4rKgzTmFUA9lieQJPf2jVAL6C/fQYwrDGHNSMxvMO5ViMOphKr4+R2hFKX1Dn96ks0smjLKHu0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX7iCid3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX7iCid3"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f42523658so1561907e87.0;
        Mon, 25 Aug 2025 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756140685; x=1756745485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tTqNLSeao+s8mHkbv3mY8oW1cUtNZAz5tqBv3Mc/lM=;
        b=HX7iCid3lwAAQlYCeZLLVKAlZajhb1EljNmGfZT22ag/Sjccpbm2o866IKga/tMZuM
         AFXESCC6gn+XhvcolfDgE0oWFX7UmS/g7qRbUyOyHU9y5jlWH3PjguABCKb7Fm1k5RAs
         h432E7SmhqoDDDeoN/5VPUJ1ksuMykBYneLrBATa6mMV3bLiAG0hopCUBeX3Jyxp7DXE
         v+fW1/h5RC0RDs893gTn2pAMJ2UFTHmKVxU5uWn9um5M2oCXohTYMDD+Je4cd/TxEshk
         urR1vsDllF/m/N0txU6FGMx26GVjPLUIpGgukvf+0OHTGw9UC70TcWt3xG8jgaCKZk0G
         Kbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756140685; x=1756745485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tTqNLSeao+s8mHkbv3mY8oW1cUtNZAz5tqBv3Mc/lM=;
        b=QkRg6QaDJ8Eh8BMpMyasP+7dc67AmPPA+WD3eAMycj4tujEcWY1w6vyQpH1y1+OGZS
         G7RtaTG5hO/d/EJzDJoOgJ03NEyqufY/2YpKI5FyNA4VF6bSdAQ/vxFGxAR8d7iiRBZX
         juuc57G/2l3apBUbdtiXXLGyApSjqRltZ61xER68GPtxVOMC8MOxCXCYQ4q37YIzDmvb
         NK+JeRvfwfbowlpCxJ6atqH0dqj++TtYOIcICRlmya+rGGKGa5ixP3XQYvqO9BZw1X6Z
         u1FE1Eu7i7VxMgeQJKueSKcjRkCyPk/lA92M1mOs1T+CzpBwUSGZ1kHJlIavNoQo86T5
         m/DA==
X-Forwarded-Encrypted: i=1; AJvYcCUlD6wNkBK4hzeBUYZazRMY6+wZj3r30TkRUX2Bcn8apACuyGGAp6mJDottYPsAixIBZXChrAX31sM4@vger.kernel.org, AJvYcCXm6Y+Ya4GvwmB+Z5MM+Q6C9PCG8665Ke8339+pUS7opXUJa/GIIPaR1GcL2iNcrT+T/rjmEBQ0g+MY@vger.kernel.org
X-Gm-Message-State: AOJu0YxHE8BzaCyg9t/w0yWzXUvjpt2NQRmacoCRtKKViQin9YhNNBYc
	vMnPk7lBwDR8mnLXLtMl78sjaXBKGomohae7SyC/rAriAzRajbxpiURk19gG8bDDL5ldvQexTQq
	WI4YOD3scXefpO3r+C+Lea21BA0JttPU=
X-Gm-Gg: ASbGncvsWt/1S4iVLZCmfIEf1HvxmzMvYXtJQajjdJKLcLCBo3OhXQkZkb+JiPLRoCs
	L9C0vyefqETLEcjkwCLeQu6j4J44cG59W8FBkJjW0WUlq98AzDOliHNs7dhp1lCdA//2FZaFoVm
	mVIegWBrhatyOkWvkZ6Hidbvx6gqrMvm5OssBJbU6Gxbf57QomdntJ73u2xWEGWU1+vTiy1QqXP
	nXQJSk++MhJygaf+MtD1NvLjP5YkjuVBrZAKaY=
X-Google-Smtp-Source: AGHT+IF9AcnmQTwHB7f9i+IjOXrfbReqAaZHjQ80ix4RMz3zii0UdN/zvwmeNYYBaRHC6CBXSEDaMMebrpxJR7iyPQI=
X-Received: by 2002:a05:6512:448b:b0:55c:d751:fc77 with SMTP id
 2adb3069b0e04-55f0d3bee4bmr3356491e87.44.1756140684335; Mon, 25 Aug 2025
 09:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822181749.94232-1-festevam@gmail.com> <20250823-bulgur-query-612ab1ddb4f0@spud>
 <20250825-aptly-slicer-41ae905f49bb@spud>
In-Reply-To: <20250825-aptly-slicer-41ae905f49bb@spud>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 25 Aug 2025 13:51:12 -0300
X-Gm-Features: Ac12FXxaSyHGkt5S3ufDr5q-cirSVzxOlcj9jbe1RDFvC6dEGCmpFlDfLS3p02Y
Message-ID: <CAOMZO5DpBr3FWf7UD4REBrV6YUczi4p4=w=z3ShaAFdk23EuRQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: sun4i-a10: Add a reference to ahci-common.yaml
To: Conor Dooley <conor@kernel.org>
Cc: cassel@kernel.org, dlemoal@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 1:46=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:

> Given the imx patch, are you still pursuing this change?

Let's discard this one, thanks.
