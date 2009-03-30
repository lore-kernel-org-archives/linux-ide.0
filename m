From: Tejun Heo <tj@kernel.org>
Subject: Re: lost external eSATA port
Date: Mon, 30 Mar 2009 17:44:29 +0900
Message-ID: <49D0866D.4070200@kernel.org>
References: <gqnpi3$jq2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45368 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754204AbZC3Iol (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Mar 2009 04:44:41 -0400
In-Reply-To: <gqnpi3$jq2$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
Cc: linux-ide@vger.kernel.org

kenneth johansson wrote:
> After an error on the external disk the port no longer work with any disk.
> When the error happened the /dev/sdx was removed. if I change disk its never recreated.
> I get no log output from kernel indicating any type of action at all.
> 
> Is there a way to reset the port ?? 

The device seems to have checked out.  Is it a WD mybook?  Can you
please attach full kernel log including the boot messages?

-- 
tejun
