From: Avi Kivity <avi@argo.co.il>
Subject: Re: DVD drive not recognized on Intel G965 (2.6.19-rc2)
Date: Tue, 17 Oct 2006 21:48:59 +0200
Message-ID: <453533AB.9020801@argo.co.il>
References: <20061017180420.GD24789@tau.solarneutrino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw5.argo.co.il ([194.90.79.130]:33807 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751247AbWJQTtB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Oct 2006 15:49:01 -0400
In-Reply-To: <20061017180420.GD24789@tau.solarneutrino.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ryan Richter wrote:
>
> On Sat, Oct 14, 2006 at 01:56:44PM +0100, Dr. David Alan Gilbert wrote:
> > * Ryan Richter (ryan@tau.solarneutrino.net) wrote:
> > > Hi, I have a new machine with an Intel 965G chipset.  There's a DVD
> > > drive on the IDE port that I can boot off of, but linux doesn't 
> find it.
> > >
> >
> > Hi Ryan,
> >   I suspect that the DVD is connected to a JMicron IDE coontroller not
> > to the 965 itself? I might be wrong but I'd heard fo a few 965 machines
> > like that?
> > Try turning that on in the kernel config
>
> I tried the JMicron driver, but it didn't find a controller.  This board
> has only one PATA port, and I'm pretty sure it's from the Intel
> southbridge.
>

I have a similar board.

Try adding all-generic-ide to the kernel command line, and if that 
fails, post your lspci output.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

