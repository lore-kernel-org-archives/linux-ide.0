From: Ryan Bourgeois <rgb005@latech.edu>
Subject: Re: Raid Problem
Date: Tue, 30 Nov 2004 21:08:54 -0600
Message-ID: <41AD35C6.1020802@latech.edu>
References: <20041130072825.20114.qmail@web51002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from selene.LaTech.edu ([138.47.18.25]:40136 "EHLO LaTech.edu")
	by vger.kernel.org with ESMTP id S261201AbULADJM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Nov 2004 22:09:12 -0500
In-Reply-To: <20041130072825.20114.qmail@web51002.mail.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vahid Modiri <va_modiri@yahoo.com>
Cc: linux-ide@vger.kernel.org

It is software RAID, and therefore not handled by the SATA drivers.  for 
software RAID in Linux, use the RAID kernel drivers.  Alternatively, SIS 
may have a Linux driver available which would detect the RAID arrays 
created in the card's BIOS.

Vahid Modiri wrote:
> Dear sir,
> After compiling 2.6.6 or higher version of kernel in
> Mandrake 10 and considering the SATA_SIS module (for
> SIS180 raid controller) on it , I could not find the
> related striped disk device (Raid 0) after loading the
> module on kernel.
> After modprobing the SATA_SIS , an empty /dev/SCSI
> directory is created.
> Is there any point I didn't consider , or how can I
> find the raid device?
> Any help would be appreciated
> Yours
> Vahid Modiri
> Member of Technical support or IRIB
> 
> 
> 	
> 		
> __________________________________ 
> Do you Yahoo!? 
> Yahoo! Mail - You care about security. So do we. 
> http://promotions.yahoo.com/new_mail
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

