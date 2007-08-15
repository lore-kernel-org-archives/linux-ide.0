From: Tejun Heo <htejun@gmail.com>
Subject: Re: Still having problems with sata_promise on all late kernels -
 shutdown too - BISECTED
Date: Wed, 15 Aug 2007 16:50:30 +0900
Message-ID: <46C2B046.7060708@gmail.com>
References: <46C11BBE.6010802@wasp.net.au> <46C1316F.4010906@wasp.net.au> <46C1DB92.7080806@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:20167 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbXHOHul (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 03:50:41 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1661165rvb
        for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 00:50:41 -0700 (PDT)
In-Reply-To: <46C1DB92.7080806@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org

Brad Campbell wrote:
> Brad Campbell wrote:
> 
>> http://www.fnarfbargle.com/CIMG1029.JPG (I have posted this screen
>> shot previously. It's still doing exactly the same thing on both boxes).
>>
> 
> git-bisect shows up this commit as the guilty party. I can't just revert
> it on a recent tree though.
> Will investigate further.

Weird.  Does 'hdparm -y /dev/sdX' work?

-- 
tejun
