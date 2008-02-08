From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Cable strategy
Date: Fri, 8 Feb 2008 15:56:58 +0000
Message-ID: <20080208155658.7f927b6a@core>
References: <20080208152138.28d5dfdb@core>
	<47AC7911.10700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44890 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753629AbYBHQDz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 11:03:55 -0500
In-Reply-To: <47AC7911.10700@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

On Fri, 08 Feb 2008 10:45:21 -0500
Chuck Ebbert <cebbert@redhat.com> wrote:

> On 02/08/2008 10:21 AM, Alan Cox wrote:
> > +		ata_link_for_each_dev(dev, link) {
> > +			if (!ata_is_40wire(dev))
> > +				return 1;
> > +		}
> 
> 				return 0;  ???

Err yes. That'll teach me to clean up the patch and not re-test all the
cases. I'll post a replacement diff
