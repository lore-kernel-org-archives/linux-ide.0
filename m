From: Jeff Garzik <jeff@garzik.org>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Sat, 03 Nov 2007 08:34:41 -0400
Message-ID: <472C6AE1.30104@garzik.org>
References: <47274A5F.6070409@gentoo.org>	<20071030153417.59b9182c@the-village.bc.nu>	<47276DCA.1000808@gentoo.org>	<20071030190153.373c9347@the-village.bc.nu>	<47278439.4030801@gentoo.org>	<20071031114958.210bd7cc@the-village.bc.nu>	<20071031115754.GK5059@kernel.dk>	<4729A0DF.20800@garzik.org>	<20071101105335.1f20bab3@the-village.bc.nu>	<4729B3EA.6040707@garzik.org> <20071101141501.3746cec2@the-village.bc.nu> <4729F1BB.20306@gentoo.org> <4729F8F1.4040103@gmail.com> <472B946F.4030004@gentoo.org> <472BCC18.7070503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40340 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459AbXKCMev (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2007 08:34:51 -0400
In-Reply-To: <472BCC18.7070503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Daniel Drake <dsd@gentoo.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <jens.axboe@oracle.com>, linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

Tejun Heo wrote:
> Does this patch fix the problem?
[snip]

I hope it does...  that patch removes a call to sg_last() and in general 
cleans up the function a bit, which is nice.

	Jeff




