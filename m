From: Tejun Heo <tj@kernel.org>
Subject: Re: Check for broken HP bioses in ahci.c appears too broad
Date: Mon, 09 Nov 2009 13:29:25 +0900
Message-ID: <4AF79AA5.2030803@kernel.org>
References: <20091106162824.GA23611@srcf.ucam.org> <1257525348.20269.19.camel@o>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60432 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbZKIE33 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Nov 2009 23:29:29 -0500
In-Reply-To: <1257525348.20269.19.camel@o>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: heinzm@redhat.com
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide@vger.kernel.org

Heinz Mauelshagen wrote:
> On Fri, 2009-11-06 at 16:28 +0000, Matthew Garrett wrote:
>> https://bugzilla.redhat.com/show_bug.cgi?id=533402 describes a case 
>> where a machine is falling foul of the hp dv6 check in ahci.c. However, 
>> BIOS version F.04 appears to be the latest available for this machine - 
>> I suspect that the dv6 parameter is too broad and is picking up machines 
>> outside those with the affected BIOSes.
>>
>> Heinz, could you attach the contents of 
>> /sys/devices/virtual/dmi/id/product_name, 
>> /sys/devices/virtual/dmi/id/product_version and 
>> /sys/devices/virtual/dmi/id/bios_*?

Maybe we should use date instead of version?

Thanks.

-- 
tejun
