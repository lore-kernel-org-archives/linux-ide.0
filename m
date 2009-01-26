From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Faulty seagate drives, are going to be blacklisted?
Date: Mon, 26 Jan 2009 15:57:42 -0500
Message-ID: <200901261557.42752.gene.heskett@verizon.net>
References: <20090120002923.065f24ca@diego-desktop> <497E0940.3020409@ij.net>
 <497E14DD.20506@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:41060 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbZAZU6J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 15:58:09 -0500
Received: from coyote.coyote.den ([141.153.72.151]) by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KE300KIBJK76MO7@vms173001.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 26 Jan 2009 14:57:43 -0600 (CST)
In-reply-to: <497E14DD.20506@rtr.ca>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Felix Miata <mrmazda@ij.net>, linux-ide@vger.kernel.org

On Monday 26 January 2009, Mark Lord wrote:
>Felix Miata wrote:
>..
>
>> The "Drive Detect software" that
>> http://seagate.custkb.com/seagate/crm/selfservice/search.jsp?DocId=207957
>> directs to use to discover the firmware revision requires windoz. Anyone
>> know if it works under Wine? Instead I used a bootable Seatools CD that
>> came in a retail Seagate HD package.
>
>..
>
>Under Linux, use this:  hdparm -I /dev/sd? | head -8
>
Should I be worried about this one? Seagate 500GB sata

/dev/sdb:

ATA device, with non-removable media
        Model Number:       ST3500320AS
        Serial Number:      9QM5BB7Y
        Firmware Revision:  SD15
        Transport:          Serial

Thank you

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
QOTD:
	"I used to be an idealist, but I got mugged by reality."
