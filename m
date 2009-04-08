From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 4/5] ide: Add support for TRIM
Date: Wed, 08 Apr 2009 11:50:00 -0400
Message-ID: <49DCC7A8.9020803@rtr.ca>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <1238683047-13588-2-git-send-email-willy@linux.intel.com> <1238683047-13588-3-git-send-email-willy@linux.intel.com> <1238683047-13588-4-git-send-email-willy@linux.intel.com> <49DCB5A5.7040100@rtr.ca> <49DCBBE2.4050506@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:45277 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbZDHPuE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 11:50:04 -0400
In-Reply-To: <49DCBBE2.4050506@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Wilcox <willy@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, David Woodhouse <David.Woodhouse@intel.com>

Jeff Garzik wrote:
> Mark Lord wrote:
..
>> So it's not obvious exactly why this command even needs data to
>> be transfered.
> 
> It's a list of LBA ranges, like the NV-cache stuff recently added.
..

Ack.  Thanks.  I found the LBA range description (intact) in the drafts now.

-ml
