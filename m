From: Tejun Heo <tj@kernel.org>
Subject: Re: Suppressing ATA errors on boot
Date: Thu, 30 Jun 2011 11:49:37 +0200
Message-ID: <20110630094937.GO3386@htj.dyndns.org>
References: <F2FB3B32-A380-40EB-B6DF-02AB30592E3D@jabberwocky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38148 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab1F3Jtm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jun 2011 05:49:42 -0400
Received: by bwd5 with SMTP id 5so1678883bwd.19
        for <linux-ide@vger.kernel.org>; Thu, 30 Jun 2011 02:49:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <F2FB3B32-A380-40EB-B6DF-02AB30592E3D@jabberwocky.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Shaw <dshaw@jabberwocky.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Wed, Jun 29, 2011 at 11:07:11AM -0400, David Shaw wrote:
> Is there some way to tell libata that those ports shouldn't even be
> probed?  Alternately, is there a way to selectively prevent those
> messages from being logged (without affecting the logging for the
> rest of the boot)?  Or perhaps a third solution?

Can you attach the output of "lspci -nn" and full boot log?

Thanks.

-- 
tejun
