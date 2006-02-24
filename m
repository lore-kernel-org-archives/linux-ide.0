From: Kumar Gala <galak@kernel.crashing.org>
Subject: unloading of module IDE drivers?
Date: Fri, 24 Feb 2006 13:59:15 -0600 (CST)
Message-ID: <Pine.LNX.4.44.0602241347250.6867-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:24218 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932444AbWBXUIr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2006 15:08:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

In missing around with a module IDE driver I'm working on I was able to 
unload the driver while a disk that was using the driver was still 
mounted.

I came across some discussion from 2004 about the fact that the IDE layer 
didn't ref count properly.  Is this still an issue?  Should I remove 
module_exit() from my driver or is there a way to check that the driver 
shouldn't be unloaded?

thanks

- kumar

