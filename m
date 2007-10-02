From: Daniel Schroeder <sec@dschroeder.info>
Subject: Re: PMP Patchset against 2.6.22.latest 2.6.23.latest
Date: Tue, 02 Oct 2007 17:58:56 +0200
Message-ID: <47026AC0.7090304@dschroeder.info>
References: <4700FDF6.2080605@dschroeder.info> <47010392.1080505@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53515 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbXJBP7K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 11:59:10 -0400
In-Reply-To: <47010392.1080505@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Daniel Schroeder wrote:
>> i am stuck with 2.6.22.1 because this is the latest version of your PMP
>> patchset...this is perfectly working but i can not apply these set
>> against newer versions of the kernel...could you update your homepage or
>> post a howto/message/link for instructions to get the patchset against
>> 2.6.22.latest and 2.6.23.latest?
> 
> Once you obtain the 'master' and 'upstream' branches of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> you may simply do
> 
>     git diff master..upstream > patch

git-clone
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git master
git diff  master..origin/upstream > patch

worked for me...
> 
> to obtain the diff against current 2.6.23-rcX (what will be 2.6.23
> release).
> 
>     Jeff
thx

Daniel


