From: Brett Russ <russb@emc.com>
Subject: Re: libata AHCI support for Intel ICH6RW
Date: Fri, 03 Sep 2004 08:03:03 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <ch9mg8$mih$1@sea.gmane.org>
References: <1094184596.16175.3.camel@unicorn.rpratap.homelinux.org> <41385A18.5020103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:28569 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269648AbUICMCV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Sep 2004 08:02:21 -0400
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1C3Cln-00027O-00
	for <linux-ide@vger.kernel.org>; Fri, 03 Sep 2004 14:02:19 +0200
Received: from pseudo-nat-129.isus.emc.com ([128.221.197.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 03 Sep 2004 14:02:19 +0200
Received: from russb by pseudo-nat-129.isus.emc.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 03 Sep 2004 14:02:19 +0200
In-Reply-To: <41385A18.5020103@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Nothing new to add beyond that of
> http://linux.yyz.us/sata/sata-status.html
> 
> AHCI _should_ be going in any day now (well, after Labor Day vacation), 
> so it will appear RSN.

Jeff,

Where you say:
"Preliminary driver with full AHCI support now exists, and is being 
integrated into libata mainline."

I assumed you meant that it exists in your libata-2.6 kernel and was 
going to be integrated into Linus' soon.  If this is true, my report 
deals with your kernel not mainline as in Ravi's case.

If I don't have the kernel with full AHCI support, can I get and test 
it?  If I do have it, it seems like a bug in either BIOS, ata_piix, or 
libata, no?

Thanks
BR

