From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: FYI: SATA on x86-64
Date: Fri, 19 Mar 2004 16:58:45 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <405B6D15.9030600@pobox.com>
References: <405B6B6B.70200@pobox.com> <405B6C6B.4050202@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51162 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262490AbUCSV67
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Mar 2004 16:58:59 -0500
In-Reply-To: <405B6C6B.4050202@stesmi.com>
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Stefan Smietanowski wrote:
> Jeff Garzik wrote:
> 
>>
>> There appear to be a variety of platform problems that lead to trouble 
>> with libata (and also with the IDE driver to some extent), with the 
>> default x86-64 kernel + some buggy BIOSes + some iommu weirdness.
>>
>> Here are some boot options to mix and match:
>>     nomce, iommu=off, noapic, acpi=off
>>
>> And also try using an SMP kernel (CONFIG_SMP) rather than a 
>> uniprocessor one.
> 
> 
> You have any special place where one or several options might be useful?
> 
> I stressed the promise sata on my ASUS K8V with a Maxtor disk yesterday
> and it worked just fine. Under 2.4 that is. And yes, running an x86_64
> kernel.

If you don't need any of those options, then no worries.  You are fine 
as-is.

	Jeff



