From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] atapi request sense work
Date: Wed, 19 May 2004 18:19:31 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40ABDD73.5010302@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482  	8		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.32	 11	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com><1084920024.3191.8.ca	 mel@patibmrh9>  <40AAA0BA.9040307@pobox.com> <1084998941.4645.69.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41685 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264640AbUESWTo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 18:19:44 -0400
In-Reply-To: <1084998941.4645.69.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
>> 	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
>>...
>> 	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
> 
> 
> What's in dispute for these FIXME?


<shrug>

I don't remember anymore :)

	Jeff



