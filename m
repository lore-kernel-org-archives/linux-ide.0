From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: ahci: find eSATA ports and flag them as removable
Date: Fri, 16 Oct 2015 08:54:09 -0400
Message-ID: <20151016125409.GA20700@htj.duckdns.org>
References: <1443640225-11860-1-git-send-email-manuel.lauss@gmail.com>
 <20150930213910.GG2627@mtj.duckdns.org>
 <5620F09A.9010909@start.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35527 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093AbbJPMyN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Oct 2015 08:54:13 -0400
Received: by ykaz22 with SMTP id z22so80886039yka.2
        for <linux-ide@vger.kernel.org>; Fri, 16 Oct 2015 05:54:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5620F09A.9010909@start.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@start.ca>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, linux-ide@vger.kernel.org

Hello, Mark.

On Fri, Oct 16, 2015 at 08:42:02AM -0400, Mark Lord wrote:
> >Applied to libata/for-4.4.  Let's see what happens.
> 
> Ugh.  Yet another revert to include in my own builds, I guess.

Hmmm... what other patches are you reverting?

> eSATA is used for permanent storage expansion with port-multipliers,
> and having to stop command queuing frequently for useless polling
> is gonna be a performance drain.

What would poll it regularly?

Thanks.

-- 
tejun
