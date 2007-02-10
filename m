From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Sat, 10 Feb 2007 09:03:55 -0500
Message-ID: <45CDD0CB.2070608@gmail.com>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com> <200702091527.08447.rootkit85@yahoo.it> <1171032893.8134.13.camel@localhost> <200702091839.52316.rootkit85@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:49227 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113AbXBJOEV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Feb 2007 09:04:21 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1172728wxd
        for <linux-ide@vger.kernel.org>; Sat, 10 Feb 2007 06:04:20 -0800 (PST)
In-Reply-To: <200702091839.52316.rootkit85@yahoo.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matteo Croce <rootkit85@yahoo.it>
Cc: linux-ide@vger.kernel.org

Matteo Croce wrote:
> On Friday 09 February 2007 15:54:53 you wrote:
>> On Fri, 2007-02-09 at 15:27 +0100, Matteo Croce wrote:
>>> +	{ PCI_VDEVICE(INTEL, 0x27c4), board_ahci }, /* ICH7M */
>> Wasn't this PCI ID proposed for addition a while ago, and subsequently
>> rejected?  Or am I missing something?
> 
> rejected? why?

Ah... right.

All ICH7 R/M silicons can be put into either IDE or AHCI mode.  Which 
mode is used is currently determined by BIOS.  If BIOS puts the 
controller into ahci mode on boot, ahci is attached; otherwise, 
ata_piix.  This sometimes reduces confusion level but more importantly 
in some cases it's not possible to use the other mode because PCI 
resource allocation is upto BIOS and it's not guaranteed to allocate all 
the needed resources for the mode not in use.

Till now, the policy to follow BIOS setting has worked well enough. 
Most desktop BIOSen give choice between the two modes anyway.  There 
have been some cases where some desktops and many notebooks where the 
silicon itself is capable of ahci but BIOS doesn't allow it.  It seems 
Mac is one of them.

-- 
tejun
