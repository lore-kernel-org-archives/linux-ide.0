From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 2/2] libata: New driver for OCTEON SOC Compact Flash interface
 (v2).
Date: Tue, 25 Nov 2008 09:37:59 -0800
Message-ID: <492C37F7.5060509@caviumnetworks.com>
References: <492B56B0.9030409@caviumnetworks.com>	<1227577181-30206-2-git-send-email-ddaney@caviumnetworks.com>	<492C2EE2.3090702@garzik.org>	<492C3509.8010408@caviumnetworks.com> <20081125173401.44c28e17@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10326 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbYKYRiF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Nov 2008 12:38:05 -0500
In-Reply-To: <20081125173401.44c28e17@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Alan Cox wrote:
>> system.  The only recourse is to cycle power to the board.  By allowing 
>> DMA to be disabled, we eliminate this problem.
> 
> You can already do this via the existing libata option functions that
> Tejun added a while back, or there is libata.dma=0 which is applied to
> all interfaces.
> 

Great, I will remove our driver's option.

David Daney
