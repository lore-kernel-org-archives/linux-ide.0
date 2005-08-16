From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Subject: Re: [linux-usb-devel] PCI quirks not handled and config space differences
 on resume from S3
Date: Tue, 16 Aug 2005 17:44:18 +0200
Message-ID: <430209D2.1000307@gmx.net>
References: <Pine.LNX.4.44L0.0508161131240.18233-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:22754 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030190AbVHPPoA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Aug 2005 11:44:00 -0400
In-Reply-To: <Pine.LNX.4.44L0.0508161131240.18233-100000@iolanthe.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linux-usb-devel@lists.sourceforge.net

Alan Stern schrieb:
> On Tue, 16 Aug 2005, Carl-Daniel Hailfinger wrote:
> 
> 
>>Hi,
>>[...]
>>Besides that, a number of drivers do not restore the pci config
>>space of their associated devices properly on resume from S3.
>>
>>These drivers (and associated devices) are:
>>- uhci_hcd (USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller)
>>[...]
>>Diff between "lspci -vvvxxx" before and after resume for all
>>problematic devices on my machine is attached.
>>
>>Are there any patches I can try?
> 
> 
> The uhci-hcd driver _does_ restore the config space for its devices 
> properly.
> 
>> [lspci dump]
> 
> 
> Just because the before and after values are different doesn't mean 
> anything is wrong.  Those particular bits are set by the hardware in 
> response to various events.  They are used only by the BIOS, to provide 
> USB keyboard and mouse services.  They don't affect the device's function 
> or the Linux driver at all.

Thanks for the information and sorry for bothering you.

> Alan Stern

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
