From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: FYI: SATA on x86-64
Date: Fri, 19 Mar 2004 22:55:55 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <405B6C6B.4050202@stesmi.com>
References: <405B6B6B.70200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:43185 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262244AbUCSV5B
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Mar 2004 16:57:01 -0500
In-Reply-To: <405B6B6B.70200@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Jeff Garzik wrote:

> 
> There appear to be a variety of platform problems that lead to trouble 
> with libata (and also with the IDE driver to some extent), with the 
> default x86-64 kernel + some buggy BIOSes + some iommu weirdness.
> 
> Here are some boot options to mix and match:
>     nomce, iommu=off, noapic, acpi=off
> 
> And also try using an SMP kernel (CONFIG_SMP) rather than a uniprocessor 
> one.

You have any special place where one or several options might be useful?

I stressed the promise sata on my ASUS K8V with a Maxtor disk yesterday
and it worked just fine. Under 2.4 that is. And yes, running an x86_64
kernel.

// Stefan
