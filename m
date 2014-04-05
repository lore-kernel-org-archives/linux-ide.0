From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Bad DMA from Marvell 9230
Date: Fri, 04 Apr 2014 20:35:03 -0600
Message-ID: <533F6BD7.4000301@gmail.com>
References: <1395903457.5569.89.camel@pasglop> <20140327151915.GF18503@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140327151915.GF18503@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 27/03/14 09:19 AM, Tejun Heo wrote:
> On Thu, Mar 27, 2014 at 05:57:37PM +1100, Benjamin Herrenschmidt wrote:
>> I've contacted Marvell, but I was wondering if anybody here had already
>> experienced something similar or has an idea of what else the chip
>> might be doing wrong so we can try to find a workaround ?
>
> No idea.  First time to hear such problem. :(
>

There are other Marvell controllers that do DMA requests from the wrong 
PCI function ID and cause IOMMU issues, so it seems like testing on such 
systems (or just validating the DMA transactions done by the controller 
by some other means) isn't something that Marvell likes to do. 
Presumably reading from address 0 is normally fine without an IOMMU, so 
this problem wouldn't be noticed otherwise.
