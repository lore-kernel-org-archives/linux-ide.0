From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.8-rc2] sata_nv.c
Date: Tue, 27 Jul 2004 14:55:28 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4106A520.1070604@pobox.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F95F4@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38812 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266558AbUG0Szp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jul 2004 14:55:45 -0400
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F95F4@hqemmail02.nvidia.com>
List-Id: linux-ide@vger.kernel.org
To: Andrew Chew <achew@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Chew wrote:
> Jeff Garzik wrote:
> 
> 
>>Please fix and resubmit:
>>4) [leak] driver appears to be missing a ->host_free hook, to 
>>free your 
>>nv_host_t structure.
>>
>>+       host = kmalloc(sizeof(nv_host_t), GFP_KERNEL);
> 
> 
> I register a host_stop routine, nv_host_stop(), that frees the host.  Is
> this not the correct way to free the nv_host?

I missed the kfree(), sorry.

	Jeff



