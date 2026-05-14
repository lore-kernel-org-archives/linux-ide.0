Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE621CFE0;
	Thu, 14 May 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739916; cv=none; b=d3LPfLyXSzmjg4DVu7NnBRnbEySyG37+kdfQMW1/4iHQNN7aBKfL5+eS5zcvjGDXrXby/THQA0/fovchFEJs1MTj86qRlwk6azYoEIDanyQuCWX3baprgZCns98nCF6/3KfMhtcuIdS1FjmRg2ZjPy7uxaAVaiZ6wQlNwqMiWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739916; c=relaxed/simple;
	bh=8eAnldZGUf6Rx5obu4LdOe1HHpLNfhphUzEsdjwpIgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQAeUVYAWxPm9JX6is14Bw1nObYZfJ4A++nK34WYZslk9D408M1ZpCYbIOsGsOyIQfQxZlgcDViXwLcaaWUK4TD3ze7IB4qavuF4CYhCHgCpKQBi9lqwP0GF4afGKYmaa11vmARpgdfarExIyNR5OneL/LDqo22EzqX60RwGsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iltM5mOn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iltM5mOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B167C2BCC6;
	Thu, 14 May 2026 06:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778739916;
	bh=8eAnldZGUf6Rx5obu4LdOe1HHpLNfhphUzEsdjwpIgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iltM5mOn6pGSuHbxU2VGjtOMZehKY5tYXcsSAWUP0jnwDAzWTSDFopEUZ3SsgbAxG
	 3xN3Lca1UIV5cFrcyddFyIbYWEUBIhisV7c0693aoxD8hqb7jzT09zFdg6FujOqipy
	 QZYRoBdj0+DV0Vvbys9iv3SQfay8bEqLKC5hPzr8wHD2nyOGjMkMHQr9cBoewNLcG2
	 4+P24Z3ggI5EX7u95a72dr0slJYwcbUTK94ZJPuLp9DQM9bgaXrT/Q016ZXgpWmYPl
	 9bOqZMcZI1aT2sWT6vtSVIwm7tSQT+0kIXCxzRBOe1/X6jADdeqJw1TM7YECc9deYx
	 VM2ji7GbnbGsA==
Date: Thu, 14 May 2026 08:25:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH] ata: libata-eh: queue hotplug work on the
 system_dfl_long_wq workqueue
Message-ID: <agVqx9ud0AR1NbIS@fedora>
References: <20260513081001.714630-2-cassel@kernel.org>
 <20260514030742.643ADC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514030742.643ADC19425@smtp.kernel.org>

On Thu, May 14, 2026 at 03:07:41AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch fails its stated goal of unifying workqueues, leaving a Use-After-Free concurrency vulnerability intact due to broken workqueue non-reentrancy.
> --
> 
> commit 30d96f652048a28eb19aca7f2ef201c2aea08917
> Author: Niklas Cassel <cassel@kernel.org>
> 
> ata: libata-eh: queue hotplug work on the system_dfl_long_wq workqueue
> 
> This commit changes ata_scsi_port_error_handler() to queue hotplug_task
> on system_dfl_long_wq, attempting to unify the workqueue usage with
> ata_scsi_scan_host().
> 
> >     ata_scsi_scan_host() queues the ap->hotplug_task work on the unbound
> >     system_dfl_long_wq workqueue.
> 
> Is this description of ata_scsi_scan_host() accurate?
> 
> Looking at ata_scsi_scan_host(), it queues the work on system_long_wq, not
> the unbound system_dfl_long_wq.
> 
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index 9a4b67b90b17b..6cb79a09423dd 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -819,7 +819,7 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
> >  		ap->pflags &= ~ATA_PFLAG_LOADING;
> >  	else if ((ap->pflags & ATA_PFLAG_SCSI_HOTPLUG) &&
> >  		!(ap->flags & ATA_FLAG_SAS_HOST))
> > -		schedule_delayed_work(&ap->hotplug_task, 0);
> > +		queue_delayed_work(system_dfl_long_wq, &ap->hotplug_task, 0);
> 
> Could this still leave the port vulnerable to a use-after-free regression
> during teardown?
> 
> Since ata_scsi_scan_host() uses system_long_wq and this now uses
> system_dfl_long_wq, the same work can still be queued on two different
> workqueues, bypassing the workqueue non-reentrancy checks.

This patch is based on libata/for-next, where ata_scsi_scan_host() uses
system_dfl_long_wq, not system_long_wq, so the review comment by
Sashiko is incorrect.

Damien: it seems that Sashiko uses libata/HEAD by default.
I guess we could start pushing libata/for-next to libata/HEAD,
or we would need to reach out to Sashiko to make them change
the default branch that the use to apply linux-ide patches to.


Kind regards,
Niklas
