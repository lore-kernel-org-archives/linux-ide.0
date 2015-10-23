From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: add support for NCQ commands for SG interface
Date: Fri, 23 Oct 2015 14:39:45 +0900
Message-ID: <20151023053945.GA24618@mtj.duckdns.org>
References: <1445082519-8160-1-git-send-email-vinayak.kale@seagate.com>
 <CACLWs=VWXTd6ZcDQCGXHkngf72RpiqDVkZKXrWJC7Rmx_giWsA@mail.gmail.com>
 <20151022085717.GB24379@mtj.duckdns.org>
 <CAAtun4jvUaVsGSofq5n-sJzmSf4qBsPvQ7WU6dOik4JYSMnZNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35540 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbbJWFjw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 01:39:52 -0400
Content-Disposition: inline
In-Reply-To: <CAAtun4jvUaVsGSofq5n-sJzmSf4qBsPvQ7WU6dOik4JYSMnZNw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vinayak Kale <vinayak.kale@seagate.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Vinayak Kale <vinayak.kale@gmail.com>, sumit.g.gupta@seagate.com

Hello,

On Fri, Oct 23, 2015 at 10:01:35AM +0530, Vinayak Kale wrote:
> > It looks like it'd work given that it's forcing qc->tag into
> > tf->nsect.  What's the use case tho?
> 
> We need to issue NCQ commands with priority bit from user space application.
> 
> BTW, Sergei Shtylyov raised concern regarding usefulness of adding
> ATA_TFLAG_LBA to tf->flags. Can you please comment on that as well?
> Accordingly I will either keep it or discard it in V2. Thanks.

I like the change but can you please put that in a separate patch?
Also, can you please verify that this works fine with multiple regular
NCQ commands in flight?

Thanks.

-- 
tejun
