From: Mark Lord <liml@rtr.ca>
Subject: Re: [SATA] libata-dev queue updated
Date: Wed, 22 Jun 2005 23:39:20 -0400
Message-ID: <42BA2EE8.7010303@rtr.ca>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>	<42A1E96C.6080806@pobox.com> <20050604185028.GZ4992@stusta.de>	<42A1FB91.5060702@pobox.com> <87psv2j5mb.fsf@stark.xeocode.com>	<20050604191958.GA13111@havoc.gtf.org> <87k6l9k0aa.fsf@stark.xeocode.com> <42A263BB.9070606@pobox.com> <42B98EBF.7020500@rtr.ca> <42B9C8AB.8040001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:26386 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262020AbVFWDj0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Jun 2005 23:39:26 -0400
In-Reply-To: <42B9C8AB.8040001@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg Stark <gsstark@mit.edu>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, James Bottomley <James.Bottomley@steeleye.com>

Jeff Garzik wrote:
>
> You can obtain a patch from the 'passthru' branch by doing
> 
>     git checkout -f passthru
>     git-diff-tree -p master HEAD > /tmp/patch
> 
> or simply by downloading what I just uploaded a few minutes ago

Great, it works now!  I had actually stumbled across a similar recipe
on my own, but prior to your very recent update of libata-dev.git
it gave me a huge unruly diff that didn't look right.

Now, though, the recipe above gives me exactly the same patch
that you posted, thanks!

Now if only the same were possible for atapi-enable,
though I suspect that branch is simply a one-liner to libata.h.

Do you have the suspend/resume stuff (Jens A.) in a tree some place?

Thanks Jeff!
