From: Mark Lord <liml@rtr.ca>
Subject: Re: 2.6.22-rc3 hibernate(?) disables SMART on ide
Date: Mon, 04 Jun 2007 12:29:25 -0400
Message-ID: <46643DE5.3080904@rtr.ca>
References: <46609290.5030701@dgreaves.com> <46613C53.8010205@gmail.com> <4661E6CA.1080203@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1392 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754899AbXFDQ31 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Jun 2007 12:29:27 -0400
In-Reply-To: <4661E6CA.1080203@dgreaves.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: Tejun Heo <htejun@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, IDE Linux <linux-ide@vger.kernel.org>, ballen@gravity.phys.uwm.edu

David Greaves wrote:
> I have 2 ide disks. If I enable SMART and hibernate/suspend2disk, SMART is
> disabled when I resume.

Just a thought:  This *may* be fixable at the drive, with "hdparm -K1".

Cheers 
