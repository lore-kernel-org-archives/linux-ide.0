From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: sata_promise SATA300TX4 "intermittent problems"
Date: Fri, 09 Mar 2007 07:27:24 +0100
Message-ID: <45F0FE4C.7060901@how.dk>
References: <45EECD12.1000506@how.dk> <17903.7366.875191.751728@alkaid.it.uu.se> <45F0393D.80301@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:53950 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993000AbXCIG1f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 01:27:35 -0500
In-Reply-To: <45F0393D.80301@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Hi again,

Peter Favrholdt wrote:
> My feeling is this is not caused by 1.5Gbps or 3.0Gbps operation.
> <...snip>
> My next test will be a plain 2.6.21rc2. Then I'll apply the patches one 
> by one.

I've tested 2.6.21-rc2 which fails (sdc down after 27 minutes & sdd down 
after 46 minutes).

Then I applied just a single patch to 2.6.21-rc2: Mikael Petterssons 
patch to force 1.5Gbps operation and tested again - this time no 
problems at all!

(BTW: both kernels are running with IO-APIC disabled).

I've put results+dmesg output here: http://sata300tx4.gratiswiki.dk/

Best regards,

Peter

