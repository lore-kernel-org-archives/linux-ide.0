From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Combined mode on Dell Inspiron 6000 - patch for 2.6.14-rc5 -
 ata_piix.c
Date: Fri, 21 Oct 2005 16:36:15 -0400
Message-ID: <4359513F.7000200@pobox.com>
References: <200510211615.38029.wernerbackes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:48823 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965153AbVJUUgV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2005 16:36:21 -0400
In-Reply-To: <200510211615.38029.wernerbackes@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Werner Backes <wernerbackes@gmail.com>
Cc: linux-ide@vger.kernel.org

Werner Backes wrote:
> Hi,
> 
> I'm no kernel expert at all, but since the combined mode for 2.6.13.x was 
> working and for 2.6.14-rcx not, I looked at the differences in the code. I 
> changed the following line in ata_piix.c. The original code is commented out. 
> Since you only switched the values of both defines the line from 2.6.13.x 
> seemed to make sense....
> Without this change the drive is found, but I cannot use it. No mount, no 
> burning, ...  
> I hope this will help somehow ...

Have you tried 2.6.14-rc5?

It contains a fix for combined mode.

	Jeff



