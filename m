From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Sil3114 and Hitachi disks
Date: Mon, 27 Dec 2004 14:58:56 -0500
Message-ID: <41D06980.70909@pobox.com>
References: <Pine.LNX.4.44.0412241621210.16199-100000@kenzo.iwr.uni-heidelberg.de> <Pine.LNX.4.44.0412241822560.16199-100000@kenzo.iwr.uni-heidelberg.de> <20041225044658.GB25088@havoc.gtf.org> <Pine.LNX.4.58.0412271405410.31364@dingo.iwr.uni-heidelberg.de> <20041227133150.GA18020@havoc.gtf.org> <Pine.LNX.4.58.0412271513420.31364@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35020 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261963AbUL0T7A
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Dec 2004 14:59:00 -0500
In-Reply-To: <Pine.LNX.4.58.0412271513420.31364@dingo.iwr.uni-heidelberg.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: linux-ide@vger.kernel.org

Bogdan Costescu wrote:
> On Mon, 27 Dec 2004, Jeff Garzik wrote:
> 
> 
>>RHEL3 is a bit behind the times.
> 
> 
> That's not always a bad thing ;-)
> 
> 
>>In particular it needs one hotfix for all swiotlb platforms
>>(includes Intel's EM64T).  The next update will have it, but the
>>current one does not.
> 
> 
> Is there some patch that I can test ? I tried to comb through Red
> Hat's Bugzilla, but I didn't find anything related.
> Does this fix exist in vanilla 2.4.29-pre3 ?


Yes.

	Jeff


