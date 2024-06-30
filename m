Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2447A4C
	for <linux-ide@vger.kernel.org>; Sun, 30 Jun 2024 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719783629; cv=none; b=EzJhZeBUNMaWAlFSBrH+21syfhJ/yzrncBc8psJRXccIltC+jEWQILaKpCs+veM8J2lAFpg8Tr0I/gOg/ZWzhGSz4bS2lnzI9iJSsMu9h+kdj/ULFHR/3aO18JOht7ByaKwTX6B3eQnW3GhjA1zaCg6swzyhFwgppsh/9oKH5WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719783629; c=relaxed/simple;
	bh=lCRLS9wZb6DvwmcckliOUi/OQrixev3RGSrDaJkxEaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MG13nsVd+JmdeeCiezyzaQIlvJW250SZDTellb89SM2c/TcEEky6gNEDUWr4Qng9wGEPeAaMO3BgA5kN7dZjlbQhZ6pjSGjMlFR/uj3duX+jdyGtv9IVG8Ljlnifj8vzPEdJqAVFFMAhVML7u/rXr6HmCtGWuQFVlZhxECcnUKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FNAlqSx4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FNAlqSx4"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so2591378a12.3
        for <linux-ide@vger.kernel.org>; Sun, 30 Jun 2024 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719783624; x=1720388424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sOAGgq2df3sciTlKgcbg5dYSqmoE0zeQKQVcWKKKRyI=;
        b=FNAlqSx4ijg2SIDCBEXwYDfihr+mZhjpbTK70OkGxYwIMYvzp0dErZcOBiJHH26Lom
         VQZ6EZ/IL84wnOTFv/TYxJ1nm1hOf6SaWWI8te/zvgBz2Fp5RpfWxiX07kOwMwXYINMe
         CfYuIWKENPoZEIs/MwS8TFyiI8gCqDZODvFag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719783624; x=1720388424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOAGgq2df3sciTlKgcbg5dYSqmoE0zeQKQVcWKKKRyI=;
        b=ic2QskW4qOVJavyABCr+gb2frAaEcdpxt6nblGtsxrSQyq2vjAhW3ISIReSkpv9hb/
         68LqiH86ZNIE4aSVHTQtkb/hI9oA6G46m2Ye7GarFk88fsuW5JYT8i0Z/GtVPSKb2a6X
         Lxps4x6iDE1bMfvgtKGu9alZCZORlKfA9AMeYTiYfk3UWgTEJftuRzpMR6MhLT14LCM4
         BdoKZQTXUYsRLg5UZGPQIxglApTq8aF3bU/ANfXMdsrar1cFh5iFbAtPVJyroEu2umc5
         pp+sFkhM0cR4uyfNtHnXC7X8YqL4LxkvIHXLO4yfgZyIfz+LbkeZ3u4oo9Hej2pHidpm
         Km5g==
X-Gm-Message-State: AOJu0YzxV8nBzUojeO/hxGNpVitweE3T+eTgBbhp2HUjeChVmY/PV9Oa
	MxumJpgPT2hoRQYBLXOqCRTtYf19pP/giRoyvYWfOfxc5j2viIaek6/EIZsJj5gnvZZ2B4p/oUB
	oA6I=
X-Google-Smtp-Source: AGHT+IFi1ZARxVoNTD6pmydldKL0o+B6fG1+y3BDoEDnfC4pZ9Iwjp2bscpPpcn6/s9PB3l0zjnduA==
X-Received: by 2002:a17:906:cd13:b0:a70:b24c:18a3 with SMTP id a640c23a62f3a-a7514498c64mr240853766b.71.1719783624400;
        Sun, 30 Jun 2024 14:40:24 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7518578c23sm115838066b.127.2024.06.30.14.40.23
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 14:40:23 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a724a8097deso271218366b.1
        for <linux-ide@vger.kernel.org>; Sun, 30 Jun 2024 14:40:23 -0700 (PDT)
X-Received: by 2002:a17:906:1e0e:b0:a72:5470:1d6a with SMTP id
 a640c23a62f3a-a7514422b75mr247768466b.35.1719783623565; Sun, 30 Jun 2024
 14:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630212754.207691-1-cassel@kernel.org>
In-Reply-To: <20240630212754.207691-1-cassel@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Jun 2024 14:40:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjj18++AvGeHRGSVA_sH07gBGSuCkGbcCTwDOVcgS+rwg@mail.gmail.com>
Message-ID: <CAHk-=wjj18++AvGeHRGSVA_sH07gBGSuCkGbcCTwDOVcgS+rwg@mail.gmail.com>
Subject: Re: [GIT PULL] ata fixes for 6.10-rc6
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 30 Jun 2024 at 14:28, Niklas Cassel <cassel@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc6

So I've pulled these, but I'm not happy with how they seem to be _very_ recent.

Yes, they all look trivial, but even trivial commits have bugs, and it
looks like they have had absolutely zero testing. Four out of five
commits were committed about an hour ago.

So please - don't do this. I was close to just unpulling it all again,
and if this had been some final -rc, that's what I would have done.
This kind of "last-minute commits in last-minute pull request" is not
ok.

             Linus
