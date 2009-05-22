From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: drivers/ide/ide-core: Convert printk's to pr_<foo> and dev_<foo>
Date: Fri, 22 May 2009 20:22:02 +0200
Message-ID: <200905222022.03294.bzolnier@gmail.com>
References: <cover.1242676752.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:46685 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756326AbZEVTCu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 May 2009 15:02:50 -0400
In-Reply-To: <cover.1242676752.git.joe@perches.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Krzysztof Halasa <khc@pm.waw.pl>, Borislav Petkov <petkovbb@gmail.com>

On Monday 18 May 2009 22:11:26 Joe Perches wrote:
> Standardize printk's by mostly mechanical conversions of
> printk(KERN_<foo> to pr_<foo>(.  The KERN_DEBUG uses are
> not done, deferred until a more standard mechanism exists
> 
> Standardize pr_<foo> logging uses of drive->name and hwif->name
> to use dev_<foo>.

Looks fine but please:

* change the order of patches

  Converting to pr_ in patch #1 just to convert to dev_ in patch #2 was
  fine as an intermediate step but now that we have patch #2 you can:
  - apply #1 + #2, revert (ignoring rejects) #1 and generate new #1
  - on top of new #1 apply (ignoring rejects) old #1 to obtain new #2

  It should be pretty simple/quick to do (especially using quilt)...

* push ">80 chars lines" change to patch #3

  TBH this change is "a can of worms" (breaks automatic checking with
  checkpatch.pl, creates precedent, makes code more difficult to work
  on for some people) so I would prefer that we together try to improve
  code areas identified by such patch before considering applying it.

* make sure that this patchset applies to ide-2.6.git/for-next
  (or linux-next since it contains the above tree)

PS (answering your question) patch #2 is correct in using hwif->gendev
and not hwif->dev -- the latter points to host's device

Thanks.
Bart
