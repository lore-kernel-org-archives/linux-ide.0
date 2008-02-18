From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH ht6560b] Force prefetch for some devices
Date: Tue, 19 Feb 2008 00:14:55 +0100
Message-ID: <200802190014.55761.bzolnier@gmail.com>
References: <47B97EFA.2040805@caiway.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:65126 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757763AbYBSAuu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 19:50:50 -0500
Received: by nf-out-0910.google.com with SMTP id g13so626384nfb.21
        for <linux-ide@vger.kernel.org>; Mon, 18 Feb 2008 16:50:48 -0800 (PST)
In-Reply-To: <47B97EFA.2040805@caiway.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Cc: linux-ide@vger.kernel.org

On Monday 18 February 2008, Jan Evert van Grootheest wrote:
> Prefetch needs to be set for some ide devices to work when connected to
> a ht6560b interface. This was not always done properly, causing a system
> with a HD and CD on the primary interface to not work properly. Or, in
> effect, hang hard.
> 
> This patch forces prefetch on devices before checking whether it
> is necessary to change the settings in the interface
> 
> This patch should also be applied to 2.4. I don't currently have a
> 2.4 tree around.
> 
> (also change my email address)
> 
> Signed-off-by: Jan Evert van Grootheest <janevert@caiway.nl>

I applied it as it is but could I ask you to follow up on the following
(rather minor) issues:

- According to observations from your testing and comments from Sergei/Alan
  it really seems that prefetch bit has reversed meaning so the driver should
  be updated to reflect it.

- Could the old changelog be removed while we are at it?  The detailed
  changelog is kept in the kernel git tree nowadays.

Thanks,
Bart
