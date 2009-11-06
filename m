From: Heinz Mauelshagen <heinzm@redhat.com>
Subject: Re: Check for broken HP bioses in ahci.c appears too broad
Date: Fri, 06 Nov 2009 17:35:48 +0100
Message-ID: <1257525348.20269.19.camel@o>
References: <20091106162824.GA23611@srcf.ucam.org>
Reply-To: heinzm@redhat.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:8009 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759334AbZKFQmc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Nov 2009 11:42:32 -0500
In-Reply-To: <20091106162824.GA23611@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On Fri, 2009-11-06 at 16:28 +0000, Matthew Garrett wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=533402 describes a case 
> where a machine is falling foul of the hp dv6 check in ahci.c. However, 
> BIOS version F.04 appears to be the latest available for this machine - 
> I suspect that the dv6 parameter is too broad and is picking up machines 
> outside those with the affected BIOSes.
> 
> Heinz, could you attach the contents of 
> /sys/devices/virtual/dmi/id/product_name, 
> /sys/devices/virtual/dmi/id/product_version and 
> /sys/devices/virtual/dmi/id/bios_*?


Added to bz.

Heinz

