From: Florian Effenberger <florian@effenberger.org>
Subject: Re: Serious bug in sata_sil module in 2.6.19.2?
Date: Tue, 06 Feb 2007 11:45:15 +0100
Message-ID: <45C85C3B.4060303@effenberger.org>
References: <45C1BFE0.4080004@effenberger.org> <45C1FBFF.3050706@gmail.com> <45C27A4D.8070802@effenberger.org> <45C82071.5080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:51935 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbXBFKpW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 05:45:22 -0500
In-Reply-To: <45C82071.5080808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi there,

> That definitely looks like libata error messages but can't tell anything
> other than that from it.  It could be cause of system hang and the weird
> screen or just another symptom of another problem.
> 
> Is it possible for you to connect a serial console or configure
> netconsole (Documentation/networking/netconsole.txt) such that the
> messages are preserved after such hang occurs?  Also, please turn on
> PRINTK_TIME (Kernel Hacking -> Show timing information on printks) so
> that we can tell what happens when.  To make the info more useful, you
> can log into the machine from another machine and run something like
> "while true; do sleep 1; date; done" on it such that you can tel exactly
> when the machine went down.

thanks a lot for your feedback. It seems we solved the problem: it was 
the power supplying unit! We change some stuff (memory, cleaned the 
machine and so on), but after changing the power supplying unit, 
everything worked fine. So I guess the new kernel just had a little bit 
more power consumption than the previous one.

Thanks a lot for your kind help, and sorry for the false alert! :-)

Florian
