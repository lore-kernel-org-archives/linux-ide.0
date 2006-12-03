From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-dev.git rebased
Date: Sun, 03 Dec 2006 18:22:10 +0900
Message-ID: <45729742.60006@gmail.com>
References: <457102DF.5020407@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:25831 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S935711AbWLCJWS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 04:22:18 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1722218nze
        for <linux-ide@vger.kernel.org>; Sun, 03 Dec 2006 01:22:17 -0800 (PST)
In-Reply-To: <457102DF.5020407@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> 2) Tejun, I'll have to ask you to rebase your 'upstream' branch again.

No problem.  It's at the usual location.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream
  git://htj.dyndns.org/libata-tj tj-upstream

Also, the following patch really should go in.

  [PATCH] pata_cs5535: add missing comma in pci_driver initializer
  http://article.gmane.org/gmane.linux.ide/14283

And, the following fix is critical on many machines.  After determining
how to do it and some testing, this should go into 2.6.19.X, IMO.

  [PATCH] ahci: do not powerdown during initialization
  http://thread.gmane.org/gmane.linux.ide/14138/focus=14138

Thanks.

-- 
tejun
