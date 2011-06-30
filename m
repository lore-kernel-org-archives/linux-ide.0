From: David Shaw <dshaw@jabberwocky.com>
Subject: Re: Suppressing ATA errors on boot
Date: Thu, 30 Jun 2011 18:01:21 -0400
Message-ID: <E0B7D7D8-74D4-4DE8-B161-A88E8CAC3D62@jabberwocky.com>
References: <F2FB3B32-A380-40EB-B6DF-02AB30592E3D@jabberwocky.com> <20110630094937.GO3386@htj.dyndns.org> <438EE45C-A01E-4F77-8314-5DF9E8332E21@jabberwocky.com> <20110630163940.GT3386@htj.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from walrus.jabberwocky.com ([173.9.29.57]:59669 "EHLO
	walrus.jabberwocky.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab1F3WB0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jun 2011 18:01:26 -0400
In-Reply-To: <20110630163940.GT3386@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Jun 30, 2011, at 12:39 PM, Tejun Heo wrote:

> Hmmm.... I don't think there's any easy way to suppress the above
> messages; however, the reason why they get printed through is because
> they're marked KERN_ERR, but it isn't necessarily an error condition
> and we should be fine with KERN_WARNING.
> 
> Does the following make the issue go away?

It does, thanks very much!

David

