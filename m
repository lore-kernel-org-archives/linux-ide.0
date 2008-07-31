From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: libata badness
Date: Thu, 31 Jul 2008 16:58:05 -0500
Message-ID: <DAE7C7B4-CE5B-45EB-B3B4-E5491A843CD9@kernel.crashing.org>
References: <95646AC3-5385-4F59-8EBA-20F811168A87@kernel.crashing.org> <20080731210410.GA623@polina.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38612 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758964AbYGaV6Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 17:58:24 -0400
In-Reply-To: <20080731210410.GA623@polina.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>

I figured out the issue.  Its related to the interrupt routing being  
conveyed to the code from the device tree.  We have a missing 'space'  
causing issues.

- k
