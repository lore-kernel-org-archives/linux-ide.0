From: Jim Paris <jim@jtan.com>
Subject: Re: Off-by-one in both LIBATA and IDE drivers
Date: Tue, 10 Mar 2009 23:03:40 -0400
Message-ID: <20090311030340.GA617@psychosis.jim.sh>
References: <20090311015039.42922.qmail@web4115.mail.ogk.yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a.jim.sh ([75.150.123.25]:54412 "EHLO psychosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbZCKDOe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 23:14:34 -0400
Content-Disposition: inline
In-Reply-To: <20090311015039.42922.qmail@web4115.mail.ogk.yahoo.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norman Diamond <n0diamond@yahoo.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Norman Diamond wrote:
> It looks like both LIBATA and the old IDE drivers have an
> off-by-one error in deciding whether to use READ SECTOR(S)
> instead of READ SECTOR(S) EXT.

Hi,

This was fixed here:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=97b697a11b07e2ebfa69c488132596cc5eb24119

-jim
