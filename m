From: David Miller <davem@davemloft.net>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the
 IRQ context
Date: Fri, 07 Aug 2009 11:09:52 -0700 (PDT)
Message-ID: <20090807.110952.124497199.davem@davemloft.net>
References: <200908071927.36367.bzolnier@gmail.com>
	<20090807.103610.209136140.davem@davemloft.net>
	<200908071946.07991.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60360
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932128AbZHGSJn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Aug 2009 14:09:43 -0400
In-Reply-To: <200908071946.07991.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Fri, 7 Aug 2009 19:46:07 +0200

> I've been looking and I've seen you pushing non-trivial IDE bug-fix
> patches with almost no wider hardware coverage to upstream (i.e. one
> of my own patches which has been _explicitly_ marked as needing more
> linux-next exposure)..

"When are the patches to be applied?"

"You're a hyprocrite for applying these patches without hardware
 regression testing you said is necessary."

Ok, you're position is clear :-)

Anyways, the ide-next-2.6 tree is up on kernel.org for all to
enjoy and test, I look forward to everyone's feedback.
