From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: hot plugable?
Date: Fri, 16 Apr 2004 20:51:57 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40808DBD.8060502@clanhk.org>
References: <pan.2004.04.13.18.37.25.709554@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.clanhk.org ([69.93.101.154]:494 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S262579AbUDQBvk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Apr 2004 21:51:40 -0400
In-Reply-To: <pan.2004.04.13.18.37.25.709554@dungeon.inka.de>
List-Id: linux-ide@vger.kernel.org
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-ide@vger.kernel.org

Andreas Jellinghaus wrote:

>Hi is there any ata or sata driver that allows hotplugging with linux?
>
>combined with software raid, could it be configured, so I can replace a
>disk and repair the raid without any reboot necessary?
>  
>
I don't think libata supports it yet, so you're SOL with most serialATA 
controllers.

Only certain hardware supports it (ie 3ware), but sometimes hardware 
performance can be surprising low compared to software RAID solutions.  
You'd have to test to see which solution worked best for you.

-ryan
