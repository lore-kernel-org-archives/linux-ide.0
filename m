From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: remove unnecessary code
Date: Tue, 12 Jul 2011 16:17:51 +0200
Message-ID: <20110712141751.GA4347@mtj.dyndns.org>
References: <1308242361-28859-1-git-send-email-Gregory.Dietsche@cuw.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:42296 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab1GLOR5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2011 10:17:57 -0400
Content-Disposition: inline
In-Reply-To: <1308242361-28859-1-git-send-email-Gregory.Dietsche@cuw.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Dietsche <Gregory.Dietsche@cuw.edu>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Jun 16, 2011 at 11:39:21AM -0500, Greg Dietsche wrote:
> Compile tested.
> remove unnecessary code that matches this coccinelle pattern
> 	if (...)
> 		return ret;
> 	return ret;
> 
> Signed-off-by: Greg Dietsche <Gregory.Dietsche@cuw.edu>

Acked-by: Tejun Heo <tj@kernel.org>

Jeff?

-- 
tejun
