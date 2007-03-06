From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 25/30] pata_hpt3x3: clean up by using cable method
Date: Tue, 06 Mar 2007 09:25:34 -0500
Message-ID: <45ED79DE.7000702@garzik.org>
References: <200703061038.l26AcAVD019539@shell0.pdx.osdl.net>	<45ED57BA.4000800@garzik.org> <20070306151959.2c30b606@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54794 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965055AbXCFOZi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 09:25:38 -0500
In-Reply-To: <20070306151959.2c30b606@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@redhat.com

Alan Cox wrote:
>> dropped patches 9-25.
>>
>> they should all be rolled up into a single "update ->cable_detect hook" 
>> patch, as discussed.
> 
> Strongly disagree. Each cable detect for a driver is testable alone which
> means each one is a git bisect point and you can find which driver has
> broken that way.

For most testers, you can generally find out which driver is broken 
through intuition and simple observation, without having to resort to 
git bisect.

	Jeff



