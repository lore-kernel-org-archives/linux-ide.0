From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_promise fails to detect all 4 HDD on the TX4 since 2.6.26
Date: Wed, 25 Feb 2009 18:28:00 +0900
Message-ID: <49A50F20.9060600@kernel.org>
References: <7c8826910902241756j6e2d9c88pc293503e9cbf73ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58593 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753611AbZBYJ1r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 04:27:47 -0500
In-Reply-To: <7c8826910902241756j6e2d9c88pc293503e9cbf73ae@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Cui <cuicui@gmail.com>
Cc: linux-ide@vger.kernel.org

Mike Cui wrote:
> Hi,
> 
> I tried to update to Ubuntu 8.10 from 8.04 last week, and noticed that
> after the update the sata_promise driver can no longer detect all 4
> HDDs that I have plugged into the SATAII300TX4 card. It always reports
> that the link is down on the first port. I also tried booting a gentoo
> kernel with 2.6.26, same problem. However, Ubuntu 8.04 with 2.6.25
> seems fine. Is this a known problem?

Hmm... Can you please install to another disk and try 2.6.28.7 and
post the kernel boot log if it fails too?

Thanks.

-- 
tejun
