From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Wed, 16 Feb 2005 12:25:49 -0500
Message-ID: <4213821D.1030203@pobox.com>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14036 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262087AbVBPR0N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2005 12:26:13 -0500
In-Reply-To: <42132803.2080701@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org

Brad Campbell wrote:
> Brad Campbell wrote:
> 
>> Woke up to this, this morning.
>> This is yesterdays 2.6.11-rc4 BK + libata BK + libata-dev BK
>> It was in the middle of a RAID-6 rebuild (scheduled to take about 740 
>> minutes)
>>
> 
> Oh well, it appears to be reproducible anyway!

Reproducible without the libata-dev patch?

Reproducible with the current libata driver... on an older kernel?  Say 
2.6.11-rc4 libata with 2.6.10.

	Jeff


