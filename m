From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata AHCI support for Intel ICH6RW
Date: Fri, 03 Sep 2004 08:10:50 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41385F4A.90706@pobox.com>
References: <1094184596.16175.3.camel@unicorn.rpratap.homelinux.org> <41385A18.5020103@pobox.com> <ch9mg8$mih$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14733 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269660AbUICMLF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Sep 2004 08:11:05 -0400
In-Reply-To: <ch9mg8$mih$1@sea.gmane.org>
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org

Brett Russ wrote:
> Jeff Garzik wrote:
> 
>> Nothing new to add beyond that of
>> http://linux.yyz.us/sata/sata-status.html
>>
>> AHCI _should_ be going in any day now (well, after Labor Day 
>> vacation), so it will appear RSN.
> 
> 
> Jeff,
> 
> Where you say:
> "Preliminary driver with full AHCI support now exists, and is being 
> integrated into libata mainline."
> 
> I assumed you meant that it exists in your libata-2.6 kernel and was 
> going to be integrated into Linus' soon.  If this is true, my report 
> deals with your kernel not mainline as in Ravi's case.

"being integrated into libata mainline" means that it has not yet been 
integrated into the libata-2.6 queue.


> If I don't have the kernel with full AHCI support, can I get and test 
> it?  If I do have it, it seems like a bug in either BIOS, ata_piix, or 
> libata, no?

In a few days.  There isn't a public, working version of the AHCI driver 
yet.

	Jeff


