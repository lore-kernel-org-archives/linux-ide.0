From: Jeff Garzik <jgarzik@pobox.com>
Subject: FYI: SATA on x86-64
Date: Fri, 19 Mar 2004 16:51:39 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <405B6B6B.70200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39642 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262238AbUCSVvw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Mar 2004 16:51:52 -0500
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org


There appear to be a variety of platform problems that lead to trouble 
with libata (and also with the IDE driver to some extent), with the 
default x86-64 kernel + some buggy BIOSes + some iommu weirdness.

Here are some boot options to mix and match:
	nomce, iommu=off, noapic, acpi=off

And also try using an SMP kernel (CONFIG_SMP) rather than a uniprocessor 
one.

	Jeff




