From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Analysis of EH on Andi's dying disk and stuff to discuss about
Date: Sun, 30 Mar 2008 03:33:01 -0400
Message-ID: <47EF422D.9060102@garzik.org>
References: <20080328093055.GA16736@basil.nowhere.org> <47EDECE5.50309@gmail.com> <47EEAC3F.2070004@rtr.ca> <47EEB0B4.2050808@garzik.org> <20080330070319.GA7156@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33918 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbYC3HdJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Mar 2008 03:33:09 -0400
In-Reply-To: <20080330070319.GA7156@basil.nowhere.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, ric@emc.com

Andi Kleen wrote:
>> Also, ATAPI sometimes takes quite a while to respond, I've seen, when 
>> media is in the driver.
> 
> Surely ATAPI could get other defaults than disks?

Absolutely.

I was just posting a reminder, since there have been mistakes in the 
past where ATA and ATAPI were given the same defaults, only to find out 
later that was a mistake for ATAPI (since ATA is more often tested, 
usually).

	Jeff



