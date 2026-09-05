Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E34CB8C8
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788626719; cv=none; b=neuaFEc0Gyeb2iqUpuYrsgFGBC2tDVm1oAmqLoTqoIr/+ShdQNL66MOAiZfpHePa8cMNzzOqTYuPjfInirfC1srdN8AksHrNw7GNKPRYjZEWgomwgdhGJGqIA+Titg+AWJ9uwpRoHKzLQ4QUVqd4xlK0bzKAkcXoT2eLcpU4Sdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788626719; c=relaxed/simple;
	bh=HdBAdLzSTzujbllvsJF4/4Myx4fdLg2P7yqQlusvX+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB2BRckBYIi48JwXRq5G1h/fV0L3jQFmp/BI8VAkr9gDHFBOWCEQlZppHaOsnD31DxPLH9S1/DqITVNwaXMtPL2Hiux4mblZIkCbRiUVDe6HvKo43vvBNrle8UYfcbqP1I/xVEhr0SqknT25nVEpntyFD2qzXh0rA3llaaVUzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoMJbhFu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoMJbhFu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso23527515e9.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788626711; x=1789231511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UXpqHFV2712rxC5fNse5LJiD7+paksBxEi1NQ+E0D5U=;
        b=QoMJbhFuOuG8l6M9kcfrHVchJ1sA3K8VcXX9sHvf4KV64ui0dqZaQxiP13c4DzV+y3
         fdHxrGqh+HvShOHBkUze9iFVPZc2XZ0BKvKC3w0bpzibmln+KdCt+djAvjhwwQok7KAJ
         QVCTXS0NY4sc/v3wkWMIJzk4gEIQZyCOIJtwiQ0NZAee3iof4zmjyV6zsT3oenkz+aoi
         2BA2sFly81BjCJIDe85e7qMbYebz0rDi6vAV6KtZlZFNimptRUva7tLy7K2CZw5WMXVt
         KeItXUCqt+TkAcCYntxr7XUou0LJ+WeVB4M/xSiJAUhgmTr+D3KsPffqZi76r06NH+b9
         pEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788626711; x=1789231511;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UXpqHFV2712rxC5fNse5LJiD7+paksBxEi1NQ+E0D5U=;
        b=XLBIiFqfLuIogALEsb+FQaapTAq1EwirFX1sRfQfZPAp34taylPhOEimpgstCGHA+j
         vzqiTjqVr9xWnPQS8zEYJsDv5eZfZjW/lC66SAtgYucQ5GTtDoQ/RcuXZ85SIYDZl2aN
         5zQI+VboHT0QC8F9iMKJjMqXXBaKSwTsbTpMWH3Lt/LuSYg1g5JtN689ym0+qdvDnI/M
         GdxN5XtyNdFiu8Y133Bnp3hMLS0VbshRULVWVWMe7gpTtgq04fhlyC4ZRXuvU+uR4SIg
         wjZnII2eeVo7zPy6tqN0GpziQSiUusLRMdxZF4N9WGxWdj0FonwJD1v2anhu0TpF6Zck
         bgQg==
X-Forwarded-Encrypted: i=1; AKwUvBxqnWscHYlXkVum+/+GHNO+XoHHazcfgBg0cw6dWeRH1XlA8mqMGn4KuZs0DqKadd6yBw8n+wda03s=@vger.kernel.org
X-Gm-Message-State: AFuF++lkWTgvLqSSp7ggDimGdX/Ycjy4z/r7CMGB8Vv8HmRsQ89MGeyE
	XbvKbjlkhW6HumPAQy2gNxEYWpYNHWN8jK8uoCmjmpzc8nmNLaRJiGLt
X-Gm-Gg: AYBFou08LMvGKbl5rFsdc98r1MWTr4paidRpKsRzy8fvTDYwDIxgjtufxXpmxLdIW0g
	7HtaIbK2leIz2xqpnrgGjnPLNOeezaYAx2c02XL3azq0JnUGxrRkJNI90lhk9nHbNRRC3CtppRf
	qP0N7jGKSHvDp9s+0gwDl3LLkrxrAuwEnFykvKcJC2VEPHhhjrP3QuRuqlH4UZ2Untb6yzFcLFN
	rVOkvE/oUzCYortoGIKuDAlJCT1vtpFNvhtPqQd6nSJby7T7mOl1fuxSm6Y/VaGzaSpY7hW+7lx
	Wb1wb1av/oNACzGLk/XXBvQVemTuk6jS/uuHBle5NPgfQRAwAPes2o0d5pm72SHTUPUPfaXgKf4
	qwffzBG5FkeW7YAqC0EvoSLgrosj5YSiyoP4FY9bwaTT3FUPrFqB8UVPTicjESH29J6H+Sno6Ei
	8lvlkmGkF2q+Zy0DWhshvWgkwwQqf/wgL+j1eN8atjGJceJHtC+mVjR3liB1T1ICWCLjhjDO4E+
	6Ncfp6juS5qXs+zyftOJjcS2MFZ+OGkiH3joFKkpITzXRfqu5BUc4/Gll9+BUo9X5tn41k9tD/l
	4htiOj+z1HlwQufuPvRrgy7WYVByOe449BGgXoMrKtnTPOks6+sh51WXtH9Cqk1m
X-Received: by 2002:a05:600c:4e46:b0:49c:fc6e:8cb4 with SMTP id 5b1f17b1804b1-49cfc6e8e51mr106151725e9.24.1788626711320;
        Sat, 05 Sep 2026 09:45:11 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm276714495e9.1.2026.09.05.09.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 09:45:10 -0700 (PDT)
Date: Sat, 5 Sep 2026 18:45:07 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Mike Travis <mike.travis@hpe.com>, 
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, 
	Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org, 
	Dominik Brodowski <linux@dominikbrodowski.net>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Michael Schmitz <schmitzmic@gmail.com>, 
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 3/9] docs: kernel-parameters: Drop the edac_report=
 entry
Message-ID: <apxDtqM8UMN5KNjs@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
 <20260905094649.41996-4-kmehltretter@gmail.com>
 <20260905151345.GAapwxqT93wPWHF7u4@fat_crate.local>
 <apwzmSr6b0WEkW86@gmail.com>
 <20260905153336.GBapw2UFa7Sdc0ve_A@fat_crate.local>
 <871pb7zn36.fsf@trenco.lwn.net>
 <20260905162742.GCapxC_ra7hJd27LDR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905162742.GCapxC_ra7hJd27LDR@fat_crate.local>

On Sat, Sep 05, 2026 at 09:27:42AM +0100, Borislav Petkov wrote:
> On Sat, Sep 05, 2026 at 10:20:45AM -0600, Jonathan Corbet wrote:
> > I would like to emphasize this - slow down a bit and maybe you won't
> > overwhelm the system entirely.

Got it.

> 
> I find myself telling more and more new submitters to slow down. Sounds like
> they don't read our documentation before submitting patches. Especially if the
> file is even called submitting-patches:
> 
> From: Documentation/process/submitting-patches.rst
> 
> Don't get discouraged - or impatient
> ------------------------------------
> 
> After you have submitted your change, be patient and wait.  Reviewers are
> busy people and may not get to your patch right away.
> 
> Once upon a time, patches used to disappear into the void without comment,
> but the development process works more smoothly than that now.  You should
> receive comments within a week or so; if that does not happen, make sure
> that you have sent your patches to the right place.  Wait for a minimum of
> 						     ^^^^^^^^^^^^^^^^^^^^^
> 
> one week before resubmitting or pinging reviewers - possibly longer during
> ^^^^^^^^

That's for "not getting any answers" which is not the case here.

Sending a vX update sometimes feels more urgent because you don't want other 
people to read your buggy old version. But yes, some patience is also good
there. 

Thanks,
Karl
