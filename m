Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3783264C5
	for <linux-ide@vger.kernel.org>; Tue,  3 Mar 2026 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562372; cv=none; b=RyNUObLY+SbeJWoQPYDuFZu1SKV30vqNqHYuuEq8a21LDa+U0uu5K7c4soJeWZp7Xx43wngblJBpUTTdoPYKdUbcEpo3QT/cNv0npwVcmXF5eMqg+nnVGZjbTgpBdNv9uUMl80PSMoE6wLV298yGdFO42wWx05O8kqlJP89R784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562372; c=relaxed/simple;
	bh=1v+tCKAD/1iRiPErkhLp9KYQ79uFU/rBCUvw0tFkyCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSXgN9+FcCXNeNAUqsIFdMv3tpdB+9MQ4I7luwmsLwqYoZgN+hTnF+PSv+AVHxU3d2B+ZqAEGOlxtPYHJJiYeaV8HrZBWx0TCmKF35ESVUqdUeuMR4riA7ZcQQ9ZOIvFblT4t0ser2e3Z4a7ZKfCB6FSdmmozHq46inlksNH5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUSsuHME; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUSsuHME"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae523d54d2so98545ad.1
        for <linux-ide@vger.kernel.org>; Tue, 03 Mar 2026 10:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772562371; x=1773167171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gS8IWzhnK488cirKjk26gFAoEtQU7yjXkq29KGI644A=;
        b=BUSsuHMEQTtki4eAPSPJVYBAetWQE20GBrDl/yjy8f5nI9RRkvxpowqth3gZxh844y
         KXQVEVrR1yQLH6SI/FZ2eFH9Pkr4yGZwllBic33vpNLz7yXPg+WAiZO7pefzCuOidS/C
         t1hxAk2272o2AaEqucjvCNHIRQYiitwHUEKIat5EKbqnBT6m2BlMbf1+N+b7ioGBhkUE
         Zc1QLC3XFBV1jMZtK4rUm6HTE/xRPALGkDw9TOCxdH6BnnF7uqJU1VUbiARKHjrvQZO2
         R2Kdc6cwdU3pLM/tWte5YggyZjy1RB4ZRyddf6YZg3IlE4LsGD9X+OiAY3u9bTqXqBLv
         M+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562371; x=1773167171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gS8IWzhnK488cirKjk26gFAoEtQU7yjXkq29KGI644A=;
        b=CHDgnKYKesPMo0JHPzXkDYOhs2aOI2lY23WwZICcWhaC9Pe7Ay0W5OgM6y0c2lpw5q
         P2CQ/6CkQDqwSqet901kp6+rghILaGd4tsb7ihk0HpbCOPRSTKegT3If/TYeF+byyjaH
         VOyjUuTh2HhS8Fu30SbkCIggMYdPzaBIl/bYh7XETKm/I/3zWsPHfl1i1nU49jI2kvVr
         a9144QXZKD7/CTpaWNj46vMB3syVeLygxvKMIUsty/Oyfd780kP507KXqB+TgBwe5yYd
         Hb0UldNz8oiAIHtk7SZIQBIOCrB2Z/9JM+ZGR6J59ThJBOAb/Py6YAgbVuIKOc990U6s
         bnxg==
X-Forwarded-Encrypted: i=1; AJvYcCU48xbO34I28SCFWup6stoUIU40oLhAnex5uPM3OmpL/Jdp6Ak2/gkDiPUCRLEcZe06VoEmZON5i5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUOruWsxJrHNnFWGbFBm/RgChQBihYfXYIBlmm8UmWMmdu3wzS
	SNrG7c9T1j7w8BRbdbiMuSvAj2TZQuRoc2nbupv7YBd9saWk42QshGA2JfVGVn4cng==
X-Gm-Gg: ATEYQzwUXVcOEtE/ZJg3mPMdEno5XIA1cWIVmQIMCSeykQfrjKoa8K8CSl2kXerHCTG
	n7dBmkOJ5t1rH0FlvNESkEy762YAv+ZexakptZrgWMA5/8/Bdu8cZQ9sKtv9pc08MTNj75V7bs/
	mVl3hNJlQPe61M7WoB8aQ7fTstGXA+P55ehOPWSdGBIrUFCt7unJ6O6EYDYN5v+J31zzyeodmPL
	BBm2Z/MkkbuvmpPM4T26CZNwMe0QHxru7MD2OkFG4UnZ0a4BQx1jqNF6K2DgRz4Ak2a533pHrQ3
	Pc2YIzKkjSeFsvUKBQHp0TvbT0pExxmRfSet2+LGfPM6Cm9NJljSheLx2lwVpyXsskhIDt9Ibtf
	hG0dEeHxm54tHXbLyWV755U1aqk0VfI4OOhvw9puosvqKzMPuUzp7FYhNArMJ48JaDVNS/gI/ps
	nHb8h4zdqzntNM+v+VadTwWfxVNC2pRSUQs36yVop+sDhkv5c7OT+GX1f6K7GT5h0U27a01g==
X-Received: by 2002:a17:902:f68c:b0:2ae:567a:c5a6 with SMTP id d9443c01a7336-2ae567ac7c9mr5295995ad.15.1772562370543;
        Tue, 03 Mar 2026 10:26:10 -0800 (PST)
Received: from google.com (33.75.230.35.bc.googleusercontent.com. [35.230.75.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c39def7sm2881520a91.12.2026.03.03.10.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:26:10 -0800 (PST)
Date: Tue, 3 Mar 2026 10:26:05 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	syzbot+bcaf842a1e8ead8dfb89@syzkaller.appspotmail.com,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata: cancel pending work after clearing
 deferred_qc
Message-ID: <aacnvfNHFm8BsjKV@google.com>
References: <20260303100341.362978-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303100341.362978-2-cassel@kernel.org>

On Tue, Mar 03, 2026 at 11:03:42AM +0100, Niklas Cassel wrote:
> Syzbot reported a WARN_ON() in ata_scsi_deferred_qc_work(), caused by
> ap->ops->qc_defer() returning non-zero before issuing the deferred qc.
> 
> ata_scsi_schedule_deferred_qc() is called during each command completion.
> This function will check if there is a deferred QC, and if
> ap->ops->qc_defer() returns zero, meaning that it is possible to queue the
> deferred qc at this time (without being deferred), then it will queue the
> work which will issue the deferred qc.
> 
> Once the work get to run, which can potentially be a very long time after
> the work was scheduled, there is a WARN_ON() if ap->ops->qc_defer() returns
> non-zero.
> 
> While we hold the ap->lock both when assigning and clearing deferred_qc,
> and the work itself holds the ap->lock, the code currently does not cancel
> the work after clearing the deferred qc.
> 
> This means that the following scenario can happen:
> 1) One or several NCQ commands are queued.
> 2) A non-NCQ command is queued, gets stored in ap->deferred_qc.
> 3) Last NCQ command gets completed, work is queued to issue the deferred
>    qc.
> 4) Timeout or error happens, ap->deferred_qc is cleared. The queued work is
>    currently NOT canceled.
> 5) Port is reset.
> 6) One or several NCQ commands are queued.
> 7) A non-NCQ command is queued, gets stored in ap->deferred_qc.
> 8) Work is finally run. Yet at this time, there is still NCQ commands in
>    flight.
> 
> The work in 8) really belongs to the non-NCQ command in 2), not to the
> non-NCQ command in 7). The reason why the work is executed when it is not
> supposed to, is because it was never canceled when ap->deferred_qc was
> cleared in 4). Thus, ensure that we always cancel the work after clearing
> ap->deferred_qc.
> 
> Another potential fix would have been to let ata_scsi_deferred_qc_work() do
> nothing if ap->ops->qc_defer() returns non-zero. However, canceling the
> work when clearing ap->deferred_qc seems slightly more logical, as we hold
> the ap->lock when clearing ap->deferred_qc, so we know that the work cannot
> be holding the lock. (The function could be waiting for the lock, but that
> is okay since it will do nothing if ap->deferred_qc is not set.)
> 
> Reported-by: syzbot+bcaf842a1e8ead8dfb89@syzkaller.appspotmail.com
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Fixes: eddb98ad9364 ("ata: libata-eh: correctly handle deferred qc timeouts")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor
