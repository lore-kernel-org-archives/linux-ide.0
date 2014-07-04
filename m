From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/5] libata: support the ata host which implements a
 queue depth less than 32
Date: Fri, 4 Jul 2014 11:30:22 -0400
Message-ID: <20140704153022.GA764@mtj.dyndns.org>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
 <1404389382-27298-5-git-send-email-haokexin@gmail.com>
 <20140703134717.GA16191@htj.dyndns.org>
 <20140704064646.GA15828@pek-khao-d1.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:48503 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbaGDPa0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jul 2014 11:30:26 -0400
Received: by mail-qa0-f44.google.com with SMTP id hw13so1461998qab.3
        for <linux-ide@vger.kernel.org>; Fri, 04 Jul 2014 08:30:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140704064646.GA15828@pek-khao-d1.corp.ad.wrs.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

Hello, Kevin.

On Fri, Jul 04, 2014 at 02:46:46PM +0800, Kevin Hao wrote:
> Since the fsl sata only support a 16 command queue, if we put the internal
> command to ata_port->qcmd[16 - 1], we can easily change the above code to:

Hmmm... something that I wanna do is using all 32 tags for regular
commands and moving ATA_TAG_INTERNAL to something out-of-bounds, say
32 or INT_MAX and let each driver use whatever command slot (most
likely zero) to actually execute internal commands.

There really is no reason to permanently reserve a command tag for
internal commands like we do now; however, it could be that using a
tag number to distinguish an internal command isn't a very good idea
to begin with and it could be better to use a qcflag instead.

Anyways, sata_fsl already has workaround for ATA_TAG_INTERNAL, right?
Given that the situation around internal tag handling may change, I'm
not sure about changing the interface now.  Is it a lot of cruft on
fsl side?

Thanks.

-- 
tejun
