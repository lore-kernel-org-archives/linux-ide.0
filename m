From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux 2.6 SATA NCQ support
Date: Thu, 25 Jan 2007 07:44:14 -0500
Message-ID: <45B8A61E.4010504@garzik.org>
References: <25b3869e0701250407q7fc6996eua411aeaec5a67444@mail.gmail.com> <45B89EC8.8060602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36315 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965275AbXAYMoS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 07:44:18 -0500
In-Reply-To: <45B89EC8.8060602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: V VS <v.vvsrini@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> V VS wrote:
>> Can you  please give us your inputs on why the NCQ depth is not getting
>> set correctly? Should we be looking at any other place for fixing this
>> problem?
> 
> Please give a shot at 2.6.20-rc5.  There was a related bug fix for ahci.

2.6.20-rc6 also has a couple fixes, and is worth a try.

	Jeff



