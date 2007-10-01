From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PMP Patchset against 2.6.22.latest 2.6.23.latest
Date: Mon, 01 Oct 2007 10:26:26 -0400
Message-ID: <47010392.1080505@garzik.org>
References: <4700FDF6.2080605@dschroeder.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39653 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbXJAO0a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Oct 2007 10:26:30 -0400
In-Reply-To: <4700FDF6.2080605@dschroeder.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Schroeder <sec@dschroeder.info>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Daniel Schroeder wrote:
> i am stuck with 2.6.22.1 because this is the latest version of your PMP
> patchset...this is perfectly working but i can not apply these set
> against newer versions of the kernel...could you update your homepage or
> post a howto/message/link for instructions to get the patchset against
> 2.6.22.latest and 2.6.23.latest?

Once you obtain the 'master' and 'upstream' branches of 
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

you may simply do

	git diff master..upstream > patch

to obtain the diff against current 2.6.23-rcX (what will be 2.6.23 release).

	Jeff


