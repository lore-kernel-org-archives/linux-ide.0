From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Need help understanding SATA error message.
Date: Fri, 28 Mar 2008 09:40:37 -0400
Message-ID: <47ECF555.6050000@garzik.org>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33482 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbYC1Nkk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Mar 2008 09:40:40 -0400
In-Reply-To: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomas Lund <tlund@nxs.se>
Cc: linux-ide@vger.kernel.org

Tomas Lund wrote:
> Hello,
> 
> I have a SuperMicro X7SBi with ICH9R SATA running 64bit linux 2.6.24.4. 
> I have 4 1TB disks connected to the motherboard, and one of the disks is 
> logging an error message. Everything is brand new, and hooked up just a 
> few weeks ago.
> 
> S.M.A.R.T. shows no errors (see output from "smartctl -a" at the bottom 
> of this email) after running both a short and long offline selftest, and 
> my question is if its possible to tell from this error message what the 
> problem is. The result "51/04:00:0a:24:f9" is a bit crypting to me, and 
> it would be nice to know what the problem actually is before returning 
> the disk.

What a coincidence :)  The ata wiki, just created yesterday, had a new 
page added yesterday:

	http://ata.wiki.kernel.org/index.php/Libata_error_messages

Regards,

	Jeff



