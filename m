From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Wed, 01 Aug 2007 18:22:36 +0400
Message-ID: <46B0972C.3020000@ru.mvista.com>
References: <20061130165202.GA23205@aepfle.de> <20061204123854.GA28159@aepfle.de> <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org> <4574197A.2020204@ru.mvista.com> <4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org> <45741DDE.4080509@ru.mvista.com> <20061204132124.4f7c50a9@localhost.localdomain> <52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:24123 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758526AbXHAOUi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 10:20:38 -0400
In-Reply-To: <52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Segher Boessenkool wrote:

>> setup-pci is for SFF8038i devices. It therefore knows that for  assigned
>> resources they must be I/O. It also assumes that zero is not a  valid I/O
>> port just like zero is not a valid IRQ. Stick a real IDE resource  at 
>> zero and drivers/ide can't cope.

> But 0 _is_ a valid PCI I/O address.  Do we now have to start

    I wasn't in PCI 2.1 (later the corresponding passage have disppeared).

> using "virtual I/O addresses", analogue to the IRQ situation,
> or can these bad assumptions be fixed instead?

> Segher

WBR, Sergei
