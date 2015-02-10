From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: fixup return type of wait_for_completion_timeout
Date: Tue, 10 Feb 2015 09:53:41 -0500
Message-ID: <20150210145341.GJ3220@htj.duckdns.org>
References: <1423557576-18984-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35882 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbbBJOxp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Feb 2015 09:53:45 -0500
Content-Disposition: inline
In-Reply-To: <1423557576-18984-1-git-send-email-hofrat@osadl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 10, 2015 at 03:39:36AM -0500, Nicholas Mc Guire wrote:
> -	if (!rc) {
> +	if (irq_timeout == 0) {

Why == 0 tho?  This always bothers me.  To match this style, we'd use
!= 0 to test the other direction.  In what way is "if (ret != 0)"
better than "if (ret)"?  We're negating the two tests needlessly.

Thanks.

-- 
tejun
