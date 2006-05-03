From: Ric Wheeler <ric@emc.com>
Subject: Re: Problem with disk
Date: Wed, 03 May 2006 16:08:12 -0400
Message-ID: <44590DAC.6010107@emc.com>
References: <1146686495.6540.35.camel@montroll.chem.mcgill.ca>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:36017 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750800AbWECUIW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 May 2006 16:08:22 -0400
In-Reply-To: <1146686495.6540.35.camel@montroll.chem.mcgill.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David.Ronis@McGill.CA
Cc: linux-ide@vger.kernel.org

David Ronis wrote:

>I notice from hdparm that disk write caching is turned on.  Any chance
>that there is a problem with the cache not being flushed before powering
>down?
>
>I'm running Linux-2.6.15.5 on what is otherwise a slackware-10.2
>install.
>
>David
>
>
>  
>
While linux has support for write barriers (that allow you to run safely 
with the write cache enabled), it needs support from the drive. 

I would suggest that you should run with the write cache disabled unless 
you can verify working barrier support.

The fact that your drive reports IO errors is also worrying - you might 
just have a bad drive...  You can look at drive help with tools like 
smartctl.

Good luck,

ric

