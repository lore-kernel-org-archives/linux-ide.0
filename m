From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [PATCH 2.6.22-rc7] libata: fix assigned IRQ reporting
Date: Tue, 10 Jul 2007 23:44:11 +0200
Message-ID: <20070710214411.GA5141@electric-eye.fr.zoreil.com>
References: <20070702214747.GA23182@electric-eye.fr.zoreil.com> <4689A432.6080104@gmail.com> <20070703222205.GA18532@electric-eye.fr.zoreil.com> <468B3126.3080706@gmail.com> <468B3452.6040509@gmail.com> <20070704185936.GA13212@electric-eye.fr.zoreil.com> <468C59B6.1030502@gmail.com> <20070705224536.GA9148@electric-eye.fr.zoreil.com> <468DE3ED.3040100@gmail.com> <20070710182431.GA31264@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:41884 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760012AbXGJWJB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 18:09:01 -0400
Content-Disposition: inline
In-Reply-To: <20070710182431.GA31264@electric-eye.fr.zoreil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Francois Romieu <romieu@fr.zoreil.com> :
[...]
> It works perfectly in 2.6.22 but the .config is not the same.
> 
> I'll report if it makes a difference.

False alarm: I did not update my initrd correctly after 2.6.22-rc6.
The patch worked correctly.

Sorry for the wasted time.

-- 
Ueimor
