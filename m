From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH Linux 2.6.12 00/09] NCQ: generic NCQ completion/error-handling
Date: Mon, 27 Jun 2005 16:33:44 +0200
Message-ID: <20050627143344.GI11633@suse.de>
References: <20050626152105.D86561FB@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:26331 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261779AbVF0OcX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2005 10:32:23 -0400
Content-Disposition: inline
In-Reply-To: <20050626152105.D86561FB@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, Jun 27 2005, Tejun Heo wrote:
>  Hello, Jeff.
>  Hello, Jens.
> 
>  This patchset implements generic completion and error-handling for
> NCQ commands.  This patchset assumes that the previous six misc
> patches to NCQ are applied.

Excellent, much needed work in that area. I will give it a test spin
here as well, I have one drive that likes to barf with ncq occasionally.

-- 
Jens Axboe

