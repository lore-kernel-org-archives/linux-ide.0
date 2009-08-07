From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the IRQ context
Date: Fri, 7 Aug 2009 20:35:07 +0200
Message-ID: <200908072035.07754.bzolnier@gmail.com>
References: <200908071927.36367.bzolnier@gmail.com> <200908071946.07991.bzolnier@gmail.com> <20090807.110952.124497199.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f215.google.com ([209.85.218.215]:35985 "EHLO
	mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304AbZHGSfo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Aug 2009 14:35:44 -0400
In-Reply-To: <20090807.110952.124497199.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 07 August 2009 20:09:52 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Fri, 7 Aug 2009 19:46:07 +0200
> 
> > I've been looking and I've seen you pushing non-trivial IDE bug-fix
> > patches with almost no wider hardware coverage to upstream (i.e. one
> > of my own patches which has been _explicitly_ marked as needing more
> > linux-next exposure)..

Please note that the above incident caused unexpected/urgent work for
me so I would very much prefer to avoid such things in the future..

> "When are the patches to be applied?"
> 
> "You're a hyprocrite for applying these patches without hardware
>  regression testing you said is necessary."
> 
> Ok, you're position is clear :-)

Those are your own words (not mine), same goes for interpretation.. :-)

> Anyways, the ide-next-2.6 tree is up on kernel.org for all to
> enjoy and test, I look forward to everyone's feedback.

Thanks!
