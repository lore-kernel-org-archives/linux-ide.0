From: Mark Lord <liml@rtr.ca>
Subject: Re: Faulty seagate drives, are going to be blacklisted?
Date: Mon, 26 Jan 2009 14:54:05 -0500
Message-ID: <497E14DD.20506@rtr.ca>
References: <20090120002923.065f24ca@diego-desktop> <49753D09.8060503@shaw.ca> <497E0940.3020409@ij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:40147 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbZAZTyJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 14:54:09 -0500
In-Reply-To: <497E0940.3020409@ij.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felix Miata <mrmazda@ij.net>
Cc: linux-ide@vger.kernel.org

Felix Miata wrote:
..
> The "Drive Detect software" that
> http://seagate.custkb.com/seagate/crm/selfservice/search.jsp?DocId=207957
> directs to use to discover the firmware revision requires windoz. Anyone know
> if it works under Wine? Instead I used a bootable Seatools CD that came in a
> retail Seagate HD package.
..

Under Linux, use this:  hdparm -I /dev/sd? | head -8



