From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] libata: switch to using block layer tagging support
Date: Thu, 23 Oct 2008 12:41:34 +0900
Message-ID: <48FFF26E.5040904@kernel.org>
References: <1224661243-7929-1-git-send-email-jens.axboe@oracle.com> <1224661243-7929-3-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32814 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbYJWDlw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 23:41:52 -0400
In-Reply-To: <1224661243-7929-3-git-send-email-jens.axboe@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

Jens Axboe wrote:
> libata currently has a pretty dumb ATA_MAX_QUEUE loop for finding
> a free tag to use. Instead of fixing that up, convert libata to
> using block layer tagging - gets rid of code in libata, and is also
> much faster.
> 
> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
