From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 09:35:50 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085153750.6103.33.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482 8
			840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524 .3	
	2 11	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com><1084920024.3191 .8.
		ca mel@patibmrh9> <40AAA0BA.9040307@pobox.com><8A55CC7D-A9E7-11D8-B31E -00
	3	065635034@ieee.org><6AC5FDFB-AACA-11D8-8B8A-003065635034@ieee.org><6 E36A
	1	1B-AACB-11D8-8B8A-003065635034@ieee.org><A6CE2F32-AAD3-11D8-8B8A-003 0656
	35034@ieee.org> <40AD7FB2.10506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:5873 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265913AbUEUPf7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 11:35:59 -0400
In-Reply-To: <40AD7FB2.10506@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> Keep posting, ...

Thank you for this explicit encouragement.  Knowing that you have heard
me without speaking tells me my guesses at least appear sane at first
glance.  I deeply enjoy the learning, I only hesitate over how much of
it to broadcast here.  I can switch over to a less prominent blog
whenever you like.  I think next:

I will begin again in 2.6.6-bk8 without the auto sense patch of this
thread.

Rather than branching on when auto sense is appropriate, I will try the
simpler, intermediate step, of rudely adding an unsolicited auto sense
to every command, by way of adding fragments of your auto sense patch.

That should let me see which fragment (or combination of fragments)
first causes trouble.

I happen to know I have a robust PATA device: I believe often enough it
will survive such abuses as unsolicited sense, reading x1F0 Data while
BSY:DRQ != 0:1, etc.

Pat LaVarre


