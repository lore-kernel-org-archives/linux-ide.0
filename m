From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem setting dma using pata_it821x driver in vanilla 2.6.23.12
 and gentoo-sources 2.6.23-r3
Date: Wed, 09 Jan 2008 11:43:16 +0900
Message-ID: <478434C4.5000209@gmail.com>
References: <200801051734.18088.marc@fallon.classyad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:55245 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYAICnY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 21:43:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so59775rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 18:43:22 -0800 (PST)
In-Reply-To: <200801051734.18088.marc@fallon.classyad.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Zuckman <marc@fallon.classyad.com>
Cc: linux-ide@vger.kernel.org

Hello,

Marc Zuckman wrote:
> I recently compiled gentoo-sources-2.6.23-r3 and subsequently vanilla 
> 2.6.23.12 , but could not get hdparm v 7.7 (or earlier) to set my it8212f 
> controlled raid array to use dma. 
> 
> From past experience, I have learned that  my raid 1 array (using the it8212f 
> raid controller present on my Gigabyte motherboard ) will not function 
> properly unless it is set to use dma with hdparm. As a result, I execute 
> hdparm -d1 /dev/hde in both the Gentoo boot and ordinary run levels. The 
> system has worked fine with multiple 2.6.x kernels. The last kernel that I 
> have successfully used is 2.6.20-gentoo-r7 (gentoo-sources).

hdparm -d1 isn't supported (yet).  pata_it821x will configure DMA
automatically.

> I have checked linux kernel archives several times and have posted this 
> problem on gentoo forums, but have not been able to find similar reports.
> 
> Perhaps related, but I doubt it, are boot messages that I initially received 
> about disabling speeds > udma 33 due to failure to detect proper cabling on 
> the host side of several ide interfaces (more details unfortunately vague).  
> My cabling is definitely proper.  I haven't noted the cabling messages with 
> recent boot attempts with the problem kernels  and I think (not 100% sure) 
> they were abolished by using the "OBSOLETE" lilo boot loader append 
> commands "ide0=ata66, ide2=ata66"

Can you post full boot log?

-- 
tejun
