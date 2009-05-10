From: Tejun Heo <htejun@gmail.com>
Subject: Re: [GIT PATCH] block: unify request processing model and implement
 peek/fetch
Date: Sun, 10 May 2009 20:28:02 +0900
Message-ID: <4A06BA42.2050107@gmail.com>
References: <1241751256-17435-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:10828 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbZEJL2J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 May 2009 07:28:09 -0400
In-Reply-To: <1241751256-17435-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, rusty@rustcorp.com.au, James.Bottomley@HansenPartnership.com, mike.miller@hp.com, donari75@gmail.c

Tejun Heo wrote:
> All changes have been compile tested.  libata, ide, hd and ubd_kern
> are verified to work.  Waiting for floppy media to test it.

Floppy verified to work.

Thanks.

-- 
tejun
