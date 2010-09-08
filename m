From: Tejun Heo <teheo@suse.de>
Subject: Re: [PATCHSET #upstream] block, fs: replace HARDBARRIER with FLUSH/FUA,
 take#2
Date: Wed, 08 Sep 2010 18:12:18 +0200
Message-ID: <4C87B5E2.6070207@suse.de>
References: <1283509796-1510-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43195 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892Ab0IHQMX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Sep 2010 12:12:23 -0400
In-Reply-To: <1283509796-1510-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jaxboe@fusionio.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-raid@vger.kernel.org, dm-devel@redhat.co

Hello, Jens.

I added Mike's cleanup patch and Kiyoshi's Tested-by and updated
flush-fua branch accordingly.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git flush-fua

I guess it's about ready.  Please consider pulling it into the block
tree so that it can get linux-next exposure.  If you want the whole
patch series resent, please let me know.

Thanks.

-- 
tejun
