From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET 03/11] new EH implementation, take 3
Date: Sat, 13 May 2006 18:34:37 -0400
Message-ID: <44665EFD.5080306@pobox.com>
References: <11473536873966-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54664 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932372AbWEMWeq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 18:34:46 -0400
In-Reply-To: <11473536873966-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This is part of patchset series described in [T].
> 
> This is the third take of new-EH-implementation patchset.  Changes
> from the last take[L] are
[...]
> [T] http://article.gmane.org/gmane.linux.ide/9957
> [L] http://article.gmane.org/gmane.linux.ide/9540
> [1] http://article.gmane.org/gmane.linux.ide/9959
> [2] http://article.gmane.org/gmane.linux.ide/9984

Aside from one minor requested change, this patchset is ACK'd, but with 
a few comments and worries noted.

Once this goes in we need to move all the drivers over as soon as 
possible, and get them all re-tested.

	Jeff


