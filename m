From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 10 Oct 2007 09:20:26 -0600
Message-ID: <20071010152026.GA1616@cosmic.amd.com>
References: <yq14ph8xg3z.fsf@sermon.lab.mkp.net>
 <470C2A16.1040606@garzik.org> <yq1641flhbc.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:47048 "EHLO
	outbound4-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753983AbXJJPU2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 11:20:28 -0400
In-Reply-To: <yq1641flhbc.fsf@sermon.lab.mkp.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On 10/10/07 00:33 -0400, Martin K. Petersen wrote:
> >>>>> "Jeff" == Jeff Garzik <jeff@garzik.org> writes:
> 
> Jeff> Just FWIW...  one you guys are happy with things, I'm ready to
> Jeff> merge the driver whenever.
> 
> I'm waiting for Jordan to get back to me with feedback on test results
> on other boards as well as preference wrt. MSR or PCI configuration...

I never heard back from anybody - so either nobody is using pata_amd
(which I suspect), or they didn't have any problems.  Go ahead and merge,
and I'll do a sanity check on a few boards next week just to make sure.

Thanks,
Jordan

> -- 
> Martin K. Petersen	Oracle Linux Engineering
> 
> 
> 

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.


