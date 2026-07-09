Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6C24D990A
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618621; cv=none; b=MKhhB8nPQ+IH0KolGqvF0A9f/hco9ntnVfEmq1tEWJJZrk/yIE/SiVwpQQqX0DezfrL4DM6VgJNHtnXZpP/sdcGGTwEy6ISxN9vNwDbRwsCr3UT5BjJiZP/4TRSb0RdrMrOGyckejH1kNL8kEHSzEQG9RlUc7pwzQ4zRkB+i6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618621; c=relaxed/simple;
	bh=AMWaGRmKSfCxL0tgNPNGGOAUuljK757M7jjYG6cQdAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2ASEVPXOhJoeVNrD5nRyzJGRrILdabaBAiLeBKPKj1AadL2g2CcSqBUTs37eEteavPkfrI2jpkBY6K5+y/WIsnhx8QP8djmTE5QrIkiWXIRyH/x4tKZluWbKsW5ptK3kJgDfrmN0V84Tjm4TzT0bSVUuPhUe6gxPuD050Dj+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qW+7KVQC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qW+7KVQC"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cb59f6ba26so5825ad.0
        for <linux-ide@vger.kernel.org>; Thu, 09 Jul 2026 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783618619; x=1784223419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2MP1VcZ+pxNnebvnEoAeY6zE9OtvqI5FLv0zCgNS0M4=;
        b=qW+7KVQCJ7EGLd9C9F3sl10tPq0ohhQ68/v0vGvGxB86thTmKa3BW/32rqjnFkk4Zo
         T+ErZUPZ1wEjeQ6mjTTRzfQqnOGAhliS8HmZvugni8nupz/VQ97XkzQnimYhzyC8mm/H
         Su4jGzEmhs1YR3ByK6r75mKwDLXidtOxHksG6jc/Fd64lkoZu4rMxxJzx+A8CWnDYhfW
         UJYWK3B2WGynhn1Lz4/aV7c67Do0T1tV2W9KzPGlHcMUfwBGLGprD9TugdKGRpYPYEMl
         HTwqHL9Ej3FbX/nFSESj7B8h/ZnwZpSg/W/d2tj2atagH8qHnuJEa73Q48pgUFz54zhG
         kMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783618619; x=1784223419;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2MP1VcZ+pxNnebvnEoAeY6zE9OtvqI5FLv0zCgNS0M4=;
        b=HoQO+UKXJv1hvw9PZu28rW3sjwJMfisSatksB1c1xMboy4z/sLG71qfzmj8b7oMl47
         0RKjk+9QKHLNa8pK9q/hLegc4cnInBQ2Mo/ni+6vlTxAC55EsD6MnLS9vU5DalXT3xGH
         Lj7dA+2TZV5oi9dm9orXCs5Oe4r/NsSO6Jl+eWFlojO3o7UZxEJqz9lPPp3c9eJ/jmFS
         IYWgVRh7ndMeFnfdy+vuLdPDyGCD6Sncze0KY5Gt1GF2UMrvAuQomEnDEbYMcJaqELwu
         KICHeXWdg2UZf6A87qubnmSbXWRcFeFv1EX87/Rp4Fo4mmVtfDQcpuz9O//qrGbaM2aZ
         wGVg==
X-Gm-Message-State: AOJu0YyLqVBTaNYYylGmp5KO9peadWrX4l7KAAktlDqNPOG5ItbyvBy8
	ukiOot2hIcURYseM506vQ2h89haAnjDj4S2U75z+VPzLFiomA3EeumEqpxYfXBqyGg==
X-Gm-Gg: AfdE7ck6W0fQt/btR2DCuszEjz7aBUKjt0kVkMAsozfawHhblMfBzszOrjE+x3Jlh1a
	Kxd0xS6PZxJqD6SNVaTXghUOaXvPBTziJxIX+k/vZFiIGdwfGdNigSLVSGi82uiHWfsFbd0q1Db
	IJv4L2laWSKtzrQLUtMLfGskADQ2yaNkrPynMQzuwduqMMEXMvZP2XOHlj/8wlJPlW9my/8va1O
	AVbmjY8nkonfvtX4OQQUv4Ib/VltQ+hZlYPWGl058L7+8+j5OECOiqPVN+S3VOtTyesQ9dp7coS
	fdULD0m6xmKI2yVzI+xJeuvxFroktbfNEz12iQ1VqWSAPkcI3vlZ+WJIbMRdIRAfW6oDmlFacw3
	U71r2WLn6HcLhqJ2DHdpF+BAlkII0iOMv3Wp3tJQ4f3x38U2hcAaMg/ifPcAwUNO7hxMZ5aP05q
	v2OocSgAHNdQDkTthOhPBqreJGi4S5UzhgdcD5q25W28Q4mMW6GqQ=
X-Received: by 2002:a17:902:ec8c:b0:2cc:a859:d404 with SMTP id d9443c01a7336-2ce82e994acmr141705ad.23.1783618619000;
        Thu, 09 Jul 2026 10:36:59 -0700 (PDT)
Received: from google.com (98.144.168.34.bc.googleusercontent.com. [34.168.144.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38d11c83112sm70723a91.0.2026.07.09.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 10:36:58 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:36:55 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH v1 0/2] fixup handling of timeouts with deferred QCs
Message-ID: <ak_cNxd_Kow0lWoe@google.com>
References: <20260709083934.1116862-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709083934.1116862-1-dlemoal@kernel.org>

On Thu, Jul 09, 2026 at 05:39:32PM +0900, Damien Le Moal wrote:
> This patch series fixes libata and libsas to correctly handles deferred
> queued commands in case of a timeout error, to avoid excessive delays in
> waking up the scsi EH task.
> 
> Igor,
> 
> Please retest !

Looks good! Thank you, Damien!

Tested-by: Igor Pylypiv <ipylypiv@google.com>

> 
> Martin,
> 
> Once reviewed, I or you can take both patches ?
> 
> Damien Le Moal (2):
>   ata: libata-scsi: terminate deferred commands on time out
>   scsi: libsas: terminate deferred commands on time out
> 
>  drivers/ata/libata-eh.c             |  2 +-
>  drivers/ata/libata-scsi.c           | 54 +++++++++++++++++++++++++----
>  drivers/ata/libata.h                |  3 +-
>  drivers/scsi/libsas/sas_scsi_host.c | 17 +++++++++
>  include/linux/libata.h              |  4 +++
>  include/scsi/libsas.h               |  2 ++
>  6 files changed, 73 insertions(+), 9 deletions(-)
> 
> -- 
> 2.55.0
> 
