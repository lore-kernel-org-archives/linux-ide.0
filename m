From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.28-rc3: WARN_ON(ap->nr_active_links) in ata_eh_finish() with
 pata_ali DMA CD-ROM
Date: Tue, 11 Nov 2008 18:08:31 +0900
Message-ID: <49194B8F.80104@kernel.org>
References: <200811042128.10356.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59991 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbYKKJIj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 04:08:39 -0500
In-Reply-To: <200811042128.10356.arvidjaar@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Andrey Borzenkov wrote:
> Every now and then I give pata_ali CD-ROM DMA a test. This time I got
> someting new - not only usual timeouts but also WARN_ON. There was a
> whole bunch of subsequent WARN_ON's, but they are likely to be just
> followup errors.
> 
> Also, in the past ejecting media from drive would abort processing and
> all commands waiting for completion would return to prompt. Now they
> seem to hang forever.

The next -rc should fix this.  Thanks.

-- 
tejun
