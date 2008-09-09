From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_inic162x  LED enable request
Date: Tue, 09 Sep 2008 09:53:12 +0200
Message-ID: <48C62B68.10502@kernel.org>
References: <804852.47037.qm@web903.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43114 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070AbYIIHzI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Sep 2008 03:55:08 -0400
In-Reply-To: <804852.47037.qm@web903.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Bob Stewart wrote:
> Well, I can try.  But I couldn't figure out how to put the header lines
> which list changes, insertions and deletions.  Sorry, but I'm not using
> git and not familiar with git-diff or any of this formatting stuff.  I have 
> an "a" and a "b" under directory /data/src/linxux-2.6.27-rc5.  I ran the 
> following command to get the diff output that follows:

Oh.. You can generate the summary using diffstat.  Just do diffstat
-p1 < patch and paste the output in.

Thanks.

-- 
tejun
