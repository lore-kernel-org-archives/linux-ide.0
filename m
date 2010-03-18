From: Tim Small <tim@buttersideup.com>
Subject: Re: understanding the cause of ATA failures
Date: Thu, 18 Mar 2010 22:00:30 +0000
Message-ID: <4BA2A27E.9040704@buttersideup.com>
References: <4BA2A02F.7040200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:55408 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0CRWnE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2010 18:43:04 -0400
In-Reply-To: <4BA2A02F.7040200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Cc: linux-ide@vger.kernel.org

Ludovico Cavedon wrote:

> Is there any way to understand what caused the failures? Is it possible
> to exclude that is was the hard drive, or cable, or controller, or
> kernel fault?
>   

Do the drives have any SMART errors logged?  Any reallocated sectors? 
Do you run smartd, or any other smart data collection?  I've had a load
of trouble with WD drives when smart data collection was enabled. 
Haven't had time to get to the bottom of it, but I suspect a firmware bug.

Tim.
