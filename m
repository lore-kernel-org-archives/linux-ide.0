From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: allow LLDs w/o any reset
	method
Date: Thu, 6 Mar 2008 11:25:32 +0100
Message-ID: <20080306102532.GD13391@elte.hu>
References: <47CF6E7E.6090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:38999 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755551AbYCFKZz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Mar 2008 05:25:55 -0500
Content-Disposition: inline
In-Reply-To: <47CF6E7E.6090201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>


* Tejun Heo <htejun@gmail.com> wrote:

> Some old SFF controllers don't have any way to reset the channel. 
> Currently, this isn't supported and libata EH causes an oops.  Allow 
> LLDs w/o any reset method and just assume ATA class in such cases.

just to make sure, this is a must-have for 2.6.25 - it causes a boot 
regression on one of my boxes.

	Ingo
