From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Tue, 07 Aug 2007 08:14:06 +1000
Message-ID: <1186438446.938.81.camel@localhost.localdomain>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48564 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760994AbXHFWOR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Aug 2007 18:14:17 -0400
In-Reply-To: <04ce93c63dfaa543b4068d448c8115d8@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org

On Mon, 2007-08-06 at 20:04 +0200, Segher Boessenkool wrote:
> That's of course the smarter choice, _if_ we have a choice at
> all -- on PowerPC, the PCI setup on certain platforms is done
> by the firmware (and we don't want to mess with it for various
> reasons), and some _do_ map PCI legacy I/O at 0.
> 
> Not in this case though, so let's just ignore that possibility
> until it hits us in the face :-) 

Agreed. We can always try to remap just that device if it becomes an
issue.

Ben.


