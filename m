From: Ryan Richter <ryan@tau.solarneutrino.net>
Subject: Re: DVD drive not recognized on Intel G965 (2.6.19-rc2)
Date: Tue, 17 Oct 2006 14:04:20 -0400
Message-ID: <20061017180420.GD24789@tau.solarneutrino.net>
References: <20061013212029.GA19608@tau.solarneutrino.net> <20061014125644.GA13837@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from solarneutrino.net ([66.199.224.43]:11534 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751385AbWJQSEn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Oct 2006 14:04:43 -0400
Content-Disposition: inline
In-Reply-To: <20061014125644.GA13837@gallifrey>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, Oct 14, 2006 at 01:56:44PM +0100, Dr. David Alan Gilbert wrote:
> * Ryan Richter (ryan@tau.solarneutrino.net) wrote:
> > Hi, I have a new machine with an Intel 965G chipset.  There's a DVD
> > drive on the IDE port that I can boot off of, but linux doesn't find it.
> > 
> 
> Hi Ryan,
>   I suspect that the DVD is connected to a JMicron IDE coontroller not
> to the 965 itself? I might be wrong but I'd heard fo a few 965 machines
> like that?
> Try turning that on in the kernel config

I tried the JMicron driver, but it didn't find a controller.  This board
has only one PATA port, and I'm pretty sure it's from the Intel
southbridge.

Thanks,
-ryan
