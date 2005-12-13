From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] libata: implement ata_exec_internal()
Date: Tue, 13 Dec 2005 00:18:57 -0500
Message-ID: <439E59C1.6090002@pobox.com>
References: <20051128164201.GA7530@htj.dyndns.org> <438C0645.3020301@tw.ibm.com> <20051129131717.GA8505@htj.dyndns.org> <43924B5A.1070904@pobox.com> <4392F78A.2040209@gmail.com> <439341C2.5090205@pobox.com> <43994F85.7040300@gmail.com> <20051211042303.GA29403@htj.dyndns.org> <439E54F8.8020304@pobox.com> <439E56E1.1070109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:59080 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751267AbVLMFTH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2005 00:19:07 -0500
In-Reply-To: <439E56E1.1070109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Oh... Sorry, all patches are against the ALL branch.  Do you want me to 
> regenerate them against upstream?

Yes, please.


> Also, I'm currently working on a series of EH improvement patches 
> against the ALL branch.  Would generating patches against upstream be 
> better?

Unfortunately, generating patches against the ALL branch makes a lot of 
sense -- but it's also the worst choice you could make.

Generating patches against the ALL branch means that your patch becomes 
dependent on -all- branches in libata-dev.git, even the branches that 
aren't going upstream for quite a while...  which is generally not what 
you want at all.

ALL is largely for testing and automated push to -mm, but not really for 
developers.

Sometimes you will run into cases where I slacked off on the merge of 
upstream+irq-pio+etc and created a bug, but most of the time the merge 
is easy.  If there are ALL-specific patches, you are welcome to submit 
them separately, with the recogition that any such ALL-specific patch 
would likely be dropped and recreated each time ALL gets blown away, and 
recreated.

	Jeff


