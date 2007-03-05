From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH/RFC]: recovery from power-up-in-standby feature
Date: Sun, 04 Mar 2007 22:55:12 -0500
Message-ID: <45EB94A0.4010603@rtr.ca>
References: <45EB2F6D.7050407@rtr.ca> <45EB5825.501@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4356 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbXCEDzO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Mar 2007 22:55:14 -0500
In-Reply-To: <45EB5825.501@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff wrote:
> I think we would want to test bit 6 of IDENTIFY DEVICE word 83, issue SET FEATURES - SPIN UP command if set,
> otherwise do a READ VERIFY or some other media access command

The word-2 signature values already give us that information,
and I'm not certain that we can rely upon word 83 even being
"present" when a drive has not spun up.  I see lots of zeros
in the upper words of the IDENTIFY info from drives in this state.

Cheers
