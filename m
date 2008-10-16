From: Tejun Heo <tj@kernel.org>
Subject: Re: Stack dump from GIT HEAD if CONFIG_ATA_SFF is not set
Date: Thu, 16 Oct 2008 12:45:20 +0900
Message-ID: <48F6B8D0.7090307@kernel.org>
References: <48F3D8EA.4080708@lwfinger.net> <20081015014128.1bde68cb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35475 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbYJPDrV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Oct 2008 23:47:21 -0400
In-Reply-To: <20081015014128.1bde68cb.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Morton wrote:
> (cc linux-ide)
> 
>> On Mon, 13 Oct 2008 16:25:30 -0700 Larry Finger <Larry.Finger@lwfinger.net> wrote:
>> I am using kernel 2.6.27-Linus-03151-g4480f15b-dirty. On booting a system built
>> with CONFIG_ATA_SFF not set, the following appears in my dmesg output. The
>> "dirtiness" of the kernel is due to some code included to trace down messages
>> coming from the usb system, and is not involved here. If CONFIG_ATA_SFF=y, the
>> message does not appear. From Google results, it seems that this parameter
>> should be set for most systems, but one should get clean runs without it.

Yeap, working on it.  It seems SFF/BMDMA support needs to be separated
out further.

Thanks for the report.

-- 
tejun
