From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Mon, 04 Dec 2006 16:08:46 +0300
Message-ID: <45741DDE.4080509@ru.mvista.com>
References: <20061130165202.GA23205@aepfle.de>	<20061204123854.GA28159@aepfle.de> <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org> <4574197A.2020204@ru.mvista.com> <4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:24093 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S936804AbWLDNHO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 08:07:14 -0500
In-Reply-To: <4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Hello.

Segher Boessenkool wrote:
>>> Please make this run on pSeries only; on a PowerMac for
>>> example, it's totally normal that the first PCI legacy I/O
>>> BAR in the system gets assigned 0.

>>    What do you mean by legacy I/O BAR?

> Any PCI BAR with bits 1:0 == 0b01.

>> If you mean IDE controller, that would drive IDE core mad like this:
>>
>> W82C105_IDE: inconsistent baseregs (BIOS) for port 0, skipping

> So that needs fixing too, then.

    I'd agree here, that check in the IDE code seems like being too x86 
specific. I'm having issues with it as well on MPC85xx/U-Boot...

> Segher

WBR, Sergei
