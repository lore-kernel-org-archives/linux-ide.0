From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ULI 5288(SATA driver)
Date: Mon, 25 Feb 2008 17:57:55 -0500
Message-ID: <47C347F3.5070006@pobox.com>
References: <C86899CCB10A6C4E93D5978DCB232D4B07A941EB@GDCMX01.igglobal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48902 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759476AbYBYW55 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 17:57:57 -0500
In-Reply-To: <C86899CCB10A6C4E93D5978DCB232D4B07A941EB@GDCMX01.igglobal.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saumendra Dash <Saumendra.Dash@infogain.com>
Cc: linux-ide@vger.kernel.org

Saumendra Dash wrote:
> Hi Jeff,
> 
>  I'm working on ULI1575 SATA driver which I want to run in Emulated-PATA 
> mode.
>  I have the following understanding to run a SATA device in 
> Emulated-PATA mode:
> 
>   1. In Emulated-PATA mode the legacy IDE driver should access the SATA 
> device directly in combined mode.
>   2. The class code of the device shlould be set to Emulated-PATA 
> mode(0x0185).
>   3. Enable SATA in combine mode. 
> 
>  After doing the above changes the driver does not work in Emulated-PATA 
> mode.
> 
>  Is there something missing to make the driver work in Emulated-PATA mode?

Use a PCI quirk to unconditionally disable emulated PATA mode, because 
it's not needed.

	Jeff



