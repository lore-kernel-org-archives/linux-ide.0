From: Tejun Heo <tj@kernel.org>
Subject: Re: nvidia controller failed command, possibly related to SMART selftest
 (2.6.32)
Date: Thu, 25 Mar 2010 09:29:50 +0900
Message-ID: <4BAAAE7E.4020608@kernel.org>
References: <20100313092559.GA14213@piper.oerlikon.madduck.net> <4B9D0BDD.4030706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46642 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677Ab0CYHN5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Mar 2010 03:13:57 -0400
In-Reply-To: <4B9D0BDD.4030706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>

Hello,

On 03/15/2010 01:16 AM, Robert Hancock wrote:
>> If it's of any relevance, the problems also occured with 2.6.26, but
>> the RAID code didn't always eject the disks on that kernel; the
>> first time I encountered a degraded array due to this was shortly
>> after the upgrade to 2.6.32. However, this is speculation, I have
>> not verified the causality.

nv reset code has received several changes during that time frame one
of which being avoiding hardreset unless it's a hotplug situation.
This was necessary because some controllers fail to re-recognize the
attached drive after a hardreset.  This decision was made as losing
drives which can be recovered by SRST is less dangerous than losing
drives which require hardreset after a failure.  NV reset protocols
are very messed up and at this point I don't think it's possible to
make it behave as well as other controllers.  If you're on earlier
NVs, losing disk after an exception condition is something which can
happen from time to time.

>> Generally, SMART self-tests should be a transparent operation that
>> doesn't affect the operating system's use of the devices, right? Is
>> it conceivable or even common that the disks' own controllers are
>> broken to the point where they fall over SMART tests?

Yeah, sure, it definitely is possible.  A good hardreset usually would
put some sense back into the firmware but NV can't do that safely, so
it loses the drive.

Thanks.

-- 
tejun
