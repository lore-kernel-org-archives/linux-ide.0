From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [t13] RE: comment on T10 ATA-passthru
Date: Fri, 29 Oct 2004 15:43:11 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041029194311.GA27218@havoc.gtf.org>
References: <A9B8FF43A76C0D42A80DDD73CF99BEC80548967B@azsmsx407> <20041029142539.A29944@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:34191 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263481AbUJ2Tqc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Oct 2004 15:46:32 -0400
Content-Disposition: inline
In-Reply-To: <20041029142539.A29944@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linville@redhat.com, linux-ide@vger.kernel.org



BTW, can you send me a patch that filters out
SET FEATURES - XFER MODE ?

That should not be executed without driver intervention /
synchronization.

	Jeff



P.S.  Any news on hotplug?

