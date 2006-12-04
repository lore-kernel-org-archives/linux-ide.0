From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Mon, 4 Dec 2006 13:54:59 +0100
Message-ID: <4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
References: <20061130165202.GA23205@aepfle.de>	<20061204123854.GA28159@aepfle.de> <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org> <4574197A.2020204@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:55238 "EHLO
	mail-in-10.arcor-online.net") by vger.kernel.org with ESMTP
	id S936786AbWLDMzT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 07:55:19 -0500
In-Reply-To: <4574197A.2020204@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

>> Please make this run on pSeries only; on a PowerMac for
>> example, it's totally normal that the first PCI legacy I/O
>> BAR in the system gets assigned 0.
>
>    What do you mean by legacy I/O BAR?

Any PCI BAR with bits 1:0 == 0b01.

> If you mean IDE controller, that would drive IDE core mad like this:
>
> W82C105_IDE: inconsistent baseregs (BIOS) for port 0, skipping

So that needs fixing too, then.


Segher

