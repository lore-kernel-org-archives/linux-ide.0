Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6277118784A
	for <linux-ide@vger.kernel.org>; Fri, 17 Jan 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125995; cv=none; b=qMXKG1GwmKxapRC1Dfq2DZKdPkdf4ZNEO32Q/bxr7qxHkfnOMdX/XxoF2XtNmb4cZYtCk3lzgOE5lbG5nQJzBhtzWp/aJWje+uQtukaX2AoLpEMZ1UXbDAafQewBCpqPqKwdYCyytYYrupb/DuYvwjQVjFTwZKLAri9jXZnlDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125995; c=relaxed/simple;
	bh=FYIdVyLJ1VEZanD40elISQhj8UBKvnUmQ14RDqI3Rcg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NscKcXuxu7onCaCOzWfX/gDxAvNrtSLg3XbDoIev4PSvt9fzF592VkA4RT33qn66ZbJd0yQ7AGmiADf48DsAbudsP6vPmq00jYKg5jkg0ohuSxtyIOJWXXSKbDqeDohpeTo/XWRErd3jz83FH1p0QIiDxNx910xiU18xh339/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dA3skjkt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dA3skjkt"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436249df846so14701615e9.3
        for <linux-ide@vger.kernel.org>; Fri, 17 Jan 2025 06:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737125992; x=1737730792; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoY2CmYqDhwCjr+LTaQT1CEx+jVsjk82eanBRDuR1qg=;
        b=dA3skjktSnO+ewKKOne+ZBopa1eS5wgGVcJKpt9Cb3xR+luFftABtf2wPU+VpwaHee
         IeUkxlNYzimWj202H6HiFJo4D0sgEw2Q/5YLCtprzNAgh5ucIROD7jtGNJ0XXY9IV5FK
         fgzDaBqg/ueKh4za5lgOHOs30D/MRLWViJQvDemnYuEBT6KZk3MG3kq7tMxaVnDTSi6k
         IQueHPh/rrdus/yQ+YmMhQbvl8jORP477NL0DrGDMIMf67OS/hHQqHDCa5EoiFjvntrp
         zKHyYS2OopY3HBtKcjTVbCHPfy1mSuhSdM85iUdiBDPxxDWLx03p0TQZM2lsIPRR9ZNe
         gcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737125992; x=1737730792;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoY2CmYqDhwCjr+LTaQT1CEx+jVsjk82eanBRDuR1qg=;
        b=Urp9siOAe+mT0di3SC+ex+ulYpKOxPrxjhMhpim4AWcVKnU6mvRfm+PimtG5rMph+D
         vs+aJfOjj6ywXJS4BWJfhH3c7J7bl/4Zl5hj8tieOegaemwmu6u5kmpU4Ig5tTj98rCF
         3WUJ5Ik+O6/UU0q8CpTV2fXcvA/QsPRihLbAe0TpRJb08pfWh4eCshdfv4QE4BOEEWyf
         c2685K0IRflrA8tcipJtbBaq2G6BcXZiPRlE7IMWqp7DRaRDWZraOmLkYyFCmf6DEiqF
         CW08KOXM9F0+7+2QYsKcDiqJyeNqSfGN3dTH031bVw1v1Mht9Qty6SkYrKk8ZcX4mVxb
         2cKg==
X-Forwarded-Encrypted: i=1; AJvYcCUDEy+wCcyfWyCe0G8ttNouoLbUCYPP3VIvHGcjGPOCnNPaL6YzznlErHWHRScC/k9HrXeCdEsqMn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHvjTy0y8VlPMo4ccGTnzJDBImazTnr92aoFIDZXzFoir1vLX/
	FagjaMlhWm9IkMan66KupwV2VoSV91RgEiHsebjO14rWBbHXWZfbCOUk1ShWBio=
X-Gm-Gg: ASbGncvhx0ubPm3g9SU60Q21MwKXtSs8it8eQI4YqBnj7EuJp24hQi2/HGgXGC/uign
	qfHFbJSPJ1G2D1PNOm8AjqCMVzFiuNumkirywlMNVNw3xtyzjuYga2c1fa+8SWp8o9vltNTpe2N
	+K0CamGFP5xFKUE+i07vZf84ZofWGDsxS0M14FDXokXznWgfDSqWfJnsszkQ3fRoU3+HdE2VrF2
	OCQGKBgLANaoWhv7ju+LdVgUT2t2FJSwf/QqSbQ2qU325DPVnI45/qLhzhtVwBAHQFH1A==
X-Google-Smtp-Source: AGHT+IEeRJ9cpKeNPyOpv6YqDFfsJM6JExhw0J3WkruNYdK28qTCi2QUozVixRXMXz9wRrk9NPLQtg==
X-Received: by 2002:a5d:6c6f:0:b0:38a:9ed4:9fff with SMTP id ffacd0b85a97d-38bf57c070bmr3026621f8f.51.1737125991738;
        Fri, 17 Jan 2025 06:59:51 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275556sm2751940f8f.72.2025.01.17.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:59:51 -0800 (PST)
Date: Fri, 17 Jan 2025 15:59:50 +0100
From: Michal Hocko <mhocko@suse.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: REMINDER - LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z4pwZkf3px21OVJm@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
this is a friendly reminder for LSF/MM/BPF Call for proposals - you can
find the original announcement here: https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u.

Please also note you need to fill out the following Google form to
request attendance and suggest any topics for discussion:

          https://forms.gle/xXvQicSFeFKjayxB9

The deadline to do that is Feb 1st!

Please also note that we have decided that there will _not_ be virtual
attendance option this year. Nor we will be streaming sessions. We are
sorry if this is causing any inconvenience but we have concluded that
we will use our constrained budget more efficiently this way.

[1] https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u
-- 
Michal Hocko
SUSE Labs
