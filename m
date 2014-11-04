From: Zlatko Calusic <zcalusic@bitsync.net>
Subject: Re: BUG: AHCI: ata8 port resetting needlessly, slow boot
Date: Tue, 04 Nov 2014 18:54:51 +0100
Message-ID: <545912EB.1020006@bitsync.net>
References: <54564A6C.4060009@bitsync.net> <20141103091116.GA21659@kwain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bitsync.net ([80.83.126.10]:57935 "EHLO bitsync.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbaKDRyy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2014 12:54:54 -0500
In-Reply-To: <20141103091116.GA21659@kwain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org

On 03.11.2014 10:11, Antoine Tenart wrote:
> Hi Zlatko,
>
> Thanks for reporting this!
> Can you give a try to the attached patch, to see if it fixes the issue?
>

Hello Antoine,

First of all, thank you for a quick fix! And then my apologies for a 
delay in replying, suddenly got very busy yesterday...

Just booted the patched kernel (patch applies cleanly to 3.18.0-rc3+), 
and I'm happy to report that your patch fixes the issue, ata8 is again 
reported as DUMMY, and there's no bootup delay anymore. Good job!

Feel free to tag Reported-and-tested-by: Zlatko Calusic 
<zcalusic@bitsync.net>

Best regards,
-- 
Zlatko

