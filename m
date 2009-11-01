From: Milan Burgdorf <milan@wwwburgdorf.de>
Subject: Re: Request to 2.6.24/patch-sata_promise-limit-sataii-to-1.5Gbps-2.6.24
 because it doesn't work
Date: Sun, 01 Nov 2009 16:44:28 +0100
Message-ID: <4AEDACDC.2010609@wwwburgdorf.de>
References: <200910231231.n9NCVbIV011530@post.webmailer.de> <19169.44382.793296.116944@pilspetsen.it.uu.se> <4AE85B32.7050203@wwwburgdorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:19679 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbZKAPod (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Nov 2009 10:44:33 -0500
Received: from [10.12.79.11] (p54AE7A9A.dip.t-dialin.net [84.174.122.154])
	by post.strato.de (klopstock mo27) (RZmta 22.1)
	with ESMTP id k0566clA1FW356 for <linux-ide@vger.kernel.org>;
	Sun, 1 Nov 2009 16:44:34 +0100 (MET)
In-Reply-To: <4AE85B32.7050203@wwwburgdorf.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

>> the 2.6.32-rc kernel has updates for the controller reset operations
>> which may help get stubborn disks back on line. That patch is available
>> for 2.6.28 to 2.6.31 kernels in the patch repository you mention below.
> 
>> Libata has a generic libata.force= parameter which can be used to tweak
>> various settings, including 1.5Gbps vs 3Gbps. I haven't used it myself,
>> but see Documentation/kernel-parameters.txt for details.
> 

Now I'm using Xubuntu 9.10 with Kernel 2.6.31. "libata.force=1.5Gbps"
parameter at kernel starting works very fine up to now.

During the next days I'll patch the sata_promise module with your
additions to test the "other" way.

Thank you very much! My problem is solved!!!

Milan
