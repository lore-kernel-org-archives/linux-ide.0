From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Marvel PMP SATA controller
Date: Thu, 30 Sep 2010 09:39:57 -0400
Message-ID: <4CA4932D.6040501@teksavvy.com>
References: <4CA2E33B.70001@gmail.com> <4CA399FD.6030904@teksavvy.com> <4CA3A27B.3030906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:36304 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751907Ab0I3NkE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Sep 2010 09:40:04 -0400
In-Reply-To: <4CA3A27B.3030906@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: linux-ide@vger.kernel.org

On 10-09-29 04:32 PM, Richard wrote:
> On 29/09/10 20:56, Mark Lord wrote:

>> What are you trying to do?
> Hi Mark,
>
> Its an embedded device whereby the one HDD I have does not work with the Marvel PMP. I have the command to send to the PMP controller but I am not an officianado with linux SATA(the code I have is from VxWorks) The drive is confirmed working, but the PMP chip does not default to SATA Generation 1, and this HDD is a bit dumb to figure it out :) - so I have to force the PMP controller to Gen1 mode.
> (I have tons of drives that work just fine, its just this ONE Maxtor drive that is being a pain)
>
> The short - I need to write a command to the SATA controller before this HDD can be recognised.
..

Does the existing libata parameter take care of it for you?

linux/Documentation/kernel-parameters.txt:
eg.  libata.force=[ID:]1.5"   ## replace [ID:] with port[.device] for the PMP and/or HD

