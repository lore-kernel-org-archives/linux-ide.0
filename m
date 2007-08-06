From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Mon, 6 Aug 2007 20:52:51 +0100
Message-ID: <20070806205251.3006ad64@the-village.bc.nu>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
	<46B0972C.3020000@ru.mvista.com>
	<20070801165140.3e176cd1@the-village.bc.nu>
	<04ce93c63dfaa543b4068d448c8115d8@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54004 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755930AbXHFTpl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 15:45:41 -0400
In-Reply-To: <04ce93c63dfaa543b4068d448c8115d8@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

O> That's of course the smarter choice, _if_ we have a choice at
> all -- on PowerPC, the PCI setup on certain platforms is done
> by the firmware (and we don't want to mess with it for various
> reasons), and some _do_ map PCI legacy I/O at 0.
> 
> Not in this case though, so let's just ignore that possibility
> until it hits us in the face :-)

An SFF controller mapped at I/O is basically not going to work. Take it
up with the firmware
