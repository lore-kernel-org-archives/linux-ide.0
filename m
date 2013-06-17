From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: cleanup SAT error translation
Date: Mon, 17 Jun 2013 12:48:55 -0700
Message-ID: <20130617194855.GL32663@mtj.dyndns.org>
References: <1371242913-10899-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:37458 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3FQTtB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jun 2013 15:49:01 -0400
Received: by mail-qe0-f48.google.com with SMTP id 2so1924460qea.21
        for <linux-ide@vger.kernel.org>; Mon, 17 Jun 2013 12:49:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371242913-10899-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: linux-ide@vger.kernel.org

Hello, Gwendal.

On Fri, Jun 14, 2013 at 01:48:33PM -0700, Gwendal Grignou wrote:
> Remove duplicate Medium Error Entry.
> Remove the ABRT entry: it is too broad: when only ABRT is set
> we should look at status for more information.
> Only if status does not provide information we set ABORTED_COMMAND
> sense key.
> 
> Tested: When a disk fails, it sets
> Status = 0x71 [DRDY DF ERR] , Error = 0x4 [ABRT]
> Ensure the sense key is HARDWARE_ERROR.
> When there is a simple command syntax error:
> Status = 0x51 [DRDY ERR] , Error = 0x4 [ABRT]
> Ensure the sense key is ABORTED_COMMAND.

But this would trigger "no sense translation" warning.  The
translation in that function is pretty simplistic anyway.  Can you
please update the patch so that there's a comment noting why we aren't
mapping 0x04 and drop the warning?

Thanks.

-- 
tejun
