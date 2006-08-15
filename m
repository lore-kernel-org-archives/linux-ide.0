From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: What determines which interrupts are shared under Linux?
Date: Tue, 15 Aug 2006 08:29:43 -0600
Message-ID: <44E1DA57.4010309@shaw.ca>
References: <fa.xiop2gho7OdOydmzXzpUsR5ksXM@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:59566 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030308AbWHOOas (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 10:30:48 -0400
In-reply-to: <fa.xiop2gho7OdOydmzXzpUsR5ksXM@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Heflin <rheflin@atipa.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Roger Heflin wrote:
> Hello,
> 
> On Linux when interrupts are defined similar to below, what defines say
> ide2, ide3 to be on the same interrupt?    The bios, linux, the driver 
> using
> the interrupt?    And can that be controlled/overrode at the 
> kernel/driver level?
> 

Typically this is determined by the hardware routing of the interrupt 
lines on the motherboard, occasionally the BIOS. There isn't usually 
much that can be done about the sharing at the kernel level.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

