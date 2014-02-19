From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] ata: ata-samsung_cf: Trivial cleanup in header file
Date: Wed, 19 Feb 2014 14:53:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402191453020.1192@pobox.suse.cz>
References: <1392608513-24294-1-git-send-email-sachin.kamat@linaro.org> <20140218231430.GK31892@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58566 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423AbaBSNxR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Feb 2014 08:53:17 -0500
In-Reply-To: <20140218231430.GK31892@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com

On Tue, 18 Feb 2014, Tejun Heo wrote:

> > Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
> > moved the files to the current location but forgot to remove the pointer
> > to its previous location. Clean it up. While at it also change the header
> > file protection macros appropriately.
> > 
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
> FWIW,
> 
>  Reviewed-by: Tejun Heo <tj@kernel.org>
> 
> Jiri, can you please route this one?

Absolutely, I am queuing it. Thanks.

-- 
Jiri Kosina
SUSE Labs
