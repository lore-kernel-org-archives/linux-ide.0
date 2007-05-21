From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Add Seagate STT20000A to DMA blacklist.
Date: Mon, 21 May 2007 12:19:27 -0600
Message-ID: <4651E2AF.2080109@shaw.ca>
References: <fa.6aGWKqGWP2vDWJvVhFqggIUaWVk@ifi.uio.no>
 <fa.70JldrzRTUl84Jt2lSquANqNr2Q@ifi.uio.no>
 <fa.xozW+S/WBbGA8Gv2z3FmAe/XymA@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:12012 "EHLO
	pd4mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701AbXEUSU4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 14:20:56 -0400
In-reply-to: <fa.xozW+S/WBbGA8Gv2z3FmAe/XymA@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org

Dave Jones wrote:
> On Mon, May 21, 2007 at 05:15:51PM +0100, Alan Cox wrote:
>  > On Mon, 21 May 2007 10:50:42 -0400
>  > Dave Jones <davej@redhat.com> wrote:
>  > 
>  > > http://bugzilla.kernel.org/show_bug.cgi?id=1044
>  > > has been open for _four_ years with a patch available.
>  > > Here's a rediffed version of the same.
>  > 
>  > Please update libata as well when you udpate the blacklists.
> 
> Sure, point me at the table(s) ?
> 
> 	Dave
> 

ata_device_blacklist in drivers/ata/libata-core.c

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

